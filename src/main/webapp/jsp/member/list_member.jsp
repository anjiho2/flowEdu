<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int siderMenuDepth1 = 5;
    int siderMenuDepth2 = 6;
    int siderMenuDepth3 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/academyService.js'></script>
<script type="text/javascript">
function init() {
    memberTypeSelectbox("sel_memberType", "");  //유형
    jobPositionSelectbox("sel_jobPosition", "");    //직책
    searchAcademySelectbox("sel_academy",""); //소속
    teamListSelectbox("sel_teamList", "");  //소속팀
    gfn_emptyView("V", comment.search_member);
}


function fn_search(val) {//운영자,선생님 리스트불러오기
    dwr.util.removeAllRows("dataList");
    var paging = new Paging();
    var sPage = $("#sPage").val();

    if(val == "new") sPage = "1";

    var sel_memberType  =  getSelectboxValue("sel_memberType");//유형
    var sel_jobPosition = getSelectboxValue("sel_jobPosition");//직책
    var sel_academy     = getSelectboxValue("sel_academy");//소속
    var sel_teamList    =  getSelectboxValue("sel_teamList");//소속팀
    var sel_registe     = getSelectboxValue("sel_registe");//등록정보
    var registe_info    =  getInputTextValue("registe_info");

    dwr.util.removeAllRows("dataList");
    gfn_emptyView("H", "");
    memberService.getFlowEduMemberListCount(sel_memberType, sel_jobPosition, sel_academy, sel_teamList, registe_info, sel_registe, function(cnt) {
        paging.count(sPage, cnt, '10', '10', comment.blank_list);
            memberService.getFlowEduMemberList(sPage, '10', sel_memberType, sel_jobPosition, sel_academy, sel_teamList, registe_info, sel_registe, function (selList) {
                if (selList.length > 0) {
                    console.log(selList);
                    for (var i = 0; i < selList.length; i++) {
                          var cmpList = selList[i];
                          var serveYn;
                          if(cmpList.serveYn == true) serveYn = '재직';
                          else serveYn = '퇴직';
                if (cmpList != undefined) {
                    var nameHTML = "<a href='javascript:void(0);' onclick='member_modify("+ cmpList.flowMemberId +")' style='color:blue;'>" + cmpList.memberName + "</a>"
                    var cellData = [
                        function(data) {return i+1;},
                        function(data) {return convert_memberType(cmpList.memberType);},
                        function(data) {return cmpList.jobPositionName;},
                        function(data) {return nameHTML;},
                        function(data) {return cmpList.officeName;},
                        function(data) {return cmpList.teamName == "" ? "-" : cmpList.teamName},
                        function(data) {return cmpList.phoneNumber;},
                        function(data) {return serveYn;},
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

function member_modify(member_id) { //수정페이지 이동
    innerValue("member_id", member_id);
    goPage('member', 'modify_member');
}
</script>

<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/member_top_menu.jsp" %>--%>
    <div class="title-top">운영관리</div>
</div>
</section>
<section class="content">
    <h3 class="title_t1">운영자관리</h3>
    <form name="frm" method="get">
        <input type="hidden" name="member_id" id="member_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="sPage" value="<%=sPage%>">
    </form>
        <div class="tb_t1">
            <table>
                <tr>
                    <th>유형</th>
                    <td>
                        <select id="sel_memberType" class="form-control">
                            <option value="">전체</option>
                        </select>
                    </td>
                    <th>직책</th>
                    <td>
                        <select id="sel_jobPosition" class="form-control">
                            <option value="">전체</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>소속</th>
                    <td>
                        <select id="sel_academy" class="form-control">
                            <option value="">전체</option>
                        </select>
                    </td>
                    <th>소속팀</th>
                    <td>
                        <select id="sel_teamList" class="form-control">
                            <option value="">전체</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>등록정보</th>
                    <td colspan="3">
                        <div class="form-group row marginX">
                            <select class="form-control select-space" id="sel_registe">
                                <option value="name">이름</option>
                                <option value="phone">핸드폰번호</option>
                            </select>
                            <input type="text" class="form-control" id="registe_info">
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
                        <th>유형</th>
                        <th>직책</th>
                        <th>이름</th>
                        <th>소속</th>
                        <th>소속팀</th>
                        <th>핸드폰번호</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody id="dataList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
            <button class="btn_pack blue s2" onclick="javascript:goPage('member', 'save_member')">등록</button>
        </div>
    <%@ include file="/common/inc/com_pageNavi.inc" %>
</section>
<%@include file="/common/jsp/footer.jsp" %>
</body>
</html>
