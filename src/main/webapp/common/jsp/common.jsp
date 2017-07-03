<%@	taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	String contextPath = request.getContextPath();
	contextPath = contextPath.endsWith("/") ? contextPath.substring(0, contextPath.length() - 1) : contextPath;
	request.setAttribute("webRoot", contextPath);
%>