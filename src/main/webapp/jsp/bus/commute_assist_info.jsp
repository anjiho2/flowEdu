<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long driver_id = Long.parseLong(request.getParameter("driver_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int depth1 = 5;
    int depth2 = 2;

    int siderMenuDepth1 = 5;
    int siderMenuDepth2 = 6;
    int siderMenuDepth3 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/busService.js'></script>
<script>
    function init() {
        gfn_emptyView("V", "통학도우미가 없습니다.");
        var busdriver_id = <%=driver_id%>;

        busService.getDriverHelperList(busdriver_id, function (list) {
            if (list.length == 0) return;
            gfn_emptyView("H", "");
            dwr.util.addRows("dataList", list, [
                function (data) { return data.officeName;},
                function (data) { return "<a href='javascript:void(0);' style='color:blue;' onclick='assister_page(" + data.driverHelperIdx + ")'>" + data.helperName + "</a>";},
                function (data) { return data.serveYn == true ? "재직" : "퇴사";},
                function (data) { return split_minute_getDay(data.createDate);},
            ], {escapeHtml:false});
        });
    }

    function assister_page(assister_id) {
        innerValue("assister_id", assister_id);
        goPage('bus', 'modify_assist_info');
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
        <input type="hidden" name="driver_id" id="busdriver_id" value="<%=driver_id%>">
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
            <tbody id="dataList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
        <button class="btn_pack s2 blue" onclick="javascript:goPage('bus', 'save_commute_assist')">등록</button>
    </div>
</section>
<%@include file="/common/jsp/footer.jsp" %>
</body>