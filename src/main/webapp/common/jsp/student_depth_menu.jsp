<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="title_top_on">학생관리</div>
<nav class="depth2">
    <a href="javascript:goPage('student', 'modify_student');" <%=depth2 == 1 ? "class=\"on\"" : ""%>>학생정보/수정</a>
    <a href="javascript:goPage('student', 'lecture_student');" <%=depth2 == 2 ? "class=\"on\"" : ""%>>수강이력</a>
    <a href="javascript:goPage('student', 'attend_student_list');" <%=depth2 == 3 ? "class=\"on\"" : ""%>>출결관리</a>
    <a href="javascript:goPage('student', 'memo_student');" <%=depth2 == 4 ? "class=\"on\"" : ""%>>상담관리</a>
    <a href="javascript:prepare();" <%=depth2 == 5 ? "class=\"on\"" : ""%>>셔틀버스</a>
    <a href="javascript:goPage('payment', 'lecture_payment_list');" <%=depth2 == 6 ? "class=\"on\"" : ""%>>수강료납부</a>
</nav>


