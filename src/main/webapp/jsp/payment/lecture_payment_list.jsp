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
        paymentService.paymentLecture(lectureRelId, '<%=student_name%>' , paymentPrice, function () {
            alert("결제완료됬습니다.");
            isReloadPage(true);
        });
    }
}
</script>
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
                    <col width="110" />
                </colsgroup>
                <tr>
                    <th>강의명</th>
                    <th>등록일</th>
                    <th>강의료</th>
                    <th>강의시일</th>
                    <th>강의종료일</th>
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

</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>
