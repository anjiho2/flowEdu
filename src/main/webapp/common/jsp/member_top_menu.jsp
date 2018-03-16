<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="depth2">
    <a href="javascript:goPage('member', 'list_member');" <%=depth2 == 1 ? "class=\"on\"" : ""%>>운영자&선생님리스트</a>
    <a href="javascript:goPage('member', 'save_member');" <%=depth2 == 2 ? "class=\"on\"" : ""%>>운영자&선생님 정보입력/수정</a>
</nav>


