<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/loginService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">

    var check = new isCheck();

    function init() {
        memberTypeSelectbox("l_memberType", "", "big");
    }

    function loginCheck() {
        var phoneNumber = getInputTextValue("phoneNumber");
        var pass = getInputTextValue("memberPass");
        var memberType = getSelectboxValue("sel_memberType");

        if (check.selectbox("sel_memberType", comment.select_member) == false) return;
        if (check.input("phoneNumber", comment.insert_id) == false) return;
        if (check.input("memberPass", comment.insert_password) == false) return;

        loginService.isMember(phoneNumber, pass, memberType, function(data) {
            console.log(data);
            if (data.phoneNumber != null ) {
                loginOk(data);
            } else {
                alert("아이디또는 비밀번호가 잘못됬습니다.");
                return;
            }
        });
    }

    function loginOk(val) {
        with(document.frm) {
            innerValue("flow_member_id", val.flowMemberId);
            innerValue("office_id", val.officeId);
            innerValue("team_id", val.teamId);
            innerValue("phone_number", val.phoneNumber);
            innerValue("member_name", val.memberName);
            innerValue("member_type", val.memberType);

            page_gbn.value = "session";
            action = "<%=webRoot%>/login.do";
            submit();
        }
    }
    //비밀번호 찾기 팝업
    function password_search_popup() {
        initPopup($("#test_layer"));
    }

    function find_password() {
        var check = new isCheck();
        var phoneNumber = getInputTextValue("student_phone1") + getInputTextValue("student_phone2") + getInputTextValue("student_phone3");
        var emial = getInputTextValue("member_email");
        if ( check.input("student_phone1", "전화번호롤 입력하세요.") == false
            || check.input("student_phone2", "전화번호롤 입력하세요.") == false
            || check.input("student_phone3", "전화번호롤 입력하세요.") == false) return;
        fn_isemail(emial);

        memberService.findFlowEduMemberPassword(phoneNumber, emial, function (temporaryPassword) {
            if (temporaryPassword != null) {
                alert("임시비밀번호가 발급되었습니다.\n로그인후 변경해주세요.");
                innerHTML("l_temporaryPassword", temporaryPassword);
                gfn_display("temporaryPassword_div", true);
            }
        });
    }
</script>
<style>
    body{
        background: #e9eef1; display: flex;justify-content: center; align-items: center;
    }
</style>
<body onload="init();">
<%
    if (session.getAttribute("member_info") == null) {
%>
    <div class="modal_layout">
        <h2 id="logo-container">플로우교육 관리자</h2>
        <div class="cont">
            <form name="frm" method="post">
                <input type="hidden" id="flow_member_id" name="flow_member_id" />
                <input type="hidden" id="office_id" name="office_id" />
                <input type="hidden" id="team_id" name="team_id" />
                <input type="hidden" id="phone_number" name="phone_number" />
                <input type="hidden" id="member_name" name="member_name" />
                <input type="hidden" id="member_type" name="member_type" />
                <input type="hidden" name="page_gbn" id="page_gbn">
                <div class="form-group input-group">
                    <span id="l_memberType" ></span>
                </div>
                <div class="form-group input-group">
                    <input class="form-control big" type="text" id="phoneNumber" placeholder="아이디"/>
                </div>
                <div class="form-group input-group">
                    <input class="form-control big" type="password"  id="memberPass" name="memberPass" onkeypress="javascript:if(event.keyCode == 13){loginCheck(); return false;}" placeholder="비밀번호"/>
                </div>
                <div class="btns">
                    <button type="button" class="btn_pack blue s2" onclick="loginCheck();">로그인</button>
                </div>
                <p>비밀번호를 찾으시려면 <a href="javascript:;"  onclick="password_search_popup();">여기</a>를 클릭해주세요.</p>
            </form>
        </div>
    </div>

<div class="layer_popup_template apt_request_layer" id="test_layer" style="display: none;">
    <div class="layer-title">
        <h3>비밀번호 찾기</h3>
        <button class="fa fa-close btn-close"></button>
    </div>
    <div class="layer-body">
        <form name="pop_frm" class="form_st1">
        <div class="cont">
            <div class="form-group row">
                <div class="inputs">
                    <input type="text" size="2" id="student_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this, pop_frm.student_phone2, 3)" placeholder="핸드폰 번호">&nbsp;-&nbsp;
                    <input type="text" size="5" id="student_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this, pop_frm.student_phone3, 4)">&nbsp;-&nbsp;
                    <input type="text" size="5" id="student_phone3" class="form-control" maxlength="4">
                </div>
            </div>
            <div class="form-group"><div><input type="email" class="form-control" id="member_email" placeholder="이메일"></div></div>
            <div class="form-group row" id="temporaryPassword_div" style="display: none;">
                <label>임시비밀번호</label>
                <span id="l_temporaryPassword"></span>
            </div>
        </div>
        </form>



        <div class="bot_btns_t1">
            <button class="btn_pack btn-close">취소</button>
            <button class="btn_pack blue" type="button" onclick="find_password();">찾기</button>
        </div>
    </div>
</div>
<%
    } else {
        System.out.print("========================================");
%>

    <script>
        goPage("dashboard", "dashboard_list");
    </script>
    <%--<input type="button" id="logoutBtn" value="로그아웃" class="btn_pack blue s2"  onclick="goLogout();">--%>
<%
    }
%>
</body>
</html>

