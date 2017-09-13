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

    //y(Long studentMemoId, String replyContent)


    studentService.saveStudentMemoReply(function () {
        
    })
}

function fn_search(val) {
    var sPage = $("#sPage").val();
    if(val == "new") sPage = "1";
    var student_memo_id = getInputTextValue("student_memo_id");
        studentService.getStudentMemoReplyList(sPage, 10, student_memo_id, function (selList) {

            /*상담내용*/
            innerValue("member_name", selList.studentMemoDto.memberName);
            innerValue("create_date", selList.studentMemoDto.createDate);
            innerValue("process_yn", selList.studentMemoDto.processYn);
            innerValue("memo_content", selList.studentMemoDto.memoContent);
            innerValue("memo_type", selList.studentMemoDto.memoType);

            /*상담-댓글리스트*/
            if (selList.studentMemoReplyDtoList.length > 0) {
                for (var i = 0; i < selList.studentMemoReplyDtoList.length; i++) {
                    var cmpList = selList.studentMemoReplyDtoList[i];
                    if (cmpList == undefined) {
                    } else
                        var cellData = [
                            function (data) {return cmpList.memberName;},
                            function (data) {return cmpList.replyContent;},
                        ];
                    dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                }
            }
        });
}

</script>
<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" id="student_memo_id" value="<%=student_memo_id%>">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden"  id="sPage" value="<%=sPage%>">
    <span id="l_memoType"></span>
    <div>
        <h1>상담상세</h1>
        <table border="1">
            <tr>
                <td>상담자</td>
                <td><input type="text" id="member_name"></td>
            </tr>
            <tr>
                <td>상담구분</td>
                <td><input type="text" id="memo_type"></td>
            </tr>
            <tr>
                <td>상담날짜</td>
                <td><input type="text" id="create_date"></td>
            </tr>
            <tr>
                <td>처리여부</td>
                <td><input type="text" id="process_yn"></td>
            </tr>
            <tr>
                <td>상담내용</td>
                <td><textarea id="memo_content"></textarea></td>
            </tr>
        </table>
        <table>
            <h1>댓글쓰기</h1>
            <thead>
            <div>
                <td><textarea id="memo_reply"></textarea></td>
                <td><input type="button" value="작성" onclick="save_memo_reply();"></td>
            </div>
                댓글리스트
                <td><span id="l_memo_reply"></span></td>
            </thead>
            <tbody id="dataList"></tbody>
        </table>
    </div>
</form>
</body>