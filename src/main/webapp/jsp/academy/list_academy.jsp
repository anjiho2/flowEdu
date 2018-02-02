<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 4;
    int depth2 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type="text/javascript">

    function academy_modify(office_id) { //수정페이지 이동
        innerValue("office_id", office_id);
        goPage('academy', 'modify_academy');
    }

    function init(group_id) {
        var dateKind = get_radio_value("date_kind");
        if (dateKind == "0") {
            innerValue("startDate", today());
            innerValue("endDate", today());
        }
        academyListBySearch('academy_list', group_id);

        gfn_emptyView("V", comment.search_academy);
    }
    
    function fn_search(val) { //학원정보리스트 가져오기
        var paging = new Paging();
        var sPage = $("#sPage").val();
        if(val == "new") sPage = "1";

        gfn_emptyView("H", "");

        var groupId = getSelectboxValue("academy_group");
        var officeId = getSelectboxValue("sel_academyList");
        var startDate = getInputTextValue("startDate");
        var endDate = getInputTextValue("endDate");
        var regType = getSelectboxValue("sel_regType");
        var searchText = getInputTextValue("search_text");

        if (groupId == "all") groupId = 0;
        if (officeId == "all") officeId = 0;

        academyService.getAcademyListBySearchCount(groupId, officeId, startDate, endDate, regType, searchText, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list2);

            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링

            academyService.getAcademyListBySearch(sPage, "10", groupId, officeId, startDate, endDate, regType, searchText, function (selList) {
                if (selList.length > 0) {
                    dwr.util.removeAllRows("dataList");
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var academyHTML = "<a href='javascript:void(0);' class='font_color blue' onclick='academy_modify(" + cmpList.officeId + ");'/>" + cmpList.officeName + "</a>";
                            //var acaName = "<span class='mini'>"+cmpList.academyGroupName+"</span><div class='title'>"+cmpList.officeName+"</div>";
                            var cellData = [
                                function(data) {return listNum--;},
                                function(data) {return cmpList.academyGroupName;},
                                function(data) {return academyHTML;},
                                function(data) {return fn_tel_tag(cmpList.officeTelNumber);},
                                function(data) {return getDateTimeSplitComma(cmpList.createDate);},
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }
            });
        });
    }
    //날짜 선택 라디오박스 이벤트
    $(document).ready(function() {
        $('input[type=radio][name=date_kind]').change(function() {
            var dateKind = this.value;
            var oldDate = getDayAgo(dateKind);
            var now = today();
            if (dateKind == 0) {
                oldDate = now;
            }
            innerValue("startDate", oldDate);
            innerValue("endDate", now);
        });
    });
</script>
<body onload="init();academyGroupBySearch('academy_group', '');">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/academy_top_menu.jsp" %>--%>
    <div class="title-top">행정관리</div>
</div>
</section>
<section class="content">
    <h3 class="title_t1">학원관리</h3>
    <form name="frm" method="get">
        <input type="hidden" name="office_id" id="office_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden"  id="sPage" value="<%=sPage%>">
    </form>
    <!-- 검색 영역 시작 -->
    <div class="tb_t1">
        <table>
            <tbody>
            <tr>
                <th>그룹</th>
                <td>
                    <select id="academy_group" class="form-control" onchange="init(this.value);">
                        <option value="all">▶전체</option>
                    </select>
                </td>
                <th>학원</th>
                <td>
                    <span id="academy_list"></span>
                </td>
            </tr>
            <tr>
                <th>생성일</th>
                <td colspan="3">
                    <div class="form-group row marginX">
                        <div class="input-group date common" style="margin-right:10px;">
                            <input type="text" id="startDate" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                        <div class="input-group date common" style="margin-right:10px;">
                            <input type="text" id="endDate" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                        <div class="checkbox_t1 black">
                            <label>
                                <input type="radio" name="date_kind" value="0" checked>
                                <span>오늘</span>
                            </label>
                            <label>
                                <input type="radio" name="date_kind" value="7">
                                <span>7일</span>
                            </label>
                            <label>
                                <input type="radio" name="date_kind" value="30">
                                <span>30일</span>
                            </label>
                            <label>
                                <input type="radio" name="date_kind" value="60">
                                <span>60일</span>
                            </label>
                            <label>
                                <input type="radio" name="date_kind" value="90">
                                <span>90일</span>
                            </label>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>등록 정보</th>
                <td colspan="3">
                    <div class="form-group row marginX">
                        <select id="sel_regType" class="form-control" style="width: 13rem;margin-right:10px;">
                            <%--<option value="name">이름</option>--%>
                            <option value="group_name">그룹명</option>
                            <option value="academy_name">학원명</option>
                        </select>
                        <input type="text" id="search_text" class="form-control">
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <button class="btn_pack blue" onclick="fn_search('new')">검색</button>
    </div>
    <!-- 검색 영역 끝 -->
    <!-- 검색 결과 리스트 테이블 시작 -->
    <div class="tb_t1" style="margin-top:2.5rem;">
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>그룹명</th>
                    <th>학원명</th>
                    <%--<th>원장명</th>--%>
                    <th>전화번호</th>
                    <th>생성일</th>
                </tr>
            </thead>
            <tbody id="dataList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
        <br>
        <%@ include file="/common/inc/com_pageNavi.inc" %>
        <button class="btn_pack s2 blue" onclick="javascript:goPage('academy', 'modify_academy')">등록</button>
    </div>
    <!-- 검색 결과 리스트 테이블 끝 -->
</section>
</body>
<script>
    $(".sidebar-menu > li").eq(3).addClass("active");
    $(".sidebar-menu > li:nth-child(4) > ul > li:nth-child(1) > a").addClass("on");
</script>
</html>
