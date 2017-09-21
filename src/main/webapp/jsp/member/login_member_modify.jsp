<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 0;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/loginService.js'></script>
<script type='text/javascript'>
    var memberPhoneNumber = '<%=phoneNumber%>';
    function memberPassCheck() {
        var memberPassword = getInputTextValue("memberPass");
        memberService.isMemberByPassword(memberPhoneNumber, memberPassword, function (bl) {
            var passMent = "";
            var checekColor = "";
            if (bl == false) {
                passMent = "비밀번호가 틀렸습니다.";
                checekColor = "red";
            } else {
                passMent = "비밀번호가 일치합니다.";
                checekColor = "green";
            }
            innerHTML("l_passAert", passMent);
            innerHTMLAddColor("l_passAert", checekColor);
        });
    }

    function modify_password() {
        var memberPass = getInputTextValue("memberPass");
        var reNewPassword = getInputTextValue("reNewPass");

        memberService.modifyFlowMemberPassword(memberPhoneNumber, memberPass, reNewPassword, function (result) {
            if (result == 0) {
                alert("비밀번호가 변경되었습니다.");
                goPage("dashboard", "dashboard_list");
            } else {
                alert(comment.error);
            }
        });
    }

    $(function () {
        $("#reNewPass").keyup(function () {
            if ($("#newPass").val() == $("#reNewPass").val()) {
                innerHTML("l_newPassAert", "비밀번호가 일치합니다.");
                innerHTMLAddColor("l_newPassAert", "green");
            } else {
                innerHTML("l_newPassAert", "비밀번호가 일치하지 않습니다.");
                innerHTMLAddColor("l_newPassAert", "red");
            }
        });
    });
</script>
<body>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/student_depth_menu.jsp" %>--%>
</div>
</section>
<section class="content">
    <h3 class="title_t1">비밀번호 변경</h3>
    <form name="frm" method="get" class="form_st1">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="isPass">
        <div class="form-group row" >
            <label>아이디</label>
            <div ><span id="l_memberId"><%=phoneNumber%></span></div>
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
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>