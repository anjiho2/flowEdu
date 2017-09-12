<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    FlowEduMemberDto flowEduMemberDto = (FlowEduMemberDto)session.getAttribute("member_info");
    Long memberId = flowEduMemberDto.getFlowMemberId();
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script>
    function init() {
        student_memo_list();
        studentMemoTypeRadio("l_memoType", "REG", "");
    }
    function studentMemo() {//상담저장
        var student_id  = getInputTextValue("student_id");
        var consultMemo = getInputTextValue("consultMemo");
        var memoType = get_radio_value("memo_type");
        studentService.saveStudentMemo(student_id, consultMemo, memoType, function () {
            alert("상담저장완료");
            location.reload();
        });
    }

    //상담리스트
    function student_memo_list() {
        var student_id = getInputTextValue("student_id");
        studentService.getStudentMemoLastThree(student_id, function (memoList) {
            if (memoList.length < 0) return;
            dwr.util.addRows("consultList", memoList, [
                function(data) {return data.memoContent},
                function(data) {return data.memberName;},
                function(data) {return convert_memo_type(data.memoType);},
                function(data) {return getDateTimeSplitComma(data.createDate);},
                function(data) {return data.processYn == false ? "<input type='button' value='처리하기' id="+data.studentMemoId+" onclick='changeProccessYn(this.id);'>" : "처리완료";}
            ], {escapeHtml:false} );
        });
    }
</script>


<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" id="student_id" value="<%=student_id%>">
<span id="l_memoType"></span>
<div>
    <textarea id="consultMemo" cols="50" rows="5" placeholder="상담내용을 입력하세요"></textarea>
    <input type="button" value="상담저장" onclick="studentMemo();">
</div>
<br>
<div style="float:left;">
    <h1>최근 상담 3건</h1>
    <table class="table_list" border="1">
        <colgroup>
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
        </colgroup>
        <thead>
        <tr>
            <th>상담내용</th>
            <th>상담자</th>
            <th>상담구분</th>
            <th>상담날짜</th>
            <th>처리여부</th>
        </tr>
        </thead>
        <tbody id="consultList"></tbody>
        <tr>
            <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
        </tr>
    </table>
</div>
</form>
</body>