<%@ page import="com.flowedu.session.UserSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String academyThumbnail = UserSession.academyThumbnail();
%>




<div id="wrap">
    <header id="header">
        <div style="margin-left: 22px;">
            <img id="academy_img" src="<%=academyThumbnail%>" alt="" style="width: auto; height: 80px">
        </div>
        <button class="toggle_aside"></button>
        <nav id="lnb" class="depth1">
            <ul class="main_lnb">
                <%--<li><a href="#"><span class="fa fa-times menu_close_btn"></span></a></li>--%>
                <li><a href="javascript:goPage('dashboard', 'dashboard_list')" <%=depth1 == 1 ? "class='on'" : ""%>>메인</a></li>
                <li><a href="javascript:goPage('student', 'save_student')" <%=depth1 == 2 ? "class='on'" : ""%>>학생관리</a>
                    <ul class="sub_lnb">
                        <li><a href="#"><span class="fa fa-user"></span>학생관리</a></li>
                        <li><a href="#"><span class="fa fa-headphones"></span>상담관리</a></li>
                    </ul>
                </li>
                <li><a href="javascript:goPage('consult', 'early_consult_memo')" <%=depth1 == 3 ? "class='on'" : ""%>>학습관리</a></li>
                <li><a href="javascript:goPage('academy', 'list_academy')" <%=depth1 == 4 ? "class='on'" : ""%>>행정관리</a></li>
                <li><a href="javascript:goPage('member', 'list_member')" <%=depth1 == 5 ? "class='on'" : ""%>>경영관리</a></li>
                <li><a href="javascript:goPage('lecture', 'lecture_list')" <%=depth1 == 6 ? "class='on'" : ""%>>운영세팅관리</a></li>
                <li><a href="javascript:goPage('', '')" <%=depth1 == 7 ? "class='on'" : ""%>>커뮤니티관리</a></li>
                <li><a href="javascript:goPage('', '')" <%=depth1 == 8 ? "class='on'" : ""%>>ERP</a></li>
                <li><a href="javascript:goPage('', '')" <%=depth1 == 9 ? "class='on'" : ""%>>시스템관리</a></li>
                <li><a href="javascript:goPage('template', 'formType1')" <%=depth1 == 10 ? "class='on'" : ""%>>프론트 개발 페이지</a></li>
                <%--<li><a href="javascript:goLogout();"><span class="fa fa-power-off"></span>로그아웃</a></li>--%>
            </ul>
        </nav>
    </header>

<%--<div id="wrap">--%>
    <%--<header id="header">--%>
        <%--<h1><img src="" alt=""></h1>--%>
        <%--<button class="toggle_aside"></button>--%>
        <%--<nav id="lnb" class="depth1">--%>
            <%--&lt;%&ndash;<a href="#"><span class="fa fa-times menu_close_btn"></span></a>&ndash;%&gt;--%>
            <%--<a href="javascript:goPage('dashboard', 'dashboard_list')" <%=depth1 == 1 ? "class='on'" : ""%>><span class="fa fa-home "  ></span>대시보드</a>--%>
            <%--<a href="javascript:goPage('student', 'save_student')" <%=depth1 == 2 ? "class='on'" : ""%>><span class="fa fa-user"></span>학생관리</a>--%>
            <%--<a href="javascript:goPage('consult', 'early_consult_memo')" <%=depth1 == 3 ? "class='on'" : ""%>><span class="fa fa-headphones"></span>초기상담</a>--%>
            <%--<% if (memberType.equals("ADMIN") || memberType.equals("OPERATOR")) {  %>--%>
                <%--<a href="javascript:goPage('academy', 'list_academy')" <%=depth1 == 4 ? "class='on'" : ""%>><span class="fa fa-university"></span>학원정보</a>--%>
                <%--<a href="javascript:goPage('member', 'list_member')" <%=depth1 == 5 ? "class='on'" : ""%>><span class="fa fa-address-card"></span>운영자/선생님정보</a>--%>
            <%--<% } %>--%>
            <%--<a href="javascript:goPage('lecture', 'lecture_list')" <%=depth1 == 6 ? "class='on'" : ""%>><span class="fa fa-pencil"></span>강의관리</a>--%>
            <%--<a href="javascript:goPage('template', 'formType1')" <%=depth1 == 7 ? "class='on'" : ""%>><span class="fa fa-pencil"></span>프론트 개발 페이지</a>--%>
            <%--<a href="javascript:goLogout();"><span class="fa fa-power-off"></span>로그아웃</a>--%>
        <%--</nav>--%>
    <%--</header>--%>


    <!--여기까지-->
