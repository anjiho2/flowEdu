<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth2 = 1;
%>
<nav class="depth2">
    <a href="/flowEdu/template.do?page_gbn=dashboard" <%=depth2 == 1 ? "class=\"on\"" : ""%>>DashBoard</a>
    <a href="/flowEdu/template.do?page_gbn=formType1" <%=depth2 == 2 ? "class=\"on\"" : ""%>>Forms</a>
    <a href="/flowEdu/template.do?page_gbn=tableList" <%=depth2 == 3 ? "class=\"on\"" : ""%>>Table List</a>
</nav>

