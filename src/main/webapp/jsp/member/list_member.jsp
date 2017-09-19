<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 4;
    int depth2 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type="text/javascript">
function init() {
    memberTypeSelectbox("l_memberType", "");//직원타입
    jobPositionSelectbox("l_jobPosition","");//직책리스트
    academyListSelectbox("sel_academy","");//학원리스트
    flowEduTeamListSelectbox("l_FlowEduTeam","");//소속팀리스트
    fn_search("new");
}

function fn_search(val) {//운영자,선생님 리스트불러오기
    var paging = new Paging();
    var sPage = $("#sPage").val();

    if(val == "new") sPage = "1";
    dwr.util.removeAllRows("dataList");

    memberService.getFlowEduMemberListCount( function(cnt) {
        paging.count(sPage, cnt, '10', '10', comment.blank_list);
        memberService.getFlowEduMemberList(sPage, '10', function (selList) {
            if (selList.length > 0) {
                console.log(selList);
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var modifyHTML = "<button class='btn_pack white' type='button' id='modify' onclick='member_modify(" + cmpList.flowMemberId + ");'/>수정</button>";
                        var cellData = [
                         //   function(data) {return checkHTML;},
                            function(data) {return convert_memberType(cmpList.memberType);},
                            function(data) {return cmpList.memberName;},
                            function(data) {return cmpList.phoneNumber;},
                            function(data) {return cmpList.memberBirthday;},
                            function(data) {return ellipsis(cmpList.memberAddress, 5);},
                            function(data) {return cmpList.memberEmail;},
                            function(data) {return cmpList.jobPositionName;},
                            function(data) {return cmpList.officeName;},
                            function(data) {return cmpList.teamName;},
                            function(data) {return cmpList.sexualAssultConfirmDate;},
                            function(data) {return cmpList.educationRegDate;},
                            function(data) {return modifyHTML;}
                        ];
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                    }
                }
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
    <%@include file="/common/jsp/member_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <h3 class="title_t1">운영자/선생님리스트</h3>
    <form name="frm" id="frm" method="get">
    <input type="hidden" name="member_id" id="member_id">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    <div class="tb_t1">
        <table>
            <colgroup>
               <!-- <col width="2%" />-->
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="110" />
            </colgroup>
            <thead>
            <tr>
                <th>직원선택</th>
                <th>직원명</th>
                <th>직원핸드폰번호</th>
                <th>생년월일</th>
                <th>주소</th>
                <th>이메일</th>
                <th>직책</th>
                <th>소속부서</th>
                <th>소속팀</th>
                <th>성범죄경력조회 확인일자</th>
                <th>교육청 강사등록일자</th>
                <th>수정</th>
            </tr>
            </thead>
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