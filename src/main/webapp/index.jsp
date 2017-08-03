<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue("sPage", "1");
%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/loginService.js'></script>

<script type="text/javascript">

</script>
<body id="login" onload="init();">
<form name="frm" method="post">
<input type="hidden" name="page_gbn" id="page_gbn">

</form>
</body>
</html>
