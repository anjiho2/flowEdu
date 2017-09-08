<%@ page import="com.flowedu.util.CreateSESSION" %>
<%@ page import="com.flowedu.dto.FlowEduMemberDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
	
	String webRoot = request.getContextPath();

	String page_gbn = "";

		try {
			FlowEduMemberDto dto = CreateSESSION.sessionCF(request);
			session.setAttribute("member_info", dto);
			session.setMaxInactiveInterval(60*60);
		}catch (Exception e) {
			System.out.println("SESSION CREATE ERROR.....");
			e.printStackTrace();
		}

	
%>
<script type="text/javascript">
var page_gbn = "<%=page_gbn%>";
function init() {
	with(document.frm) {
		action = "<%=webRoot%>/dashboard.do";
		page_gbn.value = "dashboard_list";
		submit();
	}
}
</script>
<body onload="init();">
<form name="frm" method="post">
	<input type="hidden" name="page_gbn">
</form>
</body>