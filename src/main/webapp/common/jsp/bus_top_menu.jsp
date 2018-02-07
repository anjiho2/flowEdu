<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="title-top">운영관리</div>
<nav class="depth2">
    <a href="javascript:goPage('bus', 'driver_info');" <%=depth2 == 1 ? "class=\"on\"" : ""%>>기사기본정보</a>
    <a href="javascript:goPage('bus', 'commute_assist_info');" <%=depth2 == 2 ? "class=\"on\"" : ""%>>통학도우미정보</a>
    <a href="javascript:goPage('bus', 'bus_route_info');" <%=depth2 == 3 ? "class=\"on\"" : ""%>>노선정보</a>
</nav>


