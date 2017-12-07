<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
    nav ul{padding-top:10px;}
    nav ul li {display:inline;border-left:1px solid #999;font:bold 12px Dotum;padding:0 10px;}
    nav ul li:first-child{border-left:none;}
    nav ul li:hover{color:#ff0000;cursor:pointer;}
</style>
<!--상단메뉴-->
<div>
    <nav>
        <ul>
            <li onclick="goPage('student', 'modify_student')">학생정보/수정</li>
            <li onclick="goPage('student', 'lecture_student')">수강이력</li>
            <li>학습관리</li>
            <li onclick="goPage('student', 'memo_student')">상담관리</li>
            <li>셔틀버스</li>
            <li onclick="goPage('payment', 'lecture_payment_list')">수강료납부</li>
        </ul>
    </nav>
</div>
<!--상단메뉴끝-->