<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type="text/javascript" src="http://jsgetip.appspot.com"></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/loginService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
    var check = new isCheck();

    function loginCheck() {
        var memberId = getInputTextValue("loginMemberId");
        var pass = getInputTextValue("memberPass");
        var connectIp = ip();

        if (check.input("loginMemberId", comment.insert_id) == false) return;
        if (check.input("memberPass", comment.insert_password) == false) return;

        loginService.isMember(memberId, pass, connectIp, function(data) {
            if (data.flowMemberId != null ) {
                loginOk(data);
            } else {
                alert(comment.blank_login_check);
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
            innerValue("academy_thumbnail", val.academyThumbnail);

            page_gbn.value = "session";
            action = "<%=webRoot%>/login.do";
            submit();
        }
    }

    function find_password() {
        var check = new isCheck();

        if(check.input("memberId", comment.insert_id)       == false) return;
        if(check.input("member_email", comment.input_member_email)       == false) return;

        var memberId = getInputTextValue("memberId");
        var email = getInputTextValue("member_email");
        fn_isemail(email);

        memberService.findFlowEduMemberPassword(memberId, email, function (temporaryPassword) {
            if (temporaryPassword != null) {
                alert("임시비밀번호가 발급되었습니다.\n로그인후 변경해주세요.");
                innerHTML("l_temporaryPassword", temporaryPassword);
                gfn_display("temporaryPassword_div", true);
            }
        });
    }

    function find_id() { //아이디찾기 처리
        var check = new isCheck();
        if(check.input("id_find_name", comment.search_input_id_name)   == false) return;
        if(check.input("id_find_email", comment.input_member_email)    == false) return;

        var id_find_name = getInputTextValue("id_find_name");
        var id_find_email = getInputTextValue("id_find_email");

        memberService.findFlowEduMemberId(id_find_name, id_find_email, function (bl) {
            if (bl == true) $("#EmailOk").show();
            else alert(comment.blank_send_email);
        });
    }

    $(function () {
        $("#Idfind").on('click', function () { //아이디찾기 팝업
            initPopup($("#IdFindLayer"), {
                onStart: function (t) {
                },
            });
        });
        $("#Pwfind").on('click', function () { //비밀번호찾기 팝업
            initPopup($("#PwFindLayer"), {
                onStart: function (t) {
                },
            });
        });
    });
</script>
<style>
    body{
        background: #e9eef1; display: flex;justify-content: center; align-items: center;
    }
</style>
<body>
<%
    if (session.getAttribute("member_info") == null) {
%>
    <div class="modal_layout">
        <h2 id="logo-container">플로우교육</h2>
        <div class="cont">
            <form name="frm" method="post">
                <input type="hidden" id="flow_member_id" name="flow_member_id" />
                <input type="hidden" id="office_id" name="office_id" />
                <input type="hidden" id="team_id" name="team_id" />
                <input type="hidden" id="phone_number" name="phone_number" />
                <input type="hidden" id="member_name" name="member_name" />
                <input type="hidden" id="member_type" name="member_type" />
                <input type="hidden" id="academy_thumbnail" name="academy_thumbnail" />
                <input type="hidden" name="page_gbn" id="page_gbn">
               <!-- <div class="form-group input-group">
                    <%--<span id="l_memberType" ></span>--%>
                    <select id="sel_memberType" class="form-control big">
                        <option>▶선택</option>
                    </select>
                </div>-->
                <div class="form-group input-group">
                    <input class="form-control big" type="text" id="loginMemberId" placeholder="아이디"/>
                </div>
                <div class="form-group input-group">
                    <input class="form-control big" type="password"  id="memberPass" name="memberPass" onkeypress="javascript:if(event.keyCode == 13){loginCheck(); return false;}" placeholder="비밀번호"/>
                </div>
                <div class="btns">
                    <button type="button" class="btn_pack blue s2" onclick="loginCheck();" style="margin-left: 0px;">로그인</button>
                </div>
                <%--<p>비밀번호를 찾으시려면 <a href="javascript:;"  onclick="password_search_popup();">여기</a>를 클릭해주세요.</p>--%>
                <div class="space_between" style="margin-top:5px;">
                    <button type="button" class="btn_pack black s3" id="Idfind">아이디 찾기</button>
                    <button type="button" class="btn_pack black s3" id="Pwfind">비밀번호 찾기</button>
                </div>
            </form>
        </div>
    </div>
    <!-- 비밀번호 찾기 레이어 시작 -->
<%--<div class="layer_popup_template apt_request_layer" id="test_layer" style="display: none;">--%>
<%--<div class="layer-title">--%>
<%--<h3>비밀번호 찾기</h3>--%>
<%--<button class="fa fa-close btn-close"></button>--%>
<%--</div>--%>
<%--<div class="layer-body">--%>
<%--<form name="pop_frm" class="form_st1">--%>
<%--<div class="cont">--%>
<%--<div class="form-group row">--%>
<%--<div class="inputs">--%>
<%--<input type="text" size="2" id="student_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this, pop_frm.student_phone2, 3)" placeholder="핸드폰 번호">&nbsp;-&nbsp;--%>
<%--<input type="text" size="5" id="student_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this, pop_frm.student_phone3, 4)">&nbsp;-&nbsp;--%>
<%--<input type="text" size="5" id="student_phone3" class="form-control" maxlength="4">--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="form-group"><div><input type="email" class="form-control" id="member_email" placeholder="이메일"></div></div>--%>
<%--<div class="form-group row" id="temporaryPassword_div" style="display: none;">--%>
<%--<label>임시비밀번호</label>--%>
<%--<span id="l_temporaryPassword"></span>--%>
<%--</div>--%>
<%--</div>--%>
<%--</form>--%>
<%--<div class="bot_btns_t1">--%>
<%--<button class="btn_pack btn-close">취소</button>--%>
<%--<button class="btn_pack blue" type="button" onclick="find_password();">찾기</button>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<!-- 비밀번호 찾기 레이어 끝 -->

<!--아이디 찾기 레이어 시작-->
    <div class="layer_popup_template apt_request_layer loginpopup" id="IdFindLayer" style="display: none;">
        <div class="layer-title">
            <h3>아이디 찾기</h3>
            <button id="close_btn_id" type="button" class="fa fa-close btn-close"></button>
        </div>
        <div class="layer-body">
            <div class="cont" style="margin:20px 0 15px 20px;">
                <div class="form-group row">
                    <label>이름</label>
                    <div><input type="text"  class="form-control login_findbox" id="id_find_name"></div>
                </div>
                <div class="form-group row">
                    <label>이메일</label>
                    <div><input type="text"  class="form-control login_findbox" id="id_find_email"></div>
                </div>
                <div id="EmailOk"  style="display: none;">
                    <p>입력하신 이메일 주소로 아이디를 전송하였습니다.</p>
                </div>
            </div>
            <div class="bot_btns_t1">
                <button class="btn_pack btn-close" type="button">취소</button>
                <button class="btn_pack blue" type="button" onclick="find_id();">찾기</button>
            </div>
        </div>
    </div>
    <!--아이디 찾기 레이어 끝-->

    <!--비밀번호 찾기 레이어 시작-->
    <div class="layer_popup_template apt_request_layer loginpopup" id="PwFindLayer" style="display: none;">
        <div class="layer-title">
            <h3>비밀번호 찾기</h3>
            <button id="close_btn_pw" type="button" class="fa fa-close btn-close"></button>
        </div>
        <div class="layer-body">
            <div class="cont" style="margin:20px 0 15px 20px;">
                <div class="form-group row">
                    <label>아이디</label>
                    <div><input type="text" class="form-control login_findbox" id="memberId"></div>
                </div>
                <div class="form-group row">
                    <label>이메일</label>
                    <div><input type="text" class="form-control login_findbox" id="member_email"></div>
                </div>
                <div class="form-group row" id='temporaryPassword_div' style="display: none;">
                    <label>임시 비밀번호</label>
                    <div><p><span id="l_temporaryPassword"></span></p></div>
                </div>
            </div>
            <div class="bot_btns_t1">
                <button class="btn_pack btn-close" type="button">취소</button>
                <button class="btn_pack blue" type="button" onclick="find_password();">찾기</button>
            </div>
        </div>
    </div>
    <!--비밀번호 찾기 레이어 끝-->

<%--<iframe width="420" height="315"--%>
        <%--src="https://www.youtube.com/embed/Gj5DQ8NZheY">--%>
<%--</iframe>--%>
<%
    } else {
        System.out.print("========================================");
%>

    <script>
        goPage("dashboard", "dashboard_list");
    </script>
<%
    }
%>
</body>
</html>

