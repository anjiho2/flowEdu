<%@ page import="java.io.PrintWriter" %>
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
        gfn_winPop(550, 400, "jsp/popup/find_password_popup.jsp", "");
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
