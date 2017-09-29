<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="depth2">
    <a href="javascript:goPage('consult', 'save_consult');" <%=depth2 == 1 ? "class=\"on\"" : ""%>>신규 상담 입력</a>
    <a href="javascript:goPage('lecture', 'lecture_info');" <%=depth2 == 2 ? "class=\"on\"" : ""%>>상담 목록</a>
</nav>


