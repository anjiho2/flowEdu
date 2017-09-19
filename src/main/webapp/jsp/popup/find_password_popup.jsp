<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript'>
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
<section class="content">
    <div align="center"><h2 class="title_t1">비밀번호 찾기</h2></div>
    <div class="form-group row"></div>
    <div class="form-group row"></div>
    <form name="frm"  method="get">
        <div class="form-outer-group">
            <div class="form-group row">
                <label>핸드폰번호</label>
                <div class="inputs">
                    <input type="text" size="2" id="student_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.student_phone2,3)">&nbsp;-&nbsp;
                    <input type="text" size="5" id="student_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.student_phone3,4)">&nbsp;-&nbsp;
                    <input type="text" size="5" id="student_phone3" class="form-control" maxlength="4">
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label>이메일</label>
            <div><input type="text" class="form-control" id="member_email"></div>
        </div>
        <div class="bot_btns">
            <button class="btn_pack blue s2" type="button"  onclick="find_password();">찾기</button>
            <button class="btn_pack blue s2" type="button"  onclick="javscript:self.close();">닫기</button>
        </div>
        <div class="form-group row"></div>
        <div class="form-group row" id="temporaryPassword_div" style="display: none;">
            <label>임시비밀번호</label>
            <span id="l_temporaryPassword"></span>
        </div>
    </form>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>