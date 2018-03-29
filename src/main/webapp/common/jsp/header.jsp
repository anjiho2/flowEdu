<%@ page import="com.flowedu.session.UserSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String academyThumbnail = UserSession.academyThumbnail();
%>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/authService.js'></script>
<script>
    function init() {
        authService.getLeftMenuInfo(function(selList) {
            if (selList.length == 0) {
                return;
            }
            console.log(selList);
            for (var i=0; i<selList.length; i++) {
                var cmpList = selList[i];
                console.log(cmpList.mainMenuName);
                var subMenu = cmpList.subMenus;
                for (var j=0; j<subMenu.length; j++) {
                    var cmpList2 = subMenu[j];
                    console.log(cmpList2.subMenuName);
                }
            }
        });
    }
</script>
<div id="wrap" >
    <header id="header">
        <div style="margin-left: 22px;">
            <img id="academy_img" src="<%=academyThumbnail%>" alt="" style="width: auto; height: 80px">
        </div>
        <button class="toggle_aside"></button>

        <nav id="lnb" class="depth1">
            <ul class="sidebar-menu">

                <%--<li><a href="#"><span class="fa fa-times menu_close_btn"></span></a></li>--%>
                <li><a href="javascript:goPage('dashboard', 'dashboard_list')" >메인</a></li>
                <li><a href="#">학생관리</a>
                    <ul class="sidebar-submenu">
                        <li><a href="javascript:goPage('student', 'student_list')" ><span class="fa fa-user"></span>학생관리</a></li>
                        <li><a href="#"><span class="fa fa-headphones"></span>상담관리</a></li>
                    </ul>
                </li>
                <li><a href="#">학습관리</a>
                    <ul class="sidebar-submenu">
                        <li><a href="javascript:goPage('lecture', 'lecture_attend_list')" ><span class="fa fa-address-book"></span>출결관리</a></li>
                        <li><a href="javascript:goPage('lecture', 'assignment_list')"><span class="fa fa-book"></span>과제관리</a></li>
                    </ul>
                </li>
                <%--<li><a href="javascript:goPage('consult', 'early_consult_memo')" <%=depth1 == 3 ? "class='on'" : ""%>>학습관리</a></li>--%>
                <li><a href="#">행정관리</a>
                    <ul class="sidebar-submenu">
                        <li><a href="javascript:goPage('academy', 'list_academy')"><span class="fa fa-building"></span>학원관리</a></li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:goPage('lecture', 'lecture_list')">강의관리</a>
                    <ul class="sidebar-submenu">
                        <li><a href=""><span class="fa far fa-calendar"></span>반관리</a></li>
                        <li><a href=""><span class="fa far fa-credit-card"></span>수강료관리</a></li>
                        <li><a href="javascript:goPage('lecture', 'lecture_list')"><span class="fa far fa-bell"></span>강의관리</a></li>
                    </ul>
                </li>

                <li><a href="#">운영관리</a>
                    <ul class="sidebar-submenu">
                        <li><a href="javascript:goPage('member', 'list_member')"><span class="fa fa-address-card"></span>운영자관리</a></li>
                        <li><a href="javascript:goPage('bus', 'bus_info')"><span class="fa fa-bus"></span>셔틀버스관리</a></li>
                    </ul>
                </li>
                <li><a href="javascript:goPage('', '')">커뮤니티관리</a></li>
                <li><a href="javascript:goPage('', '')">ERP</a></li>
                <li><a href="javascript:goPage('', '')">시스템관리</a></li>
                <%--<li><a href="javascript:goPage('template', 'formType1')" <%=depth1 == 10 ? "class='on'" : ""%>>프론트 개발 페이지</a></li>--%>
                <%--<li><a href="javascript:goLogout();"><span class="fa fa-power-off"></span>로그아웃</a></li>--%>

            </ul>
        </nav>

    </header>

<script>
    init();
    $.sidebarMenu($('.sidebar-menu'));

    $(".sidebar-menu > li").eq(<%=siderMenuDepth1%>).addClass("active");
    $(".sidebar-menu > li:nth-child(<%=siderMenuDepth2%>) > ul > li:nth-child(<%=siderMenuDepth3%>) > a").addClass("on");
</script>



