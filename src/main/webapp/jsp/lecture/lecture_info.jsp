<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>

<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<style>
    /*초기화와 메뉴폭 지정*/
    #navi{padding:0;width:200px;margin:0;}
    #navi h2{margin: 0;padding: 0;}
    /*메인메뉴 스타일 지정*/
    #navi h2 a{display: block;font-weight: bold;text-decoration: none;margin: 0;padding: 10px;font-family:'돋움', sans-serif;font-size: 14px;color: #ccc;text-shadow: 0 1px 1px #000; background:#1d4ab3;background: -moz-linear-gradient(#1d4ab3 0%, #163887 100%);background: -webkit-linear-gradient(#1d4ab3 0%, #163887 100%);background: -o-linear-gradient(#1d4ab3 0%, #163887 100%);background: linear-gradient(#1d4ab3 0%, #163887 100%);}

    /*메인 메뉴에 대한 마우스 이벤트에 대한 효과 지정*/
    #navi :target h2 a,
    #navi h2 a:focus,
    #navi h2 a:hover,
    #navi h2 a:active{background:#1a1a1a;background:-moz-linear-gradient(#1a1a1a 0%, #000000 100%);background:-webkit-linear-gradient(#1a1a1a 0%, #000000 100%);background:-o-linear-gradient(#1a1a1a 0%, #000000 100%);background:linear-gradient(#1a1a1a 0%, #000000 100%);color:#eee;text-shadow: 0 1px 1px #000000;}
</style>
<script type="text/javascript">
function lecture_go(val) {
    if(val=="price"){
        goPage('lecture','lecture_price');
    }else if(val=="room"){
        goPage('lecture','lecture_room');
    }


}
</script>
<body>
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <div id="navi">
        <div id="menu1">
            <h2><a href="">강의관리</a></h2>
            <p><a onclick="lecture_go('price');">강의가격</a></p>
            <p><a onclick="lecture_go('room');">강의룸</a></p>
        </div>
    </div>
</form>
</body>
</html>
