<%@ page import="com.flowedu.util.Util" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 2;
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String student_name = StringUtil.convertParmeterStr(request.getParameter("student_name"), "UTF-8");
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script>

function init() {
    fn_search("new");
    innerValue("endDate", today());
    innerValue("startDate", getYear() + "-" + getMonthCount(-3) + "-" + getDayCount(-1));
}

function fn_search(val) {
    var student_id = getInputTextValue("studentId");
    var paging = new Paging();
    var sPage = $("#sPage").val();
    var startDate = getInputTextValue("startDate");
    var endDate = getInputTextValue("endDate");

    if (startDate == "") startDate = getYear() + "-" + getMonthCount(-3) + "-" + getDayCount(-1);
    if (endDate == "") endDate = today();
    if(val == "new") sPage = "1";

    gfn_emptyView("H", "");

    lectureService.getLectureStudentRelByStudentIdCount(student_id, startDate, endDate, function(cnt) {
        paging.count(sPage, cnt, '10', '10', comment.blank_list);

        dwr.util.removeAllRows("dataList");
        //학생의 수강이력 가져오기
        lectureService.getLectureStudentRelById(student_id, startDate, endDate, function (selList) {
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
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/student_depth_menu.jsp" %>
</div>
</section>
<section class="content">
    <h4 class="title_t1"><%=student_name%>학생의 수강 이력입니다.</h4>
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="studentId" name="student_id" value="<%=student_id%>">
        <input type="hidden" name="student_name" value="<%=student_name%>">
        <input type="hidden"  id="sPage" value="<%=sPage%>">

        <div class="intput-group">
            <input type="text" id="startDate" class="form-control date-picker" style="width:200px;" placeholder="시작일">
        </div>
        <div style="width: 100px;">
            <input type="text" id="endDate" class="form-control date-picker" style="width:200px;" placeholder="종료일">
            <input type="button" value="검색" onclick="fn_search('new');">
        </div>
        <div class="tb_t1">
            <table>
                <colsgroup>
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                </colsgroup>
                <tr>
                    <th>강의명</th>
                    <th>담당선생님</th>
                    <th>강의시작일</th>
                    <th>강의종료일</th>
                </tr>
                <tbody id="dataList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
            <button class="btn_pack blue">수강등록</button>
            <div class="form-group row"></div>
            <%@ include file="/common/inc/com_pageNavi.inc" %>
        </div>
    </form>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>