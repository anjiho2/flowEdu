<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long busdriver_id = Long.parseLong(request.getParameter("busdriver_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/busService.js'></script>
<script>
    function init() {
        var busdriver_id = <%=busdriver_id%>;

        //gfn_emptyView("H", "");
        busService.getDriverHelperList(busdriver_id, function (sel) {
            var nameHTML = "<a href='javascript:void(0);' style='color:blue;' onclick='assister_page(" + sel.driverHelperIdx + ")'>" + sel.helperName + "</a>";
            var state;
            if(sel.serveYn == true) state = '재직';
            else state = '퇴사';
            innerHTML("sel_academy", sel.officeName);
            innerHTML("assister_name", nameHTML);
            innerHTML("state", state);
            innerHTML("regist_day", split_minute_getDay(sel.createDate));
        });
    }

    function assister_page(assister_id) {
        innerValue("assister_id", assister_id);
        goPage('bus', 'save_commute_assist');
    }
</script>
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
    <form name="frm" method="get">
        <input type="hidden" name="busdriver_id" id="busdriver_id" value="<%=busdriver_id%>">
        <input type="hidden" name="assister_id" id="assister_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
    </form>

    <div class="tb_t1">
        <table>
            <thead>
                <tr>
                    <th>소속</th>
                    <th>이름</th>
                    <th>상태</th>
                    <th>등록일</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><span id="sel_academy"></span></td>
                    <td><span id="assister_name"></span></td>
                    <td><span id="state"></span></td>
                    <td><span id="regist_day"></span></td>
                </tr>
            </tbody>
        </table>
        <button class="btn_pack s2 blue" onclick="javascript:goPage('bus', 'save_commute_assist')">등록</button>
    </div>
</section>
<%@include file="/common/jsp/footer.jsp" %>

<script>
    $(".sidebar-menu > li").eq(5).addClass("active");
    $(".sidebar-menu > li:nth-child(6) > ul > li:nth-child(2) > a").addClass("on");
</script>

</body>