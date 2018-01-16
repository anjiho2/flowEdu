<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 6;
    int depth2 = 4;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<body>
    <div class="container">
        <%@include file="/common/jsp/titleArea.jsp" %>
        <%@include file="/common/jsp/depth_menu.jsp" %>
    </div>
    </section>
    <!--여기부터-->
    <div style="border:solid 1px;width:700px;overflow: hidden;background: #fff;">
        <h2 style="border-bottom:solid 1px;width:100%;padding:20px;">플로우교육</h2>
        <div style="width:400px;margin:50px 150px;">
            <h3>이기훈님,</h3>
            <h4>회원 아이디는 다음과 같습니다.</h4><br>
            <table border="1" style="border-collapse: collapse;">
                <tr>
                    <td>이름</td>
                    <td>이기훈</td>
                </tr>
                <tr>
                    <td rowspan="3">아이디</td>
                    <td>등록번호 : 2017120001</td>
                </tr>
                <tr>
                    <td>휴대폰번호 : 01051360264</td>
                </tr>
                <tr>
                    <td>이메일 주소 : bond@flowedu.net</td>
                </tr>
            </table><br>
            <p>플로우교육은 쉽고 간편한 로그인을 위해<br>등록번호, 휴대폰번호, 이메일 주소 중 하나로<br>로그인이 가능하도록 서비스를 제공하고 있습니다.</p><br>
            <button style="background: #ccc;padding:10px 70px;border:none;"><a href="#" style="text-decoration: none;color:#000;">플로우교육 AMS 바로가기</a></button>
            <p style="margin:20px 0;">본 메일은 발신전용 메일 입니다.<br>관련문의는 고객센터(031-698-3403)를 이용해 주세요.</p>
            <div style="border-top:1px dashed;padding-top:20px;">
                플로우교육<br>경기도 성남시 분당구 수내동 16-6 N타워빌딩<br>COPYRIGTH&copy; FLOW EDU All rights reserved.
            </div>
        </div>
    </div>


    <!--여기까지-->
    </div>
<%@include file="/common/jsp/footer.jsp" %>
</body>

<style>
    .leftslide{height:100%; flex:0 0 250px; border:solid 1px;}
</style>

<script>
    $(function(){
        $('');

    });
</script>