<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/jsp/top.jsp" %>

<script type='text/javascript' src='/flowEdu/dwr/interface/loginService.js'></script>

<script type="text/javascript">
   function viewUserName() {
       var userName = "안지호";
       loginService.findUserName(userName, function (name) {
           innerHTML("name", name);
       });
   }
</script>
<body id="login" onload="viewUserName()">
<form name="frm" method="post">
<input type="hidden" name="param1" />
<input type="hidden" name="param2" />
<input type="hidden" name="page_gbn" id="page_gbn">
플로우 교육 개발
    <input type="button" onclick="viewUserName();" value="테스트">
</form>

<span id="name"></span>
<%-- <%@ include file="/common/jsp/top_menu.jsp"%> --%>
</body>
</html>
