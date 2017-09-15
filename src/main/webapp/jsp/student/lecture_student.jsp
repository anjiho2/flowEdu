<%@ page import="com.flowedu.util.Util" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String student_name = StringUtil.convertParmeterStr(request.getParameter("student_name"), "UTF-8");
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
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
    dwr.util.removeAllRows("dataList");
    lectureService.getLectureStudentRelByStudentIdCount(student_id, function(cnt) {
        paging.count(sPage, cnt, '10', '5', comment.blank_list);

        //학생의 수강이력 가져오기
        lectureService.getLectureStudentRelById(student_id, function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    var cellData = [
                        function(data) {return cmpList.lectureName;},
                        function(data) {return cmpList.chargeMemberName;},
                        function(data) {return cmpList.lectureStartDate;},
                        function(data) {return cmpList.lectureEndDate;},
                    ];
                    dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});

                }
            }
        });
    });

}

function lecture_apply() {
    goPage("lecture","lecture_list");
}

</script>
<style>
    .inpType{padding-left:6px;height:24px;line-height:24px;border:1px solid #dbdbdb}

</style>
<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" id="studentId" name="student_id" value="<%=student_id%>">
    <input type="hidden" name="student_name" value="<%=student_name%>">
    <input type="hidden"  id="sPage" value="<%=sPage%>">
    <%@include file="/common/jsp/user_top_menu.jsp"%>
    <h1><%=student_name%> 수강리스트</h1>
    <div>
        <input type="button" value="강의신청" onclick="lecture_apply();">
    </div>
    <div>
        <table border="1" width="500px">
            <colgroup>
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
            </colgroup>
            <thead>
            <tr>
                <th>강의명</th>
                <th>담당선생님</th>
                <th>강의시작일</th>
                <th>강의종료일</th>
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
</form>
</body>