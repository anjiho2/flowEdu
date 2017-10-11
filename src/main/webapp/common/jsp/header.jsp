<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="wrap">
    <header id="header">
        <h1><img src="" alt=""></h1>
        <button class="toggle_aside"></button>
        <nav id="lnb" class="depth1">
            <a href="javascript:goPage('dashboard', 'dashboard_list')" <%=depth1 == 1 ? "class='on'" : ""%>><span class="fa fa-home "  ></span>대시보드</a>
            <a href="javascript:goPage('student', 'save_student')" <%=depth1 == 2 ? "class='on'" : ""%>><span class="fa fa-user"></span>학생관리</a>
            <a href="javascript:goPage('consult', 'early_consult_memo')" <%=depth1 == 3 ? "class='on'" : ""%>><span class="fa fa-headphones"></span>초기상담</a>
            <% if (memberType.equals("ADMIN") || memberType.equals("OPERATOR")) {  %>
                <a href="javascript:goPage('academy', 'list_academy')" <%=depth1 == 4 ? "class='on'" : ""%>><span class="fa fa-university"></span>학원정보</a>
                <a href="javascript:goPage('member', 'list_member')" <%=depth1 == 5 ? "class='on'" : ""%>><span class="fa fa-address-card"></span>운영자/선생님정보</a>
            <% } %>
            <a href="javascript:goPage('lecture', 'lecture_list')" <%=depth1 == 6 ? "class='on'" : ""%>><span class="fa fa-pencil"></span>강의관리</a>
            <a href="javascript:goPage('template', 'formType1')" <%=depth1 == 7 ? "class='on'" : ""%>><span class="fa fa-pencil"></span>프론트 개발 페이지</a>
            <a href="javascript:goLogout();"><span class="fa fa-power-off"></span>로그아웃</a>
        </nav>
    </header>