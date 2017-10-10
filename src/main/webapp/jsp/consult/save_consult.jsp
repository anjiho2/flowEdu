<%@ page import="com.flowedu.util.Util" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 3;
    int depth2 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/consultService.js'></script>
<script>
    function saveConsultMemo() {
        var check = new isCheck();
        var phoneNumber = getInputTextValue("student_phone1") + getInputTextValue("student_phone2") + getInputTextValue("student_phone3");
        var memoType = get_radio_value("memo_type");
        var content = getInputTextValue("consultMemo");

        if ( check.input("student_phone1", "전화번호롤 입력하세요.") == false
            || check.input("student_phone2", "전화번호롤 입력하세요.") == false
            || check.input("student_phone3", "전화번호롤 입력하세요.") == false) return;

        consultService.saveEarlyConsultMemo(phoneNumber, memoType, content, function () {
            alert(comment.success_process);
            isReloadPage(true);
        });
    }
</script>
<body>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/consult_top_menu.jsp" %>
</div>
</section>
<section class="content divide">
        <div class="left">
            <div class="form_st1">
            <form name="frm" method="get">
                <%--<input type="hidden" name="student_memo_id" id="student_memo_id">--%>
                <input type="hidden" name="page_gbn">
            </form>
                <h3 class="title_t1">신규 상담 등록</h3>
                <div class="form-group row">
                    <span id="l_memoType"></span>
                </div>
                <div class="form-group row">
                    <div class="inputs">
                        <input type="text" size="2" id="student_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this, student_phone2, 3)" placeholder="핸드폰 번호">&nbsp;-&nbsp;
                        <input type="text" size="5" id="student_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this, student_phone3, 4)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="student_phone3" class="form-control" maxlength="4">
                    </div>
                </div>
                <div class="form-group row">
                    <div><textarea class="form-control"  id="consultMemo" rows="5" placeholder="상담내용을 입력하세요"></textarea></div>
                </div>
                <div class="bot_btns" align="">
                    <button class="btn_pack blue s2" type="button"  onclick="saveConsultMemo();">저장</button>
                </div>
            </div>
        </div>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
<script type='text/javascript' src="<%=webRoot%>/js/monthpicker.js"></script>
<script>
    studentMemoTypeRadio("l_memoType", "REG", "");
</script>
</body>
