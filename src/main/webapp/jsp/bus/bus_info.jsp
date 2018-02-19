<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script>
    function init() {
        searchAcademySelectbox("sel_academy","");//소속
    }

    function fn_search(val) {

    }
</script>
<body onload="init();">
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/member_top_menu.jsp" %>--%>
    <div class="title-top">운영관리</div>
</div>
</section>
<section class="content">
    <h3 class="title_t1">셔틀버스관리</h3>
    <form name="frm" method="get">
        <input type="hidden" name="member_id" id="member_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    </form>

    <div class="tb_t1">
        <table>
            <tr>
                <th>소속</th>
                <td>
                    <select id="sel_academy" class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>소속정보</th>
                <td>
                    <div class="form-group row marginX">
                        <select class="form-control select-space">
                            <option>선택</option>
                            <option>소속</option>
                            <option>노선명</option>
                            <option>기사명</option>
                        </select>
                        <input type="text" class="form-control">
                    </div>
                </td>
            </tr>
        </table>
        <button class="btn_pack blue">검색</button>
    </div>

    <div class="tb_t1 top-space">
        <table>
            <thead>
            <tr>
                <th>No.</th>
                <th>소속</th>
                <th>노선명</th>
                <th>기사명</th>
                <th>차량번호</th>
                <th>핸드폰번호</th>
                <th>기간</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>2</td>
                <td>수학의아침 초등관</td>
                <td>정든 / 수내</td>
                <td><a href="javascript:goPage('bus', 'driver_info')" class="font_color blue">백승주</a></td>
                <td>경기 70아 5689</td>
                <td>010-4794-5987</td>
                <td>2018-01-02 ~ 2018-02-28</td>
            </tr>
            <tr>
                <td>1</td>
                <td>수학의아침 초등관</td>
                <td>서판교 / 서판교</td>
                <td><a href="#" class="font_color blue">임광철</a></td>
                <td>경기 70아 1234</td>
                <td>010-2345-5678</td>
                <td>2018-01-02 ~ 2018-02-28</td>
            </tr>
            </tbody>
        </table>
        <button class="btn_pack s2 blue" onclick="javascript:goPage('bus', 'save_driver')">등록</button>
    </div>

</section>
<%@include file="/common/jsp/footer.jsp" %>

<script>
    $(".sidebar-menu > li").eq(5).addClass("active");
    $(".sidebar-menu > li:nth-child(6) > ul > li:nth-child(2) > a").addClass("on");

</script>

</body>

