<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //int depth2 = 2;
%>
<nav class="depth2">
    <a href="/flowEdu/template.do?page_gbn=dashboard" <%=depth2 == 1 ? "class=\"on\"" : ""%>>DashBoard</a>
    <a href="/flowEdu/template.do?page_gbn=formType1" <%=depth2 == 2 ? "class=\"on\"" : ""%>>Forms</a>
    <a href="/flowEdu/template.do?page_gbn=tableList" <%=depth2 == 3 ? "class=\"on\"" : ""%>>Table List</a>
    <a href="/flowEdu/template.do?page_gbn=tileType1" <%=depth2 == 4 ? "class=\"on\"" : ""%>>Tile List</a>
    <a href="/flowEdu/template.do?page_gbn=layerPopup" <%=depth2 == 5 ? "class=\"on\"" : ""%>>Layer Popup</a>
</nav>

