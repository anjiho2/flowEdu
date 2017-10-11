<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 3;
    int depth2 = 1;
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/consultService.js'></script>
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
            paging.count(sPage, cnt, 2, 2, comment.blank_list);

            consultService.selectEarlyConsultMemoList(sPage, 2, function (memoList) {
                if (memoList.length < 1) return;

                function formatter(memoList) {
                    memoList.processYn == false ? processMent = "<button class='confirm' type='button' id="+memoList.earlyConsultMemoId+" onclick='changeProccessYn(this.id);'>처리하기</button>" : processMent = "<span><h4>처리완료</h4></span>";

                    return "<label></label>" +
                            "<div>" +
                                "<h4><span><i class='tag'>" + convert_memo_type(memoList.memoType) + "</i>" + memoList.memberName + "</span>"+
                                "<em>" + getDateTimeSplitComma(memoList.createDate) + "</em></h4>"+
                                "<p>" + ellipsis(memoList.memoContent, 30) + "</p>" +
                                processMent +
                            "</div>" +
                            "<div class='manage'>" +
                                "<button type='button' onclick='go_reply("+ '"' + 'student' + '"' + ","+ '"' + 'detail_memo_student' + '"' + ","+ '"' + memoList.earlyConsultMemoId + '"' + ");'>상세" +
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

        if ( check.input("student_phone1", "전화번호롤 입력하세요.") == false
            || check.input("student_phone2", "전화번호롤 입력하세요.") == false
            || check.input("student_phone3", "전화번호롤 입력하세요.") == false ) return;

        if (confirm(comment.isSave)) {
            consultService.saveEarlyConsultMemo(phoneNumber, memoType, content, function () {
                alert(comment.success_process);
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
        <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    </form>
    <div class="left">
        <div class="form_st1">
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
