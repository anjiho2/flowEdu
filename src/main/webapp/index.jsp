<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/loginService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">

    var check = new isCheck();

    function init() {
        memberTypeSelectbox("l_memberType", "");
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
        gfn_winPop(550,400,"jsp/popup/find_password_popup.jsp", "");
    }

</script>
<style>
    body{
        background: #b7b7b7;
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00589F', endColorstr='#0073CF', GradientType=0);
        background: -webkit-linear-gradient(to bottom, #b7b7b7 50%, #b7b7b7) !important;
        background: -moz-linear-gradient(to bottom, #b7b7b7 50%, #b7b7b7) !important;
        background: -ms-linear-gradient(to bottom, #b7b7b7 50%, #b7b7b7) !important;
        background: -o-linear-gradient(to bottom, #b7b7b7 50%, #b7b7b7) !important;
        background: linear-gradient(to bottom, #b7b7b7 50%, #b7b7b7) !important;
        color: white;
    }

    div.well{
        height: 250px;
    }

    .Absolute-Center {
        margin: auto;
        position: absolute;
        top: 0; left: 0; bottom: 0; right: 0;
    }

    .Absolute-Center.is-Responsive {
        width: 50%;
        height: 50%;
        min-width: 200px;
        max-width: 400px;
        padding: 40px;
    }

    #logo-container{
        margin: auto;
        margin-bottom: 10px;
        width:200px;
        height:30px;
    }
</style>
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
<!--
        <div >
            <span id="l_memberType"></span>
            <input type="text" id="phoneNumber">
            <input type="password" id="memberPass" name="memberPass" onkeypress="javascript:if(event.keyCode == 13){loginCheck(); return false;}">
            <input type="button" id="loginBtn" value="로그인" onclick="loginCheck();">
        </div>-->
    <div class="container">
        <div class="row">
            <div class="Absolute-Center is-Responsive">
              <div id="logo-container" align="center">플로우교육 관리자</div>
                <div class="col-sm-12 col-md-10 col-md-offset-1" align="center">
                    <form action="" id="loginForm">
                        <div class="form-group input-group" style="width: 50%;">
                            <span id="l_memberType" ></span>
                        </div>
                        <div class="form-group input-group"  style="width: 50%;">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input class="form-control" type="text" id="phoneNumber" placeholder="아이디"/>
                        </div>
                        <div class="form-group input-group"  style="width: 50%;">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <input class="form-control" type="password"  id="memberPass" name="memberPass" onkeypress="javascript:if(event.keyCode == 13){loginCheck(); return false;}" placeholder="비밀번호"/>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn_pack blue s2" onclick="loginCheck();">로그인</button>
                            <button type="button" class="btn_pack blue s2" onclick="password_search_popup();">비밀번호 찾기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<%
    } else {
%>
    <input type="button" id="logoutBtn" value="로그아웃" class="btn_pack blue s2"  onclick="goLogout();">
<%
    }
%>
</form>
</body>
</html>
