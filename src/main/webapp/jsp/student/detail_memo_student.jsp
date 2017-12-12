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
            innerHTML("memo_content",selList.studentMemoDto.memoContent);
            innerHTML("memo_type", convert_memo_type(selList.studentMemoDto.memoType));


            /*상담-댓글리스트*/
            if (selList.studentMemoReplyDtoList.length > 0) {
                for (var i = 0; i < selList.studentMemoReplyDtoList.length; i++) {
                    var cmpList = selList.studentMemoReplyDtoList[i];

                    if('<%=memberId%>' == selList.studentMemoDto.flowMemberId){
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
<form name="frm" method="get">
    <input type="hidden"  id="sPage" value="<%=sPage%>">
    <input type="hidden" id="student_id" name="student_id" value="<%=student_id%>">
    <input type="hidden" id="student_memo_id" value="<%=student_memo_id%>">
    <input type="hidden" name="student_name" value="<%=student_name%>">
    <input type="hidden" name="page_gbn" id="page_gbn">
</form>
<section class="content divide">
    <div class="left">
        <div class="tile_box">
            <h3 class="title_t1">상담 상세 정보</h3>
            <ul class="list_t1">
                <li>
                    <strong>상담자</strong>
                    <div><p><span id="member_name"></span></p></div>
                </li>
                <li>
                    <strong>상담구분</strong>
                    <div><p><span id="memo_type"></span></p></div>
                </li>
                <li>
                    <strong>상담날짜</strong>
                    <div><p><span id="create_date"></span></p></div>
                </li>
                <li>
                    <strong>상담내용</strong>
                    <div><p><span id="memo_content"></span></p></div>
                </li>
                <li>
                    <strong>처리여부</strong>
                    <div>
                        <p><span id="process_yn"></span></p>
                    </div>
                    <!--
                    <div id="process_div" style="display: none;">
                        <button class="btn_pack blue" type="button" onclick="changeProccessYn();">처리하기</button>
                    </div>
                    -->
                </li>
            </ul>
        </div>
        <div class="form-group row"></div>
        <div id="process_div" style="display: none;" align="left">
            <div>
                <button class="btn_pack blue" type="button" onclick="changeProccessYn();">처리하기</button>
                <button class="btn_pack black" type="button">목록</button>
            </div>
        </div>
    </div>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
<script type='text/javascript' src="<%=webRoot%>/js/monthpicker.js"></script>
</body>
</form>
</body>