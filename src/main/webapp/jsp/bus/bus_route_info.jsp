<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 5;
    int depth2 = 3;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<body onload="init();">
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/bus_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <h4 class="title_t1"><span>강수원</span> 선생님의 노선 정보입니다.</h4>
    <form name="frm" method="get">
        <input type="hidden" name="member_id" id="member_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    </form>

    <div class="tb_t1">
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>노선벙호</th>
                    <th>노선명</th>
                    <th>정차위치</th>
                    <th>구분</th>
                    <th>적용기간</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>2</td>
                    <td>정규 07호</td>
                    <td><a href="#" class="font_color blue">샛별-파크타운</a></td>
                    <td>7</td>
                    <td>학기중</td>
                    <td>2018-02-05 ~ 2018-02-09</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>정규 07호</td>
                    <td><a href="#" class="font_color blue">샛별-파크타운</a></td>
                    <td>7</td>
                    <td>방학중</td>
                    <td>2018-01-02 ~ 2018-02-28</td>
                </tr>
            </tbody>
        </table>
        <button class="btn_pack s2 blue" onclick="javascript:goPage('bus', 'save_bus_route')">등록</button>
    </div>
</section>
<%@include file="/common/jsp/footer.jsp" %>

<script>
    $(".sidebar-menu > li").eq(5).addClass("active");
    $(".sidebar-menu > li:nth-child(6) > ul > li:nth-child(2) > a").addClass("on");
</script>

</body>

