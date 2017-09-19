<%@ page import="com.flowedu.util.Util" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 4;
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    Long student_memo_id = Long.parseLong(request.getParameter("student_memo_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String student_name = StringUtil.convertParmeterStr(request.getParameter("student_name"), "UTF-8");
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script>
function init() {
    fn_search("new");
}

//댓글저장
function save_memo_reply() {
    var student_memo_id = getInputTextValue("student_memo_id");
    var reply_content = getInputTextValue("reply_content");
    if (confirm("댓글 등록하시겠습니까?")) {
        studentService.saveStudentMemoReply(student_memo_id, reply_content, function () {
            alert("등록되었습니다.");
            location.reload();
        });
    }
}

function fn_search(val) {
    var sPage = $("#sPage").val();
    if(val == "new") sPage = "1";
    var student_memo_id = getInputTextValue("student_memo_id");
        studentService.getStudentMemoReplyList(sPage, 10, student_memo_id, function (selList) {
            if (selList.studentMemoDto.processYn == false) {
                gfn_display("process_div", true);
            }
            /*상담내용*/
            innerHTML("member_name", selList.studentMemoDto.memberName);
            innerHTML("create_date", getDateTimeSplitComma(selList.studentMemoDto.createDate));
            innerHTML("process_yn",  selList.studentMemoDto.processYn == false ? "미처리" : "처리완료");
            innerValue("memo_content",selList.studentMemoDto.memoContent);
            innerHTML("memo_type", convert_memo_type(selList.studentMemoDto.memoType));


            /*상담-댓글리스트*/
            if (selList.studentMemoReplyDtoList.length > 0) {
                for (var i = 0; i < selList.studentMemoReplyDtoList.length; i++) {
                    var cmpList = selList.studentMemoReplyDtoList[i];

                    if(<%=memberId%> == selList.studentMemoDto.flowMemberId){
                        var memoReply_del = "<input type='button'  value='삭제'  onclick='memoReply_delete("+ '"' + cmpList.studentMemoReplyId + '"' + ");'/>";
                         var memoReply_modify = "<input type='button' id='modify_"+cmpList.studentMemoReplyId+"' value='변경' onclick='change_memoReply(" + cmpList.studentMemoReplyId + ");'/><input type='button'   id='change_"+cmpList.studentMemoReplyId+"' value='수정' onclick='modify_memoReply(" + cmpList.studentMemoReplyId + ");' style='display:none;'/>";
                    }else{
                        var memoReply_del = "<input type='button'  value='삭제'  onclick='memoReply_delete("+ '"' + cmpList.studentMemoReplyId + '"' + ");'/>";
                        var memoReply_modify = "<input type='button' id='modify_"+cmpList.studentMemoReplyId+"' value='변경' onclick='change_memoReply(" + cmpList.studentMemoReplyId + ");'/><input type='button'   id='change_"+cmpList.studentMemoReplyId+"' value='수정' onclick='modify_memoReply(" + cmpList.studentMemoReplyId + ");' style='display:none;'/>";
                    }

                    var replyContentHTML = "<input type='text' id='student_"+cmpList.studentMemoReplyId+"' value='"+cmpList.replyContent+"' style='border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;' disabled>";
                    if (cmpList == undefined) {
                    } else
                        var cellData = [
                            function (data) {return cmpList.memberName;},//작성자
                            function (data) {return replyContentHTML;},//댓글내용
                            function (data) {return getDateTimeSplitComma(cmpList.createDate);},//등록일
                            function (data) {return memoReply_del;}, //삭제
                            function (data) {return memoReply_modify;}, //수정
                        ];
                    dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                }
            }
        });
}

//수정버튼
function modify_memoReply(val) {

    var studentMemoReplyId =  "student_"+val;
    var modify_price = getInputTextValue(studentMemoReplyId);

    studentService.modifyStudentMemoReply( val, modify_price, false, function () {
        alert("댓글이 수정되었습니다.");
        location.reload();
    });
}

//변경버튼
function change_memoReply(val) {
    var studentMemoReplyId =  "change_"+val;
    var modifyButton = "modify_"+val;
    gfn_display(modifyButton, false);
    gfn_display(studentMemoReplyId, true);
    $("#student_"+val).removeAttr("disabled");
    $("#student_"+val).css("border","solid 1px black");
}

//댓글삭제
function memoReply_delete(val) {
    var studentMemoReplyId =  "student_"+val;
    var modify_price = getInputTextValue(studentMemoReplyId);
    studentService.modifyStudentMemoReply( val, modify_price, true, function () {
        alert("댓글이 삭제됨되었습니다.");
        location.reload();
    });
}

// 처리하기 버튼
function changeProccessYn() {
    var studentMemoId = '<%=student_memo_id%>';
    if (confirm("처리하시겠습니까?")) {
        studentService.modifyMemoProcessYn(studentMemoId, true);
        isReloadPage(true)
    }
}
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/student_depth_menu.jsp" %>
</div>
</section>
<section class="content">
    <h3 class="title_t1"><%=student_name%>학생 상담 상세 내용</h3>
    <form name="frm" method="get" class="form_st1">
        <input type="hidden"  id="sPage" value="<%=sPage%>">
        <input type="hidden" id="student_id" name="student_id" value="<%=student_id%>">
        <input type="hidden" id="student_memo_id" value="<%=student_memo_id%>">
        <input type="hidden" name="student_name" value="<%=student_name%>">
        <input type="hidden" name="page_gbn" id="page_gbn">

        <div class="form-group row">
            <label>상담자</label>
            <div><span id="member_name"></span></div>
        </div>
        <div class="form-group row">
            <label>상담구분</label>
            <div><span id="memo_type"></span></div>
        </div>
        <div class="form-group row">
            <label>상담날짜</label>
            <div><span id="create_date"></span></div>
        </div>
        <div class="form-group row">
            <label>상담내용</label>
            <div>
                <textarea class="form-control"  id="memo_content" rows="5" disabled></textarea>
                <%--<span id="memo_content"></span>--%>
            </div>
        </div>
        <div class="form-group row">
            <label>처리여부</label>
            <div><span id="process_yn"></span></div>
            <div id="process_div" style="display: none;">
                <button class="btn_pack blue s2" type="button" onclick="changeProccessYn();">처리하기</button>
            </div>
        </div>
    </form>
    <!--댓글 작성/리스트-->
    <%--<div style="position: relative; left: 0px; top: 100px;">--%>
    <%--<table border="1">--%>
    <%--<tr>--%>
    <%--<td><span id="l_memo_reply"></span></td>--%>
    <%--</tr>--%>
    <%--<tbody id="dataList"></tbody>--%>
    <%--</table>--%>
    <%--<textarea id="reply_content" placeholder="댓글을 작성해주세요."></textarea>--%>
    <%--<input type="button" value="작성" onclick="save_memo_reply();">--%>
    <%--</div>--%>
    <%--<!--댓글 작성/리스트 끝-->--%>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
<script type='text/javascript' src="<%=webRoot%>/js/monthpicker.js"></script>
</body>
</form>
</body>