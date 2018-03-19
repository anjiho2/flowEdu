<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 3;
    int depth2 = 1;
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/studentService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/consultService.js'></script>
<script>
    function init() {
        fn_search("new");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();

        if(val == "new") sPage = "1";
        dwr.util.removeAllOptions("dataList");
        //gfn_emptyView("H", "");

        consultService.earlyConsultMemoCount(function (cnt) {
            paging.count(sPage, cnt, 5, 5, comment.blank_list);

            consultService.selectEarlyConsultMemoList(sPage, 5, function (memoList) {
                if (memoList.length < 1) return;

                function formatter(memoList) {
                    return "<label></label>" +
                            "<div>" +
                                "<h4><span><i class='tag'>" + convert_memo_type(memoList.memoType) + "</i>" + memoList.memberName + "</span>"+
                                "<em>" + getDateTimeSplitComma(memoList.createDate) + "</em></h4>"+
                                "<p>" + ellipsis(memoList.memoContent, 30) + "</p>" +
                                   "<h4><em>전화번호 : " + fn_tel_tag(memoList.phoneNumber) + "</em></h4>" +
                            "</div>" +
                            "<div class='manage'>" +
                                "<button type='button' onclick='goStudentReg("+ '"' + 'student' + '"' + ","+ '"' + 'save_student' + '"' + ","+ '"' + memoList.phoneNumber + '"' + ");'>학생등록" +
                                "<button type='button' onclick='deleteConsultMemo("+ memoList.earlyConsultMemoId + ");'>삭제" +
                            "</div>";
                }
                dwr.util.addOptions("dataList", memoList, formatter, {escapeHtml:false});
            });
        });
    }
    
    function saveConsultMemo() {
        var check = new isCheck();
        var phoneNumber = getInputTextValue("student_phone1") + getInputTextValue("student_phone2") + getInputTextValue("student_phone3");
        var memoType = get_radio_value("memo_type");
        var content = getInputTextValue("consultMemo");

        if ( check.input("student_phone1", comment.input_member_tel1) == false
            || check.input("student_phone2", comment.input_member_tel1) == false
            || check.input("student_phone3", comment.input_member_tel1) == false ) return;

        if (confirm(comment.isSave)) {
            consultService.saveEarlyConsultMemo(phoneNumber, memoType, content, function () {
                alert(comment.success_process);
                isReloadPage(true);
            });
        }
    }
    //전화번로 입력시 등록되어 있는 전화번호인지 확인
    function isStudent() {
        if (getInputTextValue("student_phone1") == "" || getInputTextValue("student_phone2") == "" || getInputTextValue("student_phone3") == "") return;
        var phoneNumber = getInputTextValue("student_phone1") + getInputTextValue("student_phone2") + getInputTextValue("student_phone3");
        studentService.isStudentByPhoneNumber(phoneNumber, function (bl) {
            if (bl == true) {
                alert("학생정보에 등록되어있는 전화번호 입니다.");
                focusInputText("student_phone1");
                return;
            } else {
                alert("신규 전화번호 입니다.");
                focusInputText("consultMemo");
            }
        });
    }
    //학생 등록 페이지 이동
    function goStudentReg(mapping_value, page_value, phone_number_value) {
        studentService.isStudentByPhoneNumber(phone_number_value, function (bl) {
            if (bl == true) {
                alert("이미 학생정보에 등록되어있는 전화번호 입니다.");
                return;
            }
            with (document.frm) {
                if (mapping_value != "" && page_value != "") {
                    page_gbn.value = page_value;
                    phone_number.value = phone_number_value;
                    consult_yn.value = true
                }
                action = getContextPath() + "/" + mapping_value + ".do";
                submit();
            }
        });
    }
    //초기 상담 메모 삭제
    function deleteConsultMemo(consultMemoId) {
        if (confirm(comment.isDelete)) {
            consultService.deleteEarlyConsultMemo(consultMemoId, function () {
                alert(comment.success_delete);
                isReloadPage(true);
            });
        }
    }
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/consult_top_menu.jsp" %>
</div>
</section>
<section class="content divide">
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn">
        <input type="hidden" name="phone_number">
        <input type="hidden" name="consult_yn">
        <input type="hidden" id="sPage" value="<%=sPage%>">
    </form>
    <div class="left">
        <div class="form_st1">
            <h3 class="title_t1">신규 상담 등록</h3>
            <div class="form-group row">
                <span id="l_memoType"></span>
            </div>
            <div class="form-group row">
                <div class="inputs">
                    <input type="number" size="2" id="student_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this, student_phone2, 3)" placeholder="핸드폰 번호">&nbsp;-&nbsp;
                    <input type="number" size="5" id="student_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this, student_phone3, 4)">&nbsp;-&nbsp;
                    <input type="number" size="5" id="student_phone3" class="form-control" maxlength="4" onblur="isStudent();">
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
    <div class="right">
        <div class="form_st1">
        <div class="form-group row">
        </div>
            <div class="tb_t1">
                <ul class="list_t2 checkbox_t2"  id="dataList"></ul>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
                <div class="form-group row"></div>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
            </div>
        </div>
    </div>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
<script>
    studentMemoTypeRadio("l_memoType", "REG", "");
</script>
</body>
