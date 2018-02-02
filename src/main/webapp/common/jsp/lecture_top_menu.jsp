<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="title_top_on">운영세팅관리</div>
<nav class="depth2">
    <a href="javascript:goPage('lecture', 'lecture_list');" <%=depth2 == 1 ? "class=\"on\"" : ""%>>강의정보리스트</a>
    <a href="javascript:goPage('lecture', 'lecture_info');" <%=depth2 == 2 ? "class=\"on\"" : ""%>>강의정보입력</a>
    <a href="javascript:goPage('lecture', 'lecture_price');" <%=depth2 == 3 ? "class=\"on\"" : ""%>>수강료/강의반</a>
</nav>


