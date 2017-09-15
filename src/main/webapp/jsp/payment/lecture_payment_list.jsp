<%@ page import="com.flowedu.util.Util" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String student_name = StringUtil.convertParmeterStr(request.getParameter("student_name"), "UTF-8");
%>
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
                function(data) {return data.paymentYn == false ? "<input type='button' value='수납하기' id='"+ data.lectureRelId + "' onclick='javascript:cacl_lecture_price(this.id);' >": "수납완료";},
                //function(data) {return data.paymentYn == false ? "<input type='button' value='수납하기' id='"+ data.lectureRelId + "' onclick='javascript:cacl_lecture_price(this.id);' >" : ""}
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
        innerHTML("l_calcLecturePrice", addThousandSeparatorCommas(roundMarks(calcLecturePrice * minusDay)));
        gfn_display("payment_div", true);
    });
}

function payment_lecture() {
    var lectureRelId = getInputTextValue("lecture_rel_id");
    var paymentPrice = getInputTextValue("payment_price");
    if (confirm(paymentPrice + "을 결제하시겠습니까?")) {
        paymentService.paymentLecture(lectureRelId, '<%=student_name%>' , paymentPrice, function () {
            alert("결제완료됬습니다.");
            isReloadPage(true);
        });
    }
}
</script>
<style>
    .inpType{padding-left:6px;height:24px;line-height:24px;border:1px solid #dbdbdb}

</style>
<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="student_id" id="studentId" value="<%=student_id%>">
    <input type="hidden" name="student_name" value="<%=student_name%>">
    <input type="hidden"  id="sPage" value="<%=sPage%>">
    <%@include file="/common/jsp/user_top_menu.jsp"%>
    <h1><%=student_name%> 수강료 납부</h1>
    <div>
        <table border="1" width="800px">
            <colgroup>
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
            </colgroup>
            <thead>
            <tr>
                <th>강의명</th>
                <th>등록일</th>
                <th>강의료</th>
                <th>강의시일</th>
                <th>강의종료일</th>
                <th>수납일</th>
                <th>수납여부</th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
            <!--<input type="button" value="삭제" onclick="Delete();">-->
        </table>
        <%@ include file="/common/inc/com_pageNavi.inc" %>
    </div>
    <br>
    <div id="payment_div" style="display: none;">
        <input type="hidden" id="lecture_rel_id">
        <input type="hidden" id="payment_price">
        강의 가격 : <span id="l_lecturePrice"></span>원<br>
        등록일 기준 결제 가격 : <span id="l_calcLecturePrice"></span>원<br>
        <input type="button" value="결제하기" id="payBtn" onclick="javascript:payment_lecture();">
    </div>
</form>
</body>