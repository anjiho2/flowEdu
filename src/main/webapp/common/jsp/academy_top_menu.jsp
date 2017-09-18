<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="depth2">
    <a href="javascript:goPage('academy', 'list_academy');" <%=depth2 == 1 ? "class=\"on\"" : ""%>>학원리스트</a>
    <a href="javascript:goPage('academy', 'save_academy');" <%=depth2 == 2 ? "class=\"on\"" : ""%>>학원정보입력</a>
</nav>


