<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 3;
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

    function academyList() { //학원정보리스트 가져오기
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
</script>
<body onload="academyList();academyGroupSelectbox('academy_group', '');">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/academy_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <h3 class="title_t1">학원정보입력</h3>
    <form name="frm" method="get">
        <input type="hidden" name="office_id" id="office_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden"  id="sPage" value="<%=sPage%>">
        <div class="tb_t1">
            <table>
                <colgroup>
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                </colgroup>
                <thead>
                <tr>
                    <th>그룹 / 관</th>
                    <th>원장명</th>
                    <th>주소</th>
                    <th>관전화번호</th>
                    <th>팩스번호</th>
                    <th>생성일</th>
                    <th>수정</th>
                </tr>
                <tbody id="dataList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
            <%@ include file="/common/inc/com_pageNavi.inc" %>
        </div>
    </form>
</section>
</body>
</html>
