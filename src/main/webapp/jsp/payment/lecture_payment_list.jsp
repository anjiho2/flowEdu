<%@ page import="com.flowedu.util.Util" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 6;

    int siderMenuDepth1 = 1;
    int siderMenuDepth2 = 2;
    int siderMenuDepth3 = 1;

    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String student_name = StringUtil.convertParmeterStr(request.getParameter("student_name"), "UTF-8");
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script src="<%=webRoot%>/js/trans_payment.js?ver=<%=version%>"></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/paymentService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/logService.js'></script>
<script>

if (get_browser_type() != "IE") {
    alert("크롬이나 사파리에서는 결제기능이 안됩니다.\n익스플로러로 실행해주세요.");
}

function init() {
    fn_search("new");
}
//수강료 납부 리스트
function fn_search(val) {
    var student_id = getInputTextValue("studentId");
    var paging = new Paging();
    var sPage = getInputTextValue("sPage");

    if(val == "new") sPage = "1";
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
                function(data) {return "<button class='btn_pack white' type='button' id='"+ data.lectureRelId + "' onclick='javascript:showPaymentLog(this.id);'>보기</button>"},
            ], {escapeHtml:false});
        });
    });
}
//수납버튼 이벤트
function cacl_lecture_price(lecture_rel_id) {
    //결제 금액이 책정 되었는지 확인
    lectureService.getLectureStudentRelInfo(lecture_rel_id, function(info) {
        if (info.paymentYn == false && info.paymentPrice == 0) {
            gfn_display("payment_section", false);
            alert("총 결제금액이 책정되지 않았습니다.\n총 결제금액을 책정해주세요.");
            innerValue("formulate_lecture_rel_id", lecture_rel_id);
            initPopup($("#formulate_price_layer"));
            return;
        } else {
            showLectureStudentRelInfo(lecture_rel_id);
        }
    });
}
//결제정보 영역 보여주기
function showLectureStudentRelInfo(lectureRelId) {
    lectureService.getLectureStudentRelInfo(lectureRelId, function(relInfo) {
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

        innerValue("lecture_rel_id", lectureRelId);
        innerValue("payment_price", roundMarks(calcLecturePrice * minusDay));
        innerHTML("l_lectureName", relInfo.lectureName);
        innerHTML("l_lecturePrice", addThousandSeparatorCommas(relInfo.lecturePrice));
        innerHTML("l_minusDay", minusDay);
        if (relInfo.paymentPrice > 0) {
            innerValue("l_calcLecturePrice", addThousandSeparatorCommas(relInfo.paymentPrice));
        }
        gfn_display("payment_section", true);
    });
}
//결재금액 책정하기
function formulateLecturePrice() {
    var formulatePrice = getInputTextValue("formulate_price");
    var lectureRelId = getInputTextValue("formulate_lecture_rel_id");
    paymentService.formulateLecturePrice(lectureRelId, formulatePrice, function () {
        alert("결제할 가격이 책정되었습니다.");
        close_popup("formulate_price_layer")
        showLectureStudentRelInfo(lectureRelId);
    });
}
//결제하기 비지니스 로직
function payment_lecture(paymentResult, transType) {
    var check = new isCheck();
    var lectureRelId;
    var paymentPrice;
    var studentName = '<%=student_name%>';
    var caclType;
    if (transType == "payment") {
        if (check.input("l_calcLecturePrice", "결제할 금액을 입력하세요") == false) return;
        lectureRelId = getInputTextValue("lecture_rel_id");
        paymentPrice = getInputTextValue("l_calcLecturePrice");
        caclType = "MINUS";
    } else if (transType == "cancel") {
        lectureRelId = getInputTextValue("cancel_lecture_rel_id");
        paymentPrice = getInputTextValue("cancel_price");
        caclType = "PLUS";
    }
    paymentService.paymentLecture(lectureRelId, studentName, paymentPrice, caclType, paymentResult, function (result) {
        if (result == 200) {
            alert("결제완료됬습니다.");
            isReloadPage(true);
        } else if (result == 911) {
            alert(comment.payment_error + "\n" + "[" + getInputTextValue("auth_message") + "]");
        } else {
            alert(comment.error);
        }
    });
}
//KisPos단말기로 결제 값 보내기(결제버튼)
function kisPosPayment(transType) {
    var check = new isCheck();
    if (get_browser_type() != "IE") {
        alert("크롬이나 사파리에서는 결제기능이 안됩니다.\n익스플로러로 실행해주세요.");
        return;
    }
    var transCode;
    var paymentPrice;
    var confirmComment;
    var catPortNo;
    var inInstallment;

    if (transType == "payment") {   //결제일때
        var paymentType = getSelectboxValue("sel_payment");
        transCode = paymentType;
        paymentPrice = getInputTextValue("l_calcLecturePrice");
        confirmComment = "원을 결제하시겠습니까?";
        catPortNo = getSelectboxValue("posPort");
        inInstallment = getSelectboxValue("sel_installMent");

        if (paymentType == "D1") {  //신용승인일때
            if (check.selectbox("sel_installMent", comment.select_installMent) == false) return;
        } else if (paymentType == "CC") {   //현금영수증 승인일때
            if (check.selectbox("sel_cash", comment.select_cash_receipt_type) == false) return;
        }
    } else if (transType == "cancel") { //취소일때
        paymentPrice = getInputTextValue("cancel_price");
        confirmComment = "원을 취소하시겠습니까?";
        catPortNo = getSelectboxValue("cancelPosPort");
        inInstallment = "00";

        var cancel_auth_type = getInputTextValue("cancel_auth_type");
        if (cancel_auth_type == "D1") transCode = "D2"; //신용취소
        else if (cancel_auth_type == "CC") transCode = "CR";    //현금영수증 취소
    }

    if (confirm(addThousandSeparatorCommas(paymentPrice) + confirmComment)) {
        //CF 요청
        kisPosOcx.Init();
        kisPosOcx.inSpecType = "CATUPLOAD";
        kisPosOcx.inCatPortNo = catPortNo;
        kisPosOcx.inCatBaudRate = getInputTextValue("Text_BaudRate");
        kisPosOcx.inTranCode = transCode;
        kisPosOcx.inTranAmt = paymentPrice;
        kisPosOcx.inVatAmt = 0;
        kisPosOcx.inSvcAmt = 0;
        kisPosOcx.inInstallment = inInstallment;
        kisPosOcx.inOrgAuthDate = "";
        kisPosOcx.inOrgAuthNo = "";

        var reVal =  kisPosOcx.KIS_Approval();

        if (reVal == 0) {
            if (kisPosOcx.outAuthNo == null || kisPosOcx.outAuthNo == "" || kisPosOcx.outAuthNo == undefined) {
                innerValue("auth_message", kisPosOcx.outDisplayMsg);
            }
            var paymentResult = {
                catId:kisPosOcx.outCatId,
                cardNo: kisPosOcx.outCardNo, installMent:kisPosOcx.outInstallment,
                transAmt: kisPosOcx.outTranAmt, authNo:kisPosOcx.outAuthNo,
                replyDate: kisPosOcx.outReplyDate, accepterCode:kisPosOcx.outAccepterCode,
                issureCode: kisPosOcx.outIssuerCode, issureName:kisPosOcx.outIssuerName,
                transNo: kisPosOcx.outTranNo, merchantRegNo:kisPosOcx.outMerchantRegNo,
                recvData: kisPosOcx.outRecvData, authType:kisPosOcx.inTranCode
                };

            payment_lecture(paymentResult, transType);
            //승인취소일때 취소로그의 승인된 로그 취소로 변경
            if (transType == "cancel") {
                var cancelLecturePaymentLogId = getInputTextValue("cancel_lecture_payment_log_id");
                cancel_payment(cancelLecturePaymentLogId);
            }
        } else if (reVal == -3) {
            alert("POS기기에서 취소하였습니다." + "에러코드 : " + reVal);
        } else if (reVal == -2) {
            alert("단말기 종료로 취소되었습니다." + "에러코드 : " + reVal);
        } else if (reVal == -1) {
            alert("단말기가 다른 동작중입니다.\n담당자에게 문의하세요." + "에러코드 : " + reVal);
        } else if (reVal == 1) {
            alert("단말기번호가 상이합니다.\n담당자에게 문의하세요." + "에러코드 : " + reVal);
        } else {
            alert("결제 포스기기가 열결되있지 않거나\n연결포트 번호를 확인하세요." + "에러코드 : " + reVal);
            if (transType == "payment") focusInputText("posPort");
            else if (transType == "cancel") focusInputText("cancelPosPort");
        }
    }
}

function changeSelPayment() {
    var paymentType = getSelectboxValue("sel_payment");
    if (paymentType == "CC") {
        gfn_display("li_cach_recipt", true);
        gfn_display("li_installMent", false);
    } else {
        gfn_display("li_cach_recipt", false);
        gfn_display("li_installMent", true);
    }
}
//결재내역 보기 버튼
function showPaymentLog(lectureRelId) {
    initPopup($("#payment_log_layer"));
    var listCount = 2;
    var sPage;

    if (lectureRelId != undefined) {
        innerValue("payment_lecture_rel_id", lectureRelId);
        dwr.util.removeAllRows("paymentList");
        sPage = 1;
    } else {
        sPage = getInputTextValue("s_page");
        sPage++;
    }
    innerValue("s_page", sPage);

    gfn_emptyView2("H", "");

    logService.getLecturePaymentLog(getInputTextValue("payment_lecture_rel_id"), function(selList) {
        if (selList.length == 0) {
            gfn_emptyView2('v', "결과값이 없습니다");
        }
        if ( selList.length > listCount ) {
            if (selList.length < (sPage * listCount)) {
                alert("데이터가 더이상 없습니다.");
                return;
            }
        }
        innerHTML("l_payment_name", selList[0].studentName);
        dwr.util.removeAllRows("paymentList");
        for (var i = 0; i < sPage * listCount; i++) {
            var cmpList = selList[i];
            var cellData = [
                function(data) {return cmpList.authNo + "(" + getPaymentType(cmpList.authType) + ")"},
                function(data) {return addThousandSeparatorCommas(cmpList.transAmt) + "(" + transInstallMent(cmpList.installMent, cmpList.authType) + ")"},
                function(data) {return cmpList.issureName + "(" + cmpList.cardNo + ")"},
                function(data) {return getDateTimeSplitComma(cmpList.createDate)},
                function(data) {return getDateTimeSplitComma(cmpList.memberName)},
                function(data) {return cmpList.authType == "D1" || cmpList.authType == "CC" ? transAuthType(cmpList.authType) + "(" + "<a href='#' onclick='cancel_payment_info(" + cmpList.lecturePaymentLogId + ");'>취소하기</a>" + ")" : transAuthType(cmpList.authType);},
            ];
            dwr.util.addRows("paymentList", [0], cellData, {escapeHtml: false});
        }

    });
}
//결제 취소할 정보
function cancel_payment_info(lecturePaymentLogId) {
    close_popup("payment_log_layer");
    initPopup($("#cancel_payment_layer"));
    logService.getLecturePaymentLogInfo(lecturePaymentLogId, function (data) {
        innerValue("cancel_lecture_payment_log_id", data.lecturePaymentLogId);
        innerValue("cancel_lecture_rel_id", data.lectureRelId);
        innerValue("cancel_auth_type", data.authType);
        innerValue("cancel_price", data.paymentPrice);
        innerHTML("cancelAuthNo", data.authNo);
        innerHTML("isCard", data.authType == "D1" ? getPaymentType(data.authType) + "(" + data.issureName + ")" : getPaymentType(data.authType));
        innerHTML("paymentCreateDate", getDateTimeSplitComma(data.createDate));
        innerHTML("cancelPrice", addThousandSeparatorCommas(data.paymentPrice) + "원");
    });
}
//결제 취소하기(결제 상태 -> 취소 변경하기)
function cancel_payment(lecturePaymentLogId) {
    logService.cancelPaymentLog(lecturePaymentLogId, function (result) {
        if (result == 200) {
            alert("결제취소 되었습니다.");
            close_popup("cancel_payment_layer");
            isReloadPage(true);
        } else if (result == 904) {
            alert("결재 취소건이 결재 취소가 시도되었습니다.");
            return;
        } else {
            alert(comment.error);
            return;
        }
    });
}
</script>
<!-- KIS정보통신 연동 관련 -->
<object id="kisPosOcx" classid="clsid:5C41929F-BAD3-4302-83DE-FA68ABAFF8B7" style="display: none;" name="kisPosOcx"></object>
<!-- 직렬포트 값 알아오기 관련 -->
<object id="SPortX" style="display: none" data="data:application/x-oleobject;ba.se64,RlDpFMe+0ka543SxrRSsZQAHAABPAwAATwMAAA==" classid="clsid:14E95046-BEC7-46D2-B9E3-74B1AD14AC65" viewastext codebase="..\CAB\sport.cab"></object>
<script>
    //COM포트 정보 가져오기 IE에서만 작동 (serial_activex 가 설치되어있어야함)
    var SPAxLoaded,  txtTermBuf, CForm1, CForm2;
    var CRLF = '\n';
    var SPort = document.getElementById("SPortX");

    var SERIAL_DTR_CONTROL = 1;
    var SERIAL_DTR_HANDSHAKE = 2;
    var SERIAL_RTS_CONTROL = 64;
    var SERIAL_RTS_HANDSHAKE = 128;
    var SERIAL_CTS_HANDSHAKE = 8;
    var SERIAL_DSR_HANDSHAKE = 16;
    var SERIAL_AUTO_TRANSMIT = 1;
    var SERIAL_AUTO_RECEIVE = 2;

    function addPort(port) {
        var portList = CForm1.elements["posPort"];
        var intPort =  port.replace(/[^0-9]/g,"");

        if (document.createElement){
            var newPort = document.createElement("OPTION");
            newPort.text = intPort + "번포트";
            newPort.value  = intPort;
            (portList.options.add) ? portList.options.add(newPort) : portList.add(newPort, null);
        } else{
            // for NN3.x-4.x
            portList.options[i] = new Option(port, port, false, false);
        }
    }

    function addCancelPort(port) {
        var portList = CForm2.elements["cancelPosPort"];
        var intPort =  port.replace(/[^0-9]/g,"");

        if (document.createElement){
            var newPort = document.createElement("OPTION");
            newPort.text = intPort + "번포트";
            newPort.value  = intPort;
            (portList.options.add) ? portList.options.add(newPort) : portList.add(newPort, null);
        } else{
            // for NN3.x-4.x
            portList.options[i] = new Option(port, port, false, false);
        }
    }

    function InitPort() {
        //SPort = document.getElementById("SPortX");
        CForm1 = document.frm2;
        CForm2 = document.cancel_pop_frm;
        SPAxLoaded = false;

        if(SPort == null){
            SPAxLoaded = false;
            alert('Serial Port Control was not loaded');
        } else{
            SPAxLoaded = true;
            SPort.Parity = 0; //NOPARITY
            SPort.StopBits = 0; //1.5 STOPBITS
            SPort.BaudRate = 110;
            SPort.HandShake = SERIAL_DTR_CONTROL;
            SPort.FlowReplace = SERIAL_RTS_CONTROL;

            for (var i = 0; i < SPort.CountPorts; i++){
                addPort(SPort.GetPortName(i));
                addCancelPort(SPort.GetPortName(i));
            }
        }
    }
</script>
<body onload="init();InitPort();">
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
                    <col width="110" />
                </colsgroup>
                <tr>
                    <th>강의명</th>
                    <th>등록일</th>
                    <th>강의료</th>
                    <th>강의시일</th>
                    <th>강의종료일</th>
                    <th>결제할 금액</th>
                    <th>수납완료일</th>
                    <th>수납여부</th>
                    <th>결재내역</th>
                </tr>
                <tbody id="dataList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
            <div class="form-group row"></div>
            <%@ include file="/common/inc/com_pageNavi.inc" %>
        </div>
    </form>
</section>
<!-- 결제 정보 영역 시작 -->
<section class="content divide" id="payment_section" style="display: none;">
    <form name="frm2" class="form_st1">
        <input type="hidden" id="Text_BaudRate" value="9600" />
        <div class="left">
            <div class="tile_box">
                <h3 class="title_t1">결제 정보</h3>
                <input type="hidden" id="lecture_rel_id">
                <input type="hidden" id="payment_price">
                <input type="hidden" id="auth_message">
                <ul class="list_t1">
                    <li>
                        <strong>POS포트</strong>
                        <div><select name="posPort" id="posPort" class="form-control"></select></div>
                    </li>
                    <li id="li_lectureName">
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
                        <strong>결재방식</strong>
                        <div>
                            <select id="sel_payment" class="form-control" onchange="changeSelPayment();">
                                <option value="D1" selected="selected">신용카드</option>
                                <option value="CC">현금</option>
                            </select>
                        </div>
                    </li>
                    <li id="li_cach_recipt" style="display: none;">
                        <strong>현금영수증</strong>
                        <div>
                            <select id="sel_cash" class="form-control">
                                <option value="">▶선택</option>
                                <option value="01">법인</option>
                                <option value="02">개인</option>
                            </select>
                        </div>
                    </li>
                    <li id="li_installMent">
                        <strong>할부개월</strong>
                        <div>
                            <select id="sel_installMent" class="form-control">
                                <option value="">▶선택</option>
                                <option value="00">일시불</option>
                                <%
                                    for (int i=2; i<13; i++) {
                                %>
                                <option value="<%=i%>"><%=i%>개월</option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </li>
                    <li>
                        <strong>결제할 가격</strong>
                        <div><input type="text" id="l_calcLecturePrice" class="form-control"></div>
                    </li>
                </ul>
            </div>
            <div class="form-group row"></div>
            <div>
                <button class="btn_pack blue s2" type="button" onclick="kisPosPayment('payment');">결제하기</button>
                <button class="btn_pack orange s2" type="button" onclick="javascript:gfn_display('payment_section', false);">취소</button>
            </div>
        </div>
    </form>
</section>
<!-- 결제 정보 영역 끝 -->
<!-- 금액 책정하기 레이어 시작 -->
<div class="layer_popup_template apt_request_layer" id="formulate_price_layer" style="display: none;">
    <input type="hidden" id="formulate_lecture_rel_id">
    <div class="layer-title">
        <h3>결제금액 책정</h3>
        <button class="fa fa-close btn-close"></button>
    </div>
    <div class="layer-body">
        <form name="pop_frm" class="form_st1">
            <div class="cont">
                <div class="form-group row">
                    <div class="inputs">
                        <span id=""></span>
                    </div>
                </div>
                <div class="form-group"><div><input type="email" class="form-control" id="formulate_price" placeholder="책정할 금액입력"></div></div>
            </div>
        </form>
        <div class="bot_btns_t1">
            <button class="btn_pack btn-close">취소</button>
            <button class="btn_pack blue" type="button" onclick="formulateLecturePrice();">책정하기</button>
        </div>
    </div>
</div>
<!-- 금액 책정하기 레이어 끝 -->
<!-- 결재내역 보기 레이어 시작 -->
<div class="layer_popup_template apt_request_layer" id="payment_log_layer" style="display: none;">
    <input type="hidden" id="payment_lecture_rel_id">
    <input type="hidden" id="s_page">
    <input type="hidden" id="list_count">
    <div class="layer-title">
        <h3><span id="l_payment_name"></span> 결재 내역</h3>
        <button class="fa fa-close btn-close"></button>
    </div>
    <div class="layer-body">
        <form name="pop_frm2" class="form_st1">
            <div class="tb_t1">
                <table class="class_list">
                    <colsgroup>
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                    </colsgroup>
                    <tr>
                        <th>승인번호</th>
                        <th>결재가격</th>
                        <th>카드정보</th>
                        <th>승인일</th>
                        <th>결재자</th>
                        <th>결과</th>
                    </tr>
                    <tbody id="paymentList"></tbody>
                    <tr>
                        <td id="emptys2" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                    </tr>
                    <tr style="text-align: right;">
                        <td colspan="6" style="border-bottom: 0;">
                            <button type="button" class="btn_pack blue s2" onclick="showPaymentLog();">더보기</button>
                        </td>
                    </tr>
                </table>
            </div>
        </form>

    </div>
</div>
<!-- 결재내역 보기 레이어 끝 -->
<!-- 결재 취소 레이어 시작 -->
<div class="layer_popup_template apt_request_layer" id="cancel_payment_layer" style="display: none; max-width: 25%;">
    <div class="layer-title">
        <h3>결재 취소 하기</h3>
        <button class="fa fa-close btn-close"></button>
    </div>
    <div class="layer-body">
        <form name="cancel_pop_frm" class="form_st1">
            <input type="hidden" id="cancel_lecture_payment_log_id">
            <input type="hidden" id="cancel_lecture_rel_id">
            <input type="hidden" id="cancel_auth_type">
            <input type="hidden" id="cancel_price">
            <div class="tb_t1">
                <ul class="list_t1">
                    <li>
                        <strong>POS포트</strong>
                        <div><select name="cancelPosPort" id="cancelPosPort" class="form-control"></select></div>
                    </li>
                    <li>
                        <strong>승인 번호</strong>
                        <div><span id="cancelAuthNo"></span></div>
                    </li>
                    <li>
                        <strong>신용/현금여부</strong>
                        <div><span id="isCard"></span></div>
                    </li>
                    <li>
                        <strong>결재일</strong>
                        <div><span id="paymentCreateDate"></span></div>
                    </li>
                    <li>
                        <strong>취소금액</strong>
                        <div><span id="cancelPrice"></span></div>
                    </li>
                </ul>
            </div>
            <div class="form-group row"></div>
            <div style="margin-left: 270px;">
                <button class="btn_pack blue s2" type="button" onclick="kisPosPayment('cancel');">취소하기</button>
            </div>
        </form>

    </div>
</div>
<!-- 결재 취소 레이어 끝 -->

<%@include file="/common/jsp/footer.jsp" %>
</body>