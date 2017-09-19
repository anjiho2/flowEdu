<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<%
    int depth2 = 2;
    Long member_id = Long.parseLong(request.getParameter("member_id"));
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script>
    function init() {
        memberTypeSelectbox("l_memberType", "");
        jobPositionSelectbox("l_jobPosition","");
        academyListSelectbox("sel_academy","");
        flowEduTeamListSelectbox("l_FlowEduTeam","");
        memberList();
    }

    function memberList() {//운영자.선생님정보 가져오기
        var memberId        = getInputTextValue("member_id");
        memberService.getFlowEduMember(memberId, function (selList) {
            if (selList.length > 0) {
                for (var i=0; i<selList.length; i++) {
                    var cmpList = selList[i];
                    memberTypeSelectbox("l_memberType", cmpList.flowMemberId);
                    jobPositionSelectbox("l_jobPosition", cmpList.jobPositionId);
                    academyListSelectbox("sel_academy", cmpList.officeId);
                    flowEduTeamListSelectbox("l_FlowEduTeam", cmpList.teamId);
                    innerValue("member_name", cmpList.memberName);//직원명
                    innerValue("startDate", cmpList.memberBirthday);//생년월일
                    innerValue("member_address", cmpList.memberAddress);//주소
                    innerValue("member_email", cmpList.memberEmail);//이메일
                    innerValue("startSearchDate", cmpList.sexualAssultConfirmDate);//성범죄경력조회
                    innerValue("startSearchDate2", cmpList.educationRegDate);//교육청
                    fnSetPhoneNo(member_phone1, member_phone2, member_phone3, cmpList.phoneNumber);//핸드폰번호
                }
            }
        });
    }

    function modify_member() {// 운영자.선생님정보수정
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
        var isEmail = fn_isemail(member_email); //이메일유효성체크
        if (isEmail == true) return false;

        memberService.modifyFlowEduMember(member_id, sel_academy, sel_FlowEduTeamList, sel_jobPosition, member_allphone, member_phone3,member_name,
            startDate, member_address,member_email, startSearchDate, startSearchDate2, sel_memberType,function () {
                alert(memtype + " 정보가 수정 되었습니다.");
                location.reload();
        });
    }
</script>

<style><%--성범죄확인일자/교육청강사등록일자로인한 style예외처리--%>
.form-group.row>label {-webkit-box-flex: 0;-ms-flex: 0 0 140px;flex: 0 0 187px;}
</style>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/member_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <h3 class="title_t1">운영자/선생님정보 수정</h3>
    <form name="frm" id="frm" method="get" class="form_st1">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="member_id" id="member_id" value="<%=member_id%>">
        <div class="form-group row">
            <label>직원타입<b>*</b></label>
            <div><span id="l_memberType"></span></div>
        </div>
        <div class="form-group row">
            <label>직원명<b>*</b></label>
            <div><input type="text" class="form-control" id="member_name" style="width:150px;"></div>
        </div>
        <div class="form-group row">
            <label>생년월일<b>*</b></label>
            <div><input type="text" id="startDate" class="form-control date-picker" style="width:150px;"></div>
        </div>
        <div class="form-outer-group">
            <div class="form-group row">
                <label>핸드폰번호</label>
                <div class="inputs">
                    <input type="text" id="member_phone1" class="form-control" maxlength="3"  onkeyup="js_tab_order(this,frm.member_phone2,3)">&nbsp;-&nbsp;
                    <input type="text" id="member_phone2" class="form-control" maxlength="4"  onkeyup="js_tab_order(this,frm.member_phone3,4)">&nbsp;-&nbsp;
                    <input type="text" id="member_phone3" class="form-control" maxlength="4" >
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label>주소<b>*</b></label>
            <div><input type="text" class="form-control" id="member_address"></div>
        </div>
        <div class="form-group row">
            <label>이메일</label>
            <div><input type="email" class="form-control datepicker" id="member_email" style="width:422px;"></div>
        </div>
        <div class="form-group row">
            <label>직책<b>*</b></label>
            <div><span id="l_jobPosition"></span></div>
        </div>
        <div class="form-group row">
            <label>소속부서(학원)<b>*</b></label>
            <div><span id="sel_academy"></span></div>
        </div>
        <div class="form-group row">
            <label>소속팀<b>*</b></label>
            <div><span id="l_FlowEduTeam"></span></div>
        </div>
        <div class="form-group row">
            <label>성범죄경력조회 확인일자<b>*</b></label>
            <div><input type="text" id="startSearchDate" class="form-control date-picker" style="width:200px;"></div>
        </div>
        <div class="form-group row">
            <label>교육청 강사등록일자<b>*</b></label>
            <div><input type="text" id="startSearchDate2" class="form-control date-picker" style="width:200px;"></div>
        </div>
        <div class="bot_btns">
            <button class="btn_pack blue s2" type="button"  onclick="modify_member();">저장</button>
        </div>
    </form>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>