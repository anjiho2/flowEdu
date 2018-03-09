<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 4;
    int depth2 = 3;

    int siderMenuDepth1 = 4;
    int siderMenuDepth2 = 3;
    int siderMenuDepth3 = 4;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/busService.js'></script>


<body onload="init();">
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/lecture_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
    </form>

    <div class="tb_t1">
        <table>
            <thead>
            <tr>
                <th>강의명</th>
                <td>
                    <span>수학의아침</span>
                </td>
                <th>선생님</th>
                <td>
                    <span>원소정</span>
                </td>
            </tr>
            <tr>
                <th>강의실</th>
                <td>
                    <span>201호</span>
                </td>
                <th>수강료</th>
                <td>
                    <span>50,000</span>
                </td>
            </tr>
            <tr>
                <th>정원</th>
                <td>
                    <span>50</span>
                </td>
                <th>현재인원</th>
                <td>
                    <span>30</span>
                </td>
            </tr>
        </table>
    </div>
</section>
<section class="content">
    <h3 class="title_t1">기존 수강중인 학생</h3>
    <div class="tb_t1">
        <table>
            <thead>
            <tr>
                <th>이름</th>
                <th>학교</th>
                <th>변경</th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
            <tr>
                <td>홍길동</td>
                <td>문막초등학교</td>
                <td>x</td>
            </tr>
            <tr>
                <td>홍길동</td>
                <td>문막초등학교</td>
                <td>x</td>
            </tr>
            <tr>
                <td>홍길동</td>
                <td>문막초등학교</td>
                <td>x</td>
            </tr>
            <tr>
                <td>홍길동</td>
                <td>문막초등학교</td>
                <td>x</td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center">현재인원 0명 / 18명 추가 가능
                <button class="btn_pack blue s2" >추가</button>
            </tr>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
        <button class="btn_pack blue s2" >저장</button>
        <button class="btn_pack blue s2" onclick="go_list();">목록</button>
    </div>
</section>
<%@include file="/common/jsp/footer.jsp" %>
</body>

