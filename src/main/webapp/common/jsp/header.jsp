<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="wrap">
    <header id="header">
        <h1><img src="" alt=""></h1>
        <button class="toggle_aside"></button>
        <nav id="lnb" class="depth1">
            <a href="javascript:goPage('dashboard', 'dashboard_list')" ><span class="fa fa-home"  <%=depth1 == 1 ? "style=\"font-size:26px;color:#03a9f4;\"" : ""%>></span>대시보드</a>
            <a href="javascript:goPage('student', 'save_student')"><span class="fa fa-user" <%=depth1 == 2 ? "style=\"font-size:26px;color:#03a9f4;\"" : ""%>></span>학생관리</a>
            <a href="javascript:goPage('academy', 'list_academy')"><span class="fa fa-university" <%=depth1 == 3 ? "style=\"font-size:26px;color:#03a9f4;\"" : ""%>></span>학원정보</a>
            <a href="javascript:goPage('member', 'save_member')"><span class="fa fa-address-card" <%=depth1 == 4 ? "style=\"font-size:26px;color:#03a9f4;\"" : ""%>></span>운영자/선생님정보</a>
            <a href="javascript:goPage('lecture', 'lecture_info')"><span class="fa fa-pencil" <%=depth1 == 5 ? "style=\"font-size:26px;color:#03a9f4;\"" : ""%>></span>강의관리</a>
            <a href="javascript:goPage('template', 'formType1')"><span class="fa fa-pencil"></span>프론트 개발 페이지</a>
            <a href="javascript:goLogout();"><span class="fa fa-power-off"></span>로그아웃</a>
        </nav>
    </header>