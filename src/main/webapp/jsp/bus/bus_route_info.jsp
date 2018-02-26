<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String driverId = Util.isNullValue(request.getParameter("driver_id"), "");
    int depth1 = 5;
    int depth2 = 3;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/busService.js'></script>
<script>
    function init() {
        gfn_emptyView("V", comment.not_bus_route_info);
        fn_search("new");
    }

    function fn_search(val) {
        var driverId = '<%=driverId%>';

        busService.getDriverRouteList(driverId, function(routeList) {
            if (routeList.length == 0) return;
            gfn_emptyView("H", "");
            var cnt = routeList.length;
            dwr.util.addRows("dataList", routeList, [
                function (data) { return cnt--;},
                function (data) { return data.routeNumber; },
                function (data) { return "<a href=\"javascript:goModifyBusInfo('bus', 'modify_bus_route', '" + data.busIdx + "')\" class=\"font_color blue\">"+ data.startRouteName + "-" + data.endRouteName +"</a>"; },
                function (data) { return data.attendCount + data.dismissCount; },
                function (data) { return convert_bus_type(data.busType); },
                function (data) { return data.applyStartDate + " ~ " + data.applyEndDate; },
            ], {escapeHtml:false});
        });
    }
    //수정페이지 이동
    function goModifyBusInfo(mapping_value, page_value, busId) {
        with(document.frm) {
            if (mapping_value != "" && page_value != "") {
                page_gbn.value = page_value;
                bus_id.value = busId;
            }
            action = getContextPath()+"/"+mapping_value+".do";
            submit();
        }
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
    <%--<h4 class="title_t1"><span>강수원</span> 선생님의 노선 정보입니다.</h4>--%>
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="sPage" value="<%=sPage%>">
        <input type="hidden" name="driver_id" value="<%=driverId%>">
        <input type="hidden" name="bus_id">
    </form>

    <div class="tb_t1">
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>노선번호</th>
                    <th>노선명</th>
                    <th>정차위치</th>
                    <th>구분</th>
                    <th>적용기간</th>
                </tr>
            </thead>
            <tbody id="dataList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
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

