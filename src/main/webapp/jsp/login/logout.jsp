<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/jsp/top.jsp"%>
<%
	FlowEduMemberDto dto = (FlowEduMemberDto) session.getAttribute("member_info");
	if (dto != null) session.invalidate();
%>
<script>
	location.href="<%=webRoot%>";
</script>