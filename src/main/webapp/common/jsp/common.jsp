<%@ page import="org.apache.http.HttpStatus" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	int httpStatusCode = response.getStatus();
	String contextPath = request.getContextPath();
	contextPath = contextPath.endsWith("/") ? contextPath.substring(0, contextPath.length() - 1) : contextPath;
	request.setAttribute("webRoot", contextPath);

	Long memberId = 0L;
	String memberName = "";
	String phoneNumber = "";
	if (session.getAttribute("member_info") != null) {
		FlowEduMemberDto flowEduMemberDto = (FlowEduMemberDto) session.getAttribute("member_info");
		memberName = flowEduMemberDto.getMemberName();
		memberId = flowEduMemberDto.getFlowMemberId();
		phoneNumber = flowEduMemberDto.getPhoneNumber();
	}
%>
<script>
	var httpCode = '<%=httpStatusCode%>';
	if (httpCode == '901') {
	    alert("세션이 만료되어 로그인 페이지로 이동합니다.");
	}
</script>