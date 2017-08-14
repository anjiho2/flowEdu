<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<style>
    body {margin: 0;}
    #fixed-menu {width: 100%;background-color: #ffffff;position: fixed;  top: 0px;left: 0px;}
    #main-content {width: 100%;margin-top: 120px;}
    ul{ text-align:center;}
    #fixed-menu li {display: inline-block;margin-right: 40px;cursor: pointer;}
    ul li:last-child{margin-right: 0; }
    nav{margin-top: 20px;padding: 10px 0;border-top: 1px solid #969696;border-bottom: 1px solid #969696;}
    img {max-width: 100%;}
</style>
<body>
<form name="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <div id="fixed-menu">
        <nav>
            <ul>
                <li onclick="goPage('academy', 'save_academy')">학원정보</li>
                <li onclick="goPage('student', 'save_student')">원생정보</li>
                <li onclick="goPage('member', 'save_member')">운영자/선생님정보</li>
                <li onclick="goPage('lecture', 'lecture_info')">강의관리</li>
                <li onclick="goPage('lecture', 'lecture_price')">강의가격</li>
                <li onclick="goPage('lecture', 'lecture_room')">강의룸</li>
            </ul>
        </nav>
    </div>
    <div id="main-content">
        <!--content-->
    </div>
</form>
</body>
</html>
