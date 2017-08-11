<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
function init() {
    academyListSelectbox("sel_academy","");
}
function save_room() {

    var lectureName = getInputTextValue("lectureName");
    var academyId = getSelectboxValue("sel_academyList");

    lectureService.saveLectureRoom(academyId,lectureName, function () {
        alert("저장되었습니다.");
        location.reload();
    });
}
</script>
<body onload="init();">
<form name="frm" id="frm" method="get">
    <table>
        <tr>
            <th>관선택 : </th>
             <td><span id="sel_academy"></span></td>
        </tr>
        <tr>
            <th>강의실명 : </th>
            <td><input type="text" id="lectureName"></td>
        </tr>
        <td><input type="button" onclick="save_room();" value="저장"></td>
    </table>
</form>
</body>
</html>
