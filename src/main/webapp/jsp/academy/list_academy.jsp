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

    function academy_modify(officeid) { //수정페이지 이동
        innerValue("office_id", officeid);
        goPage('academy', 'modify_academy');
    }

    function init(group_id) {
        var dateKind = get_radio_value("date_kind");
        if (dateKind == "0") {
            innerValue("startDate", today());
            innerValue("endDate", today());
        }
        academyListBySearch('academy_list', group_id);
        academyList();
    }
    
    function academyList() { //학원정보리스트 가져오기
        var officeId =0;
        academyService.getAcademyList(0, function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var modifyHTML = "<button class='btn_pack white' type='button' id='modify' onclick='academy_modify(" + cmpList.officeId + ");'/>수정</button>";
                        var acaName = "<span class='mini'>"+cmpList.academyGroupName+"</span><div class='title'>"+cmpList.officeName+"</div>";
                        var cellData = [
                             function(data) {return acaName;},                                                                                                                                                                                      
                            //function(data) {return cmpList.academyGroupName;},  //학원그룹명 추가로 기능 추가 (2017.09.12 안지호)
                            //function(data) {return cmpList.officeName;},
                            function(data) {return cmpList.officeDirectorName;},
                            function(data) {return cmpList.officeAddress;},
                            function(data) {return cmpList.officeTelNumber;},
                            function(data) {return cmpList.officeFaxNumber;},
                            function(data) {return getDateTimeSplitComma(cmpList.createDate);},
                            function(data) {return modifyHTML;}
                        ];
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                    }
                }
            }
        });
    }

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
    <!--여기서부터 원래 만들어진-->
    <form name="frm" method="get">
        <input type="hidden" name="office_id" id="office_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden"  id="sPage" value="<%=sPage%>">
        <%--<div class="tb_t1">--%>
            <%--<table>--%>
                <%--<colgroup>--%>
                    <%--<col width="*" />--%>
                    <%--<col width="*" />--%>
                    <%--<col width="*" />--%>
                    <%--<col width="*" />--%>
                    <%--<col width="*" />--%>
                    <%--<col width="*" />--%>
                    <%--<col width="*" />--%>
                <%--</colgroup>--%>
                <%--<thead>--%>
                <%--<tr>--%>
                    <%--<th>그룹 / 관</th>--%>
                    <%--<th>원장명</th>--%>
                    <%--<th>주소</th>--%>
                    <%--<th>관전화번호</th>--%>
                    <%--<th>팩스번호</th>--%>
                    <%--<th>생성일</th>--%>
                    <%--<th>수정</th>--%>
                <%--</tr>--%>
                <%--<tbody id="dataList"></tbody>--%>
                <%--<tr>--%>
                    <%--<td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>--%>
                <%--</tr>--%>
            <%--</table>--%>
            <%--<%@ include file="/common/inc/com_pageNavi.inc" %>--%>
        <%--</div>--%>
    </form>
    <!--여기까지-->
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

                    <%--<select id="academy_list" class="form-control">--%>
                        <%--<option value="all">▶전체</option>--%>
                    <%--</select>--%>
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
                        <select class="form-control" style="width: 13rem;margin-right:10px;">
                            <option value="">이름</option>
                            <option value="">그룹명</option>
                            <option value="">학원명</option>
                        </select>
                        <input type="text" class="form-control">
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <button class="btn_pack blue">검색</button>
    </div>

    <div class="tb_t1" style="margin-top:2.5rem;">
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>그룹명</th>
                    <th>학원명</th>
                    <th>원장명</th>
                    <th>전화번호</th>
                    <th>생성일</th>
                </tr>
            </thead>
            <tbody id="dataList">

                <%--<tr>--%>
                    <%--<td>4</td>--%>
                    <%--<td>플로우교육</td>--%>
                    <%--<td><a href="javascript:goPage('academy', 'modify_academy')" class="font_color blue">사이언스카이 중등관</a></td>--%>
                    <%--<td>양창환</td>--%>
                    <%--<td>031-717-1114</td>--%>
                    <%--<td>2018-01-01 15:00:01</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<td>3</td>--%>
                    <%--<td>스타트업플래닛</td>--%>
                    <%--<td><a href="javascript:goPage('academy', 'modify_academy')" class="font_color blue">TEdI</a></td>--%>
                    <%--<td>유빛나</td>--%>
                    <%--<td>031-717-1113</td>--%>
                    <%--<td>2018-01-01 15:00:01</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<td>2</td>--%>
                    <%--<td>플로우교육</td>--%>
                    <%--<td><a href="javascript:goPage('academy', 'modify_academy')" class="font_color blue">수학의아침 초등관</a></td>--%>
                    <%--<td>나원래</td>--%>
                    <%--<td>031-717-1112</td>--%>
                    <%--<td>2018-01-01 15:00:01</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<td>1</td>--%>
                    <%--<td>스타트업플래닛</td>--%>
                    <%--<td><a href="javascript:goPage('academy', 'modify_academy')" class="font_color blue">다빈치톡</a></td>--%>
                    <%--<td>김학원</td>--%>
                    <%--<td>031-717-1111</td>--%>
                    <%--<td>2018-01-01 15:00:01</td>--%>
                <%--</tr>--%>

            </tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
            <%@ include file="/common/inc/com_pageNavi.inc" %>
        </table>
        <button class="btn_pack s2 blue" onclick="javascript:goPage('academy', 'modify_academy')">등록</button>
    </div>
    <%@ include file="/common/inc/com_pageNavi.inc" %>

</section>
</body>
<script>
    $(".sidebar-menu > li").eq(3).addClass("active");
    $(".sidebar-menu > li:nth-child(4) > ul > li:nth-child(1) > a").addClass("on");
</script>
</html>
