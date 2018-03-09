<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="title-top">강의관리</div>
<nav class="depth2">
    <a href="javascript:goPage('lecture', 'lecture_modify');" <%=depth2 == 1 ? "class=\"on\"" : ""%>>강의기본정보</a>
    <a href="javascript:goPage('lecture', 'lecture_schedule_list');" <%=depth2 == 2 ? "class=\"on\"" : ""%>>강의시간표 설정</a>
    <a href="javascript:goPage('lecture', 'lecture_apply');" <%=depth2 == 3 ? "class=\"on\"" : ""%>>강의 신청</a>
    <a  <%=depth2 == 4 ? "class=\"on\"" : ""%>>달력보기</a>
</nav>


