<%@ page import="com.flowedu.session.UserSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String academyThumbnail = UserSession.academyThumbnail();
%>


<style>
    .animate-menu-push {
        left: 0;
        position: relative;
        transition: all 0.3s ease; }
    .animate-menu-push.animate-menu-push-right {
        left: 200px; }
    .animate-menu-push.animate-menu-push-left {
        left: -200px; }

    .animate-menu {
        position: fixed;
        top: 0;
        width: 200px;
        height: 100%;
        transition: all 0.3s ease; }

    .animate-menu-left {
        left: -200px; }
    .animate-menu-left.animate-menu-open {
        left: 0; }

    .animate-menu-right {
        right: -200px; }
    .animate-menu-right.animate-menu-open {
        right: 0; }

    .sidebar-menu {
        list-style: none;
        margin: 0;
        padding: 0;
        background-color: #222d32; }
    .sidebar-menu > li {
        position: relative;
        margin: 0;
        padding: 0; }
    .sidebar-menu > li > a {
        padding: 12px 5px 12px 15px;
        display: block;
        border-left: 3px solid transparent;
        color: #b8c7ce; }
    .sidebar-menu > li > a > .fa {
        width: 20px; }
    .sidebar-menu > li:hover > a, .sidebar-menu > li.active > a {
        color: #fff;
        background: #1e282c;
        border-left-color: #3c8dbc; }
    .sidebar-menu > li .label,
    .sidebar-menu > li .badge {
        margin-top: 3px;
        margin-right: 5px; }
    .sidebar-menu li.sidebar-header {
        padding: 10px 25px 10px 15px;
        font-size: 12px;
        color: #4b646f;
        background: #1a2226; }
    .sidebar-menu li > a > .fa-angle-left {
        width: auto;
        height: auto;
        padding: 0;
        margin-right: 10px;
        margin-top: 3px; }
    .sidebar-menu li.active > a > .fa-angle-left {
        transform: rotate(-90deg); }
    .sidebar-menu li.active > .sidebar-submenu {
        display: block; }
    .sidebar-menu a {
        color: #b8c7ce;
        text-decoration: none; }
    .sidebar-menu .sidebar-submenu {
        display: none;
        list-style: none;
        padding-left: 5px;
        margin: 0 1px;
        background: #2c3b41; }
    .sidebar-menu .sidebar-submenu .sidebar-submenu {
        padding-left: 20px; }
    .sidebar-menu .sidebar-submenu > li > a {
        padding: 5px 5px 5px 15px;
        display: block;
        font-size: 14px;
        color: #8aa4af; }
    .sidebar-menu .sidebar-submenu > li > a > .fa {
        width: 20px; }
    .sidebar-menu .sidebar-submenu > li > a > .fa-angle-left,
    .sidebar-menu .sidebar-submenu > li > a > .fa-angle-down {
        width: auto; }
    .sidebar-menu .sidebar-submenu > li.active > a, .sidebar-menu .sidebar-submenu > li > a:hover {
        color: #fff; }

    .sidebar-menu-rtl {
        list-style: none;
        margin: 0;
        padding: 0;
        background-color: #222d32; }
    .sidebar-menu-rtl > li {
        position: relative;
        margin: 0;
        padding: 0; }
    .sidebar-menu-rtl > li > a {
        padding: 12px 15px 12px 5px;
        display: block;
        border-left: 3px solid transparent;
        color: #b8c7ce; }
    .sidebar-menu-rtl > li > a > .fa {
        width: 20px; }
    .sidebar-menu-rtl > li:hover > a, .sidebar-menu-rtl > li.active > a {
        color: #fff;
        background: #1e282c;
        border-left-color: #3c8dbc; }
    .sidebar-menu-rtl > li .label,
    .sidebar-menu-rtl > li .badge {
        margin-top: 3px;
        margin-right: 5px; }
    .sidebar-menu-rtl li.sidebar-header {
        padding: 10px 15px 10px 25px;
        font-size: 12px;
        color: #4b646f;
        background: #1a2226; }
    .sidebar-menu-rtl li > a > .fa-angle-left {
        width: auto;
        height: auto;
        padding: 0;
        margin-right: 10px;
        margin-top: 3px; }
    .sidebar-menu-rtl li.active > a > .fa-angle-left {
        transform: rotate(-90deg); }
    .sidebar-menu-rtl li.active > .sidebar-submenu {
        display: block; }
    .sidebar-menu-rtl a {
        color: #b8c7ce;
        text-decoration: none; }
    .sidebar-menu-rtl .sidebar-submenu {
        display: none;
        list-style: none;
        padding-right: 5px;
        margin: 0 1px;
        background: #2c3b41; }
    .sidebar-menu-rtl .sidebar-submenu .sidebar-submenu {
        padding-right: 20px; }
    .sidebar-menu-rtl .sidebar-submenu > li > a {
        padding: 5px 15px 5px 5px;
        display: block;
        font-size: 14px;
        color: #8aa4af; }
    .sidebar-menu-rtl .sidebar-submenu > li > a > .fa {
        width: 20px; }
    .sidebar-menu-rtl .sidebar-submenu > li > a > .fa-angle-left,
    .sidebar-menu-rtl .sidebar-submenu > li > a > .fa-angle-down {
        width: auto; }
    .sidebar-menu-rtl .sidebar-submenu > li.active > a, .sidebar-menu-rtl .sidebar-submenu > li > a:hover {
        color: #fff; }

</style>

<ul class="sidebar-menu">
    <li class="sidebar-header">MAIN NAVIGATION</li>
    <li>
        <a href="#">
            <i class="fa fa-dashboard"></i> <span>Dashboard</span> <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="sidebar-submenu">
            <li><a href="../../index.html"><i class="fa fa-circle-o"></i> Dashboard v1</a></li>
            <li><a href="../../index2.html"><i class="fa fa-circle-o"></i> Dashboard v2</a></li>
        </ul>
    </li>
    <li>
        <a href="#">
            <i class="fa fa-files-o"></i>
            <span>Layout Options</span>
            <span class="label label-primary pull-right">4</span>
        </a>
        <ul class="sidebar-submenu" style="display: none;">
            <li><a href="top-nav.html"><i class="fa fa-circle-o"></i> Top Navigation</a></li>
            <li><a href="boxed.html"><i class="fa fa-circle-o"></i> Boxed</a></li>
            <li><a href="fixed.html"><i class="fa fa-circle-o"></i> Fixed</a></li>
            <li class=""><a href="collapsed-sidebar.html"><i class="fa fa-circle-o"></i> Collapsed Sidebar</a>
            </li>
        </ul>
    </li>
</ul>


<!--
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
                        <li><a href="javascript:goPage('dashboard', 'dashboard_list')"><span class="fa fa-user"></span>학생관리</a></li>
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
-->

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

<script>
    $.sidebarMenu($('.sidebar-menu'))
</script>
