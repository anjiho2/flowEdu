<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/busService.js'></script>
<script>
    function init() {
        searchAcademySelectbox("sel_academy","");//소속
        gfn_emptyView("V", comment.blank_bus_info);
    }

    function fn_search(val) {
        dwr.util.removeAllRows("dataList");
        var paging = new Paging();
        var sPage = $("#sPage").val();

        if(val == "new") sPage = "1";

        var sel_academy  = getSelectboxValue("sel_academy");//소속
        var sel_businfo  = getSelectboxValue("sel_businfo");//소속정보
        var businfoValue = getInputTextValue("businfoValue");
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");
        busService.getDriverListCount(sel_academy, sel_businfo, businfoValue, function(cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            busService.getDriverList(sPage, '10', sel_academy, sel_businfo, businfoValue, function (selList) {
                if (selList.length > 0) {
                    console.log(selList);
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var driver_date = cmpList.applyStartDate + " ~ " + cmpList.applyEndDate;
                        var nameHTML =  "<a href='javascript:void(0);' onclick='businfo_modify("+ cmpList.driverIdx +")' style='color:blue;'>" + cmpList.driverName + "</a>";

                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return i+1;},
                                function(data) {return cmpList.officeName;},//소속
                                function(data) {return cmpList.startRouteName;},//노선명
                                function(data) {return nameHTML;},//기사명
                                function(data) {return cmpList.busNumber;},//차량번호
                                function(data) {return cmpList.phoneNumber;},//핸드폰번호
                                function(data) {return driver_date;},//기간
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }else{
                    gfn_emptyView("V", comment.blank_list2);
                }
            });
        });
    }

    function businfo_modify(busdriver_id) {
        innerValue("busdriver_id", busdriver_id);
        goPage('bus', 'driver_info');
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
        <input type="hidden" name="busdriver_id" id="busdriver_id">
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
                        <select class="form-control select-space" id="sel_businfo">
                            <option value="">선택</option>
                            <option value="office">소속</option>
                            <option value="route">노선명</option>
                            <option value="driver">기사명</option>
                        </select>
                        <input type="text" class="form-control" id="businfoValue">
                    </div>
                </td>
            </tr>
        </table>
        <button class="btn_pack blue" onclick="fn_search('new')">검색</button>
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
            <tbody id="dataList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
        <button class="btn_pack s2 blue" onclick="javascript:goPage('bus', 'save_driver')">등록</button>
    </div>
    <%@ include file="/common/inc/com_pageNavi.inc" %>
</section>
<%@include file="/common/jsp/footer.jsp" %>

<script>
    $(".sidebar-menu > li").eq(5).addClass("active");
    $(".sidebar-menu > li:nth-child(6) > ul > li:nth-child(2) > a").addClass("on");

</script>

</body>

