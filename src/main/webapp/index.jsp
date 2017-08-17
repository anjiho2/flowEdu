<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/loginService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>

<script type="text/javascript">

    var check = new isCheck();

    function init() {
        memberTypeSelectbox("l_memberType", "");
        //lectureLevelRadio("l_test", "HIGH", "loginCheck();");
        //lecturePriceSelectbox("l_test", "");
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

</script>
<body onload="init();">
<form name="frm" method="post">
<input type="hidden" id="flow_member_id" name="flow_member_id" />
<input type="hidden" id="office_id" name="office_id" />
<input type="hidden" id="team_id" name="team_id" />
<input type="hidden" id="phone_number" name="phone_number" />
<input type="hidden" id="member_name" name="member_name" />
<input type="hidden" id="member_type" name="member_type" />
<input type="hidden" name="page_gbn" id="page_gbn">
<%
    if (session.getAttribute("member_info") == null) {
%>
    <span id="l_memberType"></span>
    <input type="text" id="phoneNumber">
    <input type="password" id="memberPass" name="memberPass">
    <input type="button" id="loginBtn" value="로그인" onclick="loginCheck();">

<%
    } else {
%>
    <input type="button" id="logoutBtn" value="로그아웃" onclick="goLogout();">
<%
    }
%>
</form>
</body>
</html>
