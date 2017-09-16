<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long student_memo_id = Long.parseLong(request.getParameter("student_memo_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
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

            /*상담내용*/
            innerHTML("member_name", selList.studentMemoDto.memberName);
            innerHTML("create_date", selList.studentMemoDto.createDate);
            innerHTML("process_yn",  selList.studentMemoDto.processYn == false ? "미처리" : "처리완료");
            innerHTML("memo_content",selList.studentMemoDto.memoContent);
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

</script>
<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" id="student_memo_id" value="<%=student_memo_id%>">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden"  id="sPage" value="<%=sPage%>">
    <span id="l_memoType"></span>
        <h1>상담상세</h1>
             <div style="position: relative; left: 0px; top: 50px;">
                 <table border="1">
                    <tr>
                        <td>상담자</td>
                        <td><span id="member_name"></span></td>
                    </tr>
                    <tr>
                        <td>상담구분</td>
                        <td><span id="memo_type"></span></td>
                    </tr>
                    <tr>
                        <td>상담날짜</td>
                        <td><span id="create_date"></span></td>
                    </tr>
                    <tr>
                        <td>처리여부</td>
                        <td><span id="process_yn"></span></td>
                    </tr>
                    <tr>
                        <td>상담내용</td>
                        <td><span id="memo_content"></span></td>
                    </tr>
                 </table>
            </div>
            <!--댓글 작성/리스트-->
            <div style="position: relative; left: 0px; top: 100px;">
                <table border="1">
                    <tr>
                        <td><span id="l_memo_reply"></span></td>
                    </tr>
                    <tbody id="dataList"></tbody>
                </table>
                <textarea id="reply_content" placeholder="댓글을 작성해주세요."></textarea>
                <input type="button" value="작성" onclick="save_memo_reply();">
            </div>
            <!--댓글 작성/리스트 끝-->
</form>
</body>