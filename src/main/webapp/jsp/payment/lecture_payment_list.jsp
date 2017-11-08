<%@ page import="com.flowedu.util.Util" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 6;
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String student_name = StringUtil.convertParmeterStr(request.getParameter("student_name"), "UTF-8");
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/paymentService.js'></script>
<script>

if (get_browser_type() != "IE") {
    alert("크롬이나 사파리에서는 결제기능이 안됩니다.\n익스플로러로 실행해주세요.");
}

function init() {
    fn_search("new");
}

function fn_search(val) {
    var student_id = getInputTextValue("studentId");
    var paging = new Paging();
    var sPage = $("#sPage").val();

    if(val == "new") {
        sPage = "1";
    }
    gfn_emptyView("H", "");

    lectureService.getLecturePaymentListCount(student_id, function(cnt) {
        paging.count(sPage, cnt, 10, 10, comment.blank_list);

        dwr.util.removeAllRows("dataList");

        lectureService.getLecturePaymentList(student_id, function (selList) {
            if (selList.length < 0) return;
            dwr.util.addRows("dataList", selList, [
                function(data) {return data.lectureName},
                function(data) {return getDateTimeSplitComma(data.createDate);},
                function(data) {return addThousandSeparatorCommas(data.lecturePrice);},
                function(data) {return data.lectureStartDate;},
                function(data) {return data.lectureEndDate;},
                function(data) {return data.paymentYn == false && data.paymentPrice == 0 ? "결재금액 책정전" : addThousandSeparatorCommas(data.paymentPrice)},
                function(data) {return data.paymentDate == undefined ? "" : getDateTimeSplitComma(data.paymentDate);},
                function(data) {return data.paymentYn == false ? "<button class='btn_pack white' type='button' id='"+ data.lectureRelId + "' onclick='javascript:cacl_lecture_price(this.id);'>수납하기</button>" : "수납완료";},
            ], {escapeHtml:false});
        });
    });
}
//수납버튼 이벤트
function cacl_lecture_price(lecture_rel_id) {
    lectureService.getLectureStudentRelInfo(lecture_rel_id, function(relInfo) {
        var regDate = getDateTimeSplitComma(relInfo.createDate);
        var splDate = gfn_split(regDate, " ");
        var splDate2 = gfn_split(splDate[0], "-");
        var splDate3 = gfn_split(splDate2[0], "-");
        var regDay = splDate2[1];
        var regYear = splDate3[0];
        var regMonth = splDate3[1];
        var lastDay = get_month_lastday(regYear, regMonth);

        var minusDay = lastDay - regDay;
        var calcLecturePrice = relInfo.lecturePrice / lastDay;

        innerValue("lecture_rel_id", lecture_rel_id);
        innerValue("payment_price", roundMarks(calcLecturePrice * minusDay));
        innerHTML("l_lectureName", relInfo.lectureName);
        innerHTML("l_lecturePrice", addThousandSeparatorCommas(relInfo.lecturePrice));
        innerHTML("l_minusDay", minusDay);
        innerHTML("l_calcLecturePrice", addThousandSeparatorCommas(roundMarks(calcLecturePrice * minusDay)));
        gfn_display("payment_section", true);
    });
}

function payment_lecture() {
    var lectureRelId = getInputTextValue("lecture_rel_id");
    var paymentPrice = getInputTextValue("payment_price");
    if (confirm(addThousandSeparatorCommas(paymentPrice) + "원을 결제하시겠습니까?")) {
        paymentService.paymentLecture(lectureRelId, '<%=student_name%>' , paymentPrice, function (result) {
            if (result == 200) {
                alert("결제완료됬습니다.");
                isReloadPage(true);
            } else {
                alert(comment.error);
            }
        });
    }
}

function Button4_onclick() {
    //CF 요청
    kisPosOcx.Init();
    kisPosOcx.inSpecType = "CATUPLOAD";

    kisPosOcx.inCatPortNo = Text_port.value;
    kisPosOcx.inCatBaudRate = Text_BaudRate.value;

    //신용승인
    if (Radio1.checked)
        kisPosOcx.inTranCode = "D1";
    //신용취소
    if (Radio2.checked)
        kisPosOcx.inTranCode = "D2";
    //현금영수증 승인
    if (Radio3.checked)
        kisPosOcx.inTranCode = "CC";
    //현금영수증 취소
    if (Radio4.checked)
        kisPosOcx.inTranCode = "CR";
    /*
    if (Radio5.checked) {
        kisPosOcx.inTranCode = "H1";
        kisPosOcx.inTranGubun = "1";
    }

    if (Radio6.checked) {
        kisPosOcx.inTranCode = "H1";
        kisPosOcx.inTranGubun = "2";
    }

    if (Radio7.checked) {
        kisPosOcx.inTranCode = "H1";
        kisPosOcx.inTranGubun = "3";
    }

    if (Radio7.checked) {
        kisPosOcx.inTranCode = "H1";
        kisPosOcx.inTranGubun = "4";
    }
    */

    kisPosOcx.inTranAmt = Text_TranAmt.value;
    kisPosOcx.inVatAmt = Text_VatAmt.value;
    kisPosOcx.inSvcAmt = Text_SvcAmt.value;
    kisPosOcx.inInstallment = Text_Installment.value;
    kisPosOcx.inOrgAuthDate = Text_OrgAuthDate.value;
    kisPosOcx.inOrgAuthNo = Text_OrgAuthNo.value;

    if(Checkbox1.checked)
        kisPosOcx.inPrintYN = "Y";
    else
        kisPosOcx.inPrintYN = "N";

    if (Checkbox2.checked)
        kisPosOcx.inCatMessageYN = "Y";
    else
        kisPosOcx.inCatMessageYN = "N";

    if (Checkbox2.checked)
        kisPosOcx.inCatBtnYN = "Y";
    else
        kisPosOcx.inCatBtnYN = "N";

    var reVal =  kisPosOcx.KIS_Approval();

    alert(reVal);

    if (reVal == 0) {
        alert(kisPosOcx.inTranCode);
        var lectureRelId = getInputTextValue("lecture_rel_id");
        var paymentPrice = outTranAmt;

        lectureService.calcLecturePaymentPrice(lectureRelId, paymentPrice, "MINUS", function() {
            alert("결제 완료 되었습니다.")
        });

        var strTemp2 = "단말기번호 : [" + kisPosOcx.outCatId + "]"
            + "\n카드번호 : [" + kisPosOcx.outCardNo + "]"
            + "\n할부개월 : [" + kisPosOcx.outInstallment + "]"
            + "\n거래금액 : [" + kisPosOcx.outTranAmt + "]"
            + "\n부가세액 : [" + kisPosOcx.outVatAmt + "]"
            + "\n봉사료 : [" + kisPosOcx.outSvcAmt + "]"
            + "\n승인번호 : [" + kisPosOcx.outAuthNo + "]"
            + "\n거래일자 : [" + kisPosOcx.outReplyDate + "]"
            + "\n매입사코드 : [" + kisPosOcx.outAccepterCode + "]"
            + "\n매입사명 : [" + kisPosOcx.outAccepterName + "]"
            + "\n발급사코드 : [" + kisPosOcx.outIssuerCode + "]"
            + "\n발급사명 : [" + kisPosOcx.outIssuerName + "]"
            + "\n거래일련번호 : [" + kisPosOcx.outTranNo + "]"
            + "\n가맹점번호 : [" + kisPosOcx.outMerchantRegNo + "]"
            + "\n메세지 : [" + kisPosOcx.outDisplayMsg + "]"
            + "\n화면표시 : [" + kisPosOcx.outDisplayMsg2 + "]"
            + "\n알림1 : [" + kisPosOcx.outReplyMsg1 + "]"
            + "\n알림2 : [" + kisPosOcx.outReplyMsg2 + "]"
            + "\n알림3 : [" + kisPosOcx.outReplyMsg3 + "]"
            + "\n알림4 : [" + kisPosOcx.outReplyMsg4 + "]"
            + "\n잔액 : [" + kisPosOcx.out0x41JanAmt + "]"
            + "\n비과세 : [" + kisPosOcx.out0x41TaxFreeAmt + "]"
            + "\n거래구분 : [" + kisPosOcx.out0x41TranGubun + "]"
            + "\n응답코드 : [" + kisPosOcx.out0x41ReplyCode + "]"
            + "\nNextUploadData : [" + kisPosOcx.out0x41NextUploadData + "]"
            + "\n거래로그 : [" + kisPosOcx.outRecvData + "]"

        TextArea1.value = strTemp2;
    }
}
</script>
<object id="kisPosOcx" classid="clsid:5C41929F-BAD3-4302-83DE-FA68ABAFF8B7" width="100" height="50" name="kisPosOcx"></object>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/student_depth_menu.jsp" %>
</div>
</section>
<section class="content">
    <h3 class="title_t1"><%=student_name%>학생 수강료 납부</h3>
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="student_id" id="studentId" value="<%=student_id%>">
        <input type="hidden" name="student_name" value="<%=student_name%>">
        <input type="hidden"  id="sPage" value="<%=sPage%>">
        <div class="tb_t1">
            <table>
                <colsgroup>
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="110" />
                </colsgroup>
                <tr>
                    <th>강의명</th>
                    <th>등록일</th>
                    <th>강의료</th>
                    <th>강의시일</th>
                    <th>강의종료일</th>
                    <th>결제할 금액</th>
                    <th>수납일</th>
                    <th>수납여부</th>
                </tr>
                <tbody id="dataList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
            <div class="form-group row"></div>
            <%@ include file="/common/inc/com_pageNavi.inc" %>
        </div>

        <%--<div id="payment_div" style="display: none;">--%>
            <%--<input type="hidden" id="lecture_rel_id">--%>
            <%--<input type="hidden" id="payment_price">--%>
            <%--강의 가격 : <span id="l_lecturePrice"></span>원<br>--%>
            <%--등록일 기준 결제 가격 : <span id="l_calcLecturePrice"></span>원<br>--%>
            <%--<input type="button" value="결제하기" id="payBtn" onclick="javascript:payment_lecture();">--%>
        <%--</div>--%>
    </form>
</section>
<section class="content divide" id="payment_section" style="display: none;">
    <div class="left">
        <div class="tile_box">
            <h3 class="title_t1">결제 정보</h3>
            <%--<h3 class="title_t1"><%=student_name%>학생 상담 등록</h3>--%>
            <input type="hidden" id="lecture_rel_id">
            <input type="hidden" id="payment_price">
            <ul class="list_t1">
                <li>
                    <strong>강의 이름</strong>
                    <div><p><span id="l_lectureName"></span></p></div>
                </li>
                <li>
                    <strong>강의 가격</strong>
                    <div><p><span id="l_lecturePrice"></span>원</p></div>
                </li>
                <li>
                    <strong>수강일 수</strong>
                    <div><p><span id="l_minusDay"></span>일</p></div>
                </li>
                <li>
                    <strong>결제할 가격</strong>
                    <div><p><span id="l_calcLecturePrice"></span>원</p></div>
                </li>
            </ul>
            <!--
            <div class="bot_btns">
                <button class="btn_pack blue s2" type="button" onclick="payment_lecture();">결제하기</button>
            </div>
            -->
        </div>
        <div class="form-group row"></div>
        <div>
            <button class="btn_pack blue s2" type="button" onclick="payment_lecture();">결제하기</button>
        </div>
    </div>
</section>

<%--<section class="content" id="payment_section" style="display: none;">--%>
    <%--<form name="payment_frm" class="form_st1">--%>
        <%--&lt;%&ndash;<h3 class="title_t1"><%=student_name%>학생 상담 등록</h3>&ndash;%&gt;--%>
        <%--<input type="hidden" id="lecture_rel_id">--%>
        <%--<input type="hidden" id="payment_price">--%>
        <%--<div class="form-outer-group">--%>
            <%--<div class="form-group row">--%>
                <%--<label>강의 가격</label>--%>
                <%--<div><span id="l_lecturePrice"></span>원</div>--%>
            <%--</div>--%>
            <%--<div class="form-group row">--%>
                <%--<label>수강일 수</label>--%>
                <%--<div><span id="l_minusDay"></span>일</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>결제 가격</label>--%>
            <%--<div><span id="l_calcLecturePrice"></span>원</div>--%>
        <%--</div>--%>
        <%--<div class="bot_btns">--%>
            <%--<button class="btn_pack blue s2" type="button" onclick="payment_lecture();">결제하기</button>--%>
        <%--</div>--%>
    <%--</form>--%>
<%--</section>--%>

<div>
    <br />
    연결포트번호(COM)             <input id="Text_port" type="text" value="1" /> 전송속도<input
        id="Text_BaudRate" type="text" value="9600" /><br />
</div>
<div>
    <br />
    결제금액&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Text_TranAmt" type="text" value="1004" /><br />
    <br />
    봉사료&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Text_SvcAmt" type="text" value="0" /><br />
    <br />
    부가세액&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Text_VatAmt" type="text" value="0" /><br />
    <br />
    할부개월&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Text_Installment" type="text" value="00" /> (현금영수증:&nbsp; 01법인, 02개인)<br />
    <br />
    원거래일자&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Text_OrgAuthDate" type="text" /><br />
    <br />
    원승인번호 &nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Text_OrgAuthNo" type="text" /><br />
</div>
<div>
    <input id="Radio1" checked="checked" name="R1" type="radio" value="V1" />신용승인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Radio2" name="R1" type="radio" value="V2" />신용취소<br /><br />
    <input id="Radio3" name="R1" type="radio" value="V3" />현금영수증승인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Radio4" name="R1" type="radio" value="V4" />현금영수증취소<br /><br />
    <!--
    <input id="Radio5" name="R1" type="radio" value="V5" />현금IC승인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Radio6" name="R1" type="radio" value="V6" />현금IC취소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Radio7" name="R1" type="radio" value="V7" />현금IC결과조회&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input id="Radio8" name="R1" type="radio" value="V8" />현금IC잔액조회<br />
    -->
    <input id="Button_CF" type="button" value="CAT연동 결제요청 (0xCF)" onclick="return Button4_onclick()" />
</div>
<div style="display: none;">
    <input id="Checkbox1" checked="checked" type="checkbox" />기본영수증출력&nbsp;&nbsp;&nbsp;
    <input id="Checkbox2" checked="checked" type="checkbox" />메시지출력&nbsp;&nbsp;&nbsp;
    <input id="Checkbox3" checked="checked" type="checkbox" />버튼출력<br />
</div>
<div>
    <textarea id="TextArea1" name="S1" cols="50" rows="20"></textarea>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>
