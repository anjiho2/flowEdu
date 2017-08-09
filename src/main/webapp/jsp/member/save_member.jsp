<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type="text/javascript">
function init() {
    memberTypeSelectbox("l_memberType", "");
    jobPositionSelectbox("l_jobPosition","");
    academyListSelectbox("sel_academy","");
    flowEduTeamListSelectbox("l_FlowEduTeam","");

    fn_search("new");
}
function fn_search(val) {
    var paging = new Paging();
    var sPage = $("#sPage").val();
    var title = $("#search_value").val();

    if(val == "new") {
       sPage = "1";
    }
    dwr.util.removeAllRows("dataList");

    memberService.getFlowEduMemberListCount( function(cnt) {
        paging.count(sPage, cnt, '10', '5', comment.blank_list);

        memberService.getFlowEduMemberList(sPage, '5', function (selList) {

            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {

                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var checkHTML = "<input type='checkbox' name='chk' id='chk' value='" + cmpList.officeId + "'/>";
                        var modifyHTML = "<input type='button'  name='modify' id='modify' value='수정' onclick='member_modify(" + cmpList.flowMemberId + ");'/>";
                        var cellData = [
                            function(data) {return checkHTML;},
                            function(data) {return cmpList.memberType=="OPERATOR"?"운영자":"선생님";},
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
function save_academy() { // 운영자.선생님정보등록
    var check = new isCheck();

    if(check.input("member_name", comment.input_member_name)       == false) return;
    if(check.input("member_phone1", comment.input_member_phone1)   == false) return;
    if(check.input("member_phone2", comment.input_member_phone2)   == false) return;
    if(check.input("member_phone3", comment.input_member_phone3)   == false) return;
    if(check.input("startDate", comment.input_member_startDate)    == false) return;
    if(check.input("member_address", comment.input_member_address) == false) return;
    if(check.input("member_email", comment.input_member_email)     == false) return;
    if(check.input("startSearchDate", comment.input_member_startSearchDate)   == false) return;
    if(check.input("startSearchDate2", comment.input_member_startSearchDate2) == false) return;

    var member_name          = getInputTextValue("member_name");
    var member_phone1        = getInputTextValue("member_phone1");
    var member_phone2        = getInputTextValue("member_phone2");
    var member_phone3        = getInputTextValue("member_phone3");
    var member_allphone      = member_phone1+member_phone2+member_phone3;
    var startDate            = getInputTextValue("startDate");
    var member_address       = getInputTextValue("member_address");
    var member_email         = getInputTextValue("member_email");
    var startSearchDate      = getInputTextValue("startSearchDate");
    var startSearchDate2     = getInputTextValue("startSearchDate2");

    var sel_academy          = getSelectboxValue("sel_academyList");
    var l_FlowEduTeam        = getSelectboxValue("l_FlowEduTeam");
    var sel_jobPosition      = getSelectboxValue("sel_jobPosition");
    var sel_memberType       = getSelectboxValue("sel_memberType");
    var memtype = $("#sel_memberType option:selected").text();
    var isEmail = fn_isemail(member_email);
    if (isEmail == true) {
        return false;
    }

    memberService.isMember(member_allphone, function (bl) {
        if(bl==true){
            alert("이미 가입된 전화번호가 있습니다.");
            return false;
        }else{
            memberService.saveFlowEduMember(sel_academy,l_FlowEduTeam,sel_jobPosition,member_allphone,member_phone3,member_name,
                startDate,member_address,member_email,startSearchDate,startSearchDate2,sel_memberType,function () {
                    alert(memtype + " 정보가 등록 되었습니다.");
                    location.reload();
            });
        }
    });
}
function member_modify(member_id) { //수정페이지 이동
    innerValue("member_id", member_id);
    goPage('member', 'modify_member');
}

function Delete() { //운영자|선생님정보 삭제
    $("input[name=chk]:checked").each(function() {
        var officeid = $(this).val();

        if (officeid == "") {
            alert(comment.blank_check);
            return;
        }
        academyService.deleteAcademy(officeid, function() {});
    });
    alert(comment.success_delete);
    location.reload();
}
</script>
<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="member_id" id="member_id">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    <h1>운영자/선생님정보입력page</h1>
    <table>
        <tr>
            <th>직원타입</th>
            <td>
                <span id="l_memberType"></span>
            </td>
        </tr>
        <tr>
            <th>직원명</th>
            <td>
                <input type="text" id="member_name">
            </td>
        </tr>
        <tr>
            <th>핸드폰번호</th>
            <td>
                <input type="text" size="2" id="member_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.member_phone2,3)">
                -
                <input type="text" size="5" id="member_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.member_phone3,4)">
                -
                <input type="text" size="5" id="member_phone3" maxlength="4">
            </td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td>
                <input type="text" id="startDate" >
            </td>
        </tr>

        <tr>
            <th>주소</th>
            <td>
                <input type="text" id="member_address">
            </td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>
                <input type="text" id="member_email">
            </td>
        </tr>
        <tr>
            <th>직책</th>
            <td>
                <span id="l_jobPosition"></span>
            </td>
        </tr>
        <tr>
            <th>소속부서(학원)</th>
            <td>
                <span id="sel_academy"></span>
            </td>
        </tr>
        <tr>
            <th>소속팀</th>
            <td>
                <span id="l_FlowEduTeam"></span>
            </td>
        </tr>
        <tr>
            <th>성범죄경력조회 확인일자</th>
            <td>
                <input type="text" id="startSearchDate" >
            </td>
        </tr>
        <tr>
            <th>교육청 강사등록일자</th>
            <td>
                <input type="text" id="startSearchDate2" >
            </td>
        </tr>
        <tr>
            <th>수정</th>
            <td>

            </td>
        </tr>
    </table>
    <input type="button" value="등록" onclick="save_academy();">


<h1>운영자/선생님정보 LIST</h1>
<div id="memberList">
    <table class="table_list" border="1">
        <colgroup>
            <col width="2%" />
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
            <col width="*" />
        </colgroup>
        <thead>
        <tr>
            <th>
                <input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');">
            </th>
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
        <input type="button" value="삭제" onclick="Delete();">
    </table>
    <%@ include file="/common/inc/com_pageNavi.inc" %>
</div>
</form>
</body>
</html>
