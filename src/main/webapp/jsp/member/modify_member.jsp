<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long member_id = Long.parseLong(request.getParameter("member_id"));

%>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script>
    function save_academy() { // 운영자.선생님정보등록
        var check = new isCheck();
        var member_id        = getInputTextValue("member_id");
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

        var sel_memberType       = getSelectboxValue("sel_memberType");
        var sel_academy          = getSelectboxValue("sel_academyList");
        var sel_FlowEduTeamList  = getSelectboxValue("sel_FlowEduTeamList");
        var sel_jobPosition      = getSelectboxValue("sel_jobPosition");
        var sel_memberType       = getSelectboxValue("sel_memberType");
        var memtype = $("#sel_memberType option:selected").text();
        var isEmail = fn_isemail(member_email);
        if (isEmail == true) {
            return false;
        }

        memberService.modifyFlowEduMember(member_id, sel_academy, sel_FlowEduTeamList, sel_jobPosition, member_allphone, member_phone3,member_name,
            startDate, member_address,member_email, startSearchDate, startSearchDate2, sel_memberType,function () {
                alert(memtype + " 정보가 수정 되었습니다.");
                        location.reload();
        });

    }
    function init() {
        memberTypeSelectbox("l_memberType", "");
        jobPositionSelectbox("l_jobPosition","");
        academyListSelectbox("sel_academy","");
        flowEduTeamListSelectbox("l_FlowEduTeam","");
    }

    function memberList() {
        var member_id        = getInputTextValue("member_id");
        memberService.getFlowEduMember(member_id, function (selList) {
            console.log(selList);
            if (selList.length > 0) {
                for (var i=0; i<selList.length; i++) {
                    var cmpList = selList[i];
                    innerValue("member_name", cmpList.memberName);
                    fnSetPhoneNo(member_phone1, member_phone2, member_phone3, cmpList.phoneNumber);
                    innerValue("startDate", cmpList.memberBirthday);
                    innerValue("member_address", cmpList.memberAddress);
                    innerValue("member_email", cmpList.memberEmail);
                    memberTypeSelectbox("l_memberType", cmpList.memberType);
                    jobPositionSelectbox("l_jobPosition",cmpList.jobPositionId);
                    academyListSelectbox("sel_academy", cmpList.officeId);
                    flowEduTeamListSelectbox("l_FlowEduTeam",cmpList.teamId);
                    innerValue("startSearchDate", cmpList.sexualAssultConfirmDate);
                    innerValue("startSearchDate2", cmpList.educationRegDate);
                }
            }
        });
    }
</script>
<body onload="init();  memberList();">
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="member_id" id="member_id" value="<%=member_id%>">
        <h1>운영자/선생님정보 수정page</h1>
        <table>
            <tr>
                <th>직원선택</th>
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
                    <input type="text" size="2" id="member_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.member_phone2,3)"  disabled>
                    -
                    <input type="text" size="5" id="member_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.member_phone3,4)" disabled>
                    -
                    <input type="text" size="5" id="member_phone3" maxlength="4" disabled>
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
        </table>
        <tbody id="dataList"></tbody>
        <input type="button" value="수정" onclick="save_academy();">
    </form>
</body>