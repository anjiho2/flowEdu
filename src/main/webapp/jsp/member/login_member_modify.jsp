<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 0;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/loginService.js'></script>
<script type='text/javascript'>
    var memberPhoneNumber = '<%=phoneNumber%>';
    //기존 비밀번호 체크
    function memberPassCheck() {
        var memberPassword = getInputTextValue("memberPass");

        memberService.isMemberByPassword(memberPhoneNumber, memberPassword, function (bl) {
            var passMent = "";
            var checekColor = "";
            if (bl == false) {
                passMent = "비밀번호가 틀렸습니다.";
                checekColor = "red";
                //innerValue("isPass", false);
                focusInputText("memberPass");
            } else {
                passMent = "비밀번호가 일치합니다.";
                checekColor = "green";
                innerValue("isPass", true);
            }
            innerHTML("l_passAert", passMent);
            innerHTMLAddColor("l_passAert", checekColor);
        });
    }
    //새로운 비밀번호 일치여부 체크
    $(function () {
        $("#reNewPass").keyup(function () {
            if ($("#newPass").val() == $("#reNewPass").val()) {
                innerHTML("l_newPassAert", "새로운 비밀번호가 일치합니다.");
                innerHTMLAddColor("l_newPassAert", "green");
                innerValue("isNewPass", true);
            } else {
                innerHTML("l_newPassAert", "새로운 비밀번호가 일치하지 않습니다.");
                innerHTMLAddColor("l_newPassAert", "red");
                innerValue("isNewPass", false);
            }
        });
    });
    //비밀번호 변경
    function modify_password() {
        var isPass = getInputTextValue("isPass");
        var isNewPass = getInputTextValue("isNewPass");
        var memberPass = getInputTextValue("memberPass");
        var reNewPassword = getInputTextValue("reNewPass");

        if (!isNewPass) {
            alert("새로운 비밀번호가 일치하지 않습니다.");
            focusInputText("reNewPass");
            return;
        }
        if (fn_pwdcheck($("#newPass").val())) return;
        if (confirm(comment.isChange)) {
            memberService.modifyFlowMemberPassword(memberPhoneNumber, memberPass, reNewPassword, function (result) {
                if (result == 0) {
                    alert("비밀번호가 변경되었습니다.");
                    goPage("dashboard", "dashboard_list");
                } else if (result == 1) {
                    alert("기존 비밀번호가 틀렸습니다.");
                    return;
                }
            });
        }
    }
</script>
<body>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/student_depth_menu.jsp" %>--%>
</div>
</section>
<section class="content divide">
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="isPass">
        <input type="hidden" id="isNewPass">
    </form>
    <div class="left">
        <div class="tile_box">
            <h3 class="title_t1">비밀번호 변경</h3>
            <ul class="list_t1">
                <li>
                    <strong>아이디</strong>
                    <div><p><span id="l_memberId"><%=phoneNumber%></span></p></div>
                </li>
                <li>
                    <strong>기존 비밀번호</strong>
                    <div>
                        <div>
                            <input type="password" id="memberPass" class="form-control-sm" onblur="memberPassCheck();">
                            <em id="l_passAert"></em>
                        </div>
                    </div>
                </li>
                <li>
                    <strong>새로운 비밀번호</strong>
                    <div>
                        <input type="password" id="newPass" class="form-control-sm">
                    </div>
                </li>
                <li>
                    <strong>새로운 비밀번호 확인</strong>
                    <div>
                        <div>
                            <input type="password" id="reNewPass" class="form-control-sm" onkeypress="javascript:if(event.keyCode == 13){modify_password(); return false;}">
                            <em id="l_newPassAert"></em>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="form-group row"></div>
        <div class="bot_btns">
            <button class="btn_pack blue s2" type="button"  onclick="modify_password();">변경</button>
        </div>
    </div>
</section>

<!--
<section class="content">
    <h3 class="title_t1">비밀번호 변경</h3>
    <form name="frm" method="get" class="form_st1">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="isPass">
        <input type="hidden" id="isNewPass">
        <div class="form-group row" >
            <label>아이디</label>
            <div><span id="l_memberId"><%=phoneNumber%></span></div>
        </div>
        <div class="form-group row" style="width: 80%">
            <label>기존 비밀번호</label>
            <div style="width: 50%"><input type="password" id="memberPass" class="form-control" onblur="memberPassCheck();"></div>
            &nbsp;&nbsp;<div style="width: 20%"><span id="l_passAert"></span></div>
        </div>
        <div class="form-group row" style="width: 80%">
            <label>새로운 비밀번호</label>
            <div style="width: 50%"><input type="password" id="newPass" class="form-control"></div>
            <div style="width: 20%"></div>
        </div>
        <div class="form-group row" style="width: 80%">
            <label>새로운 비밀번호 확인</label>
            <div style="width: 50%"><input type="password" id="reNewPass" class="form-control" onkeypress="javascript:if(event.keyCode == 13){modify_password(); return false;}"></div>
            &nbsp;&nbsp;<div style="width: 20%"><span id="l_newPassAert"></span></div>
        </div>
        <div class="bot_btns">
            <button class="btn_pack blue s2" type="button"  onclick="modify_password();">변경</button>
        </div>
    </form>
</section>
-->
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>