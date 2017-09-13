<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script>

    function init() {
        studentmemoTypeSelectbox("sel_memo_type","");//상담검색시
        studentMemoTypeRadio("l_memoType", "REG", "");//상담입력시
        fn_search("new");
    }

    function studentMemo() {//상담저장
        var student_id  = getInputTextValue("student_id");
        var consultMemo = getInputTextValue("consultMemo");
        var memoType = get_radio_value("memo_type");
        studentService.saveStudentMemo(student_id, consultMemo, memoType, function () {
            alert("상담저장완료");
            location.reload();
        });
    }

    //학생의 모든상담리스트
    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        var searchdate = getInputTextValue("monthpicker");
        var memoType = getInputTextValue("sel_memoType");
        var member_name = getInputTextValue("member_name");
        var memo_content = getInputTextValue("memo_content");

        if(searchdate == undefined || memoType == undefined ||  member_name == undefined || memo_content == undefined){
            searchdate = "";
            memoType = "";
            member_name = "";
            memo_content = "";
        }
        if(val == "new") sPage = "1";
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");
        studentService.getStudentMemoListCount( <%=student_id%>, searchdate, memoType, member_name, memo_content, function(cnt) {
            paging.count(sPage, cnt, 10, 10, comment.blank_list);
            studentService.getStudentMemoList(sPage, 10, <%=student_id%>, searchdate, memoType, member_name, memo_content, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList == undefined) {
                        } else

                            var memoHTML = "<a href='javascript:void(0);'  onclick='go_reply("+ '"' + 'student' + '"' + ","+ '"' + 'detail_memo_student' + '"' + ","+ '"' + cmpList.studentMemoId + '"' + ");' />"+cmpList.memoContent+"</a>";
                            var cellData = [
                                //cmpList.memoContent;
                                function (data) {return memoHTML;},
                                function (data) {return cmpList.memberName;},
                                function (data) {return convert_memo_type(cmpList.memoType);},
                                function (data) {return getDateTimeSplitComma(cmpList.createDate);},
                                function (data) {return cmpList.processYn == false ? "<input type='button' value='처리하기' id=" + cmpList.studentMemoId + " onclick='changeProccessYn(this.id);'>" : "처리완료";
                                }
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                });
            });
        }

    //댓글 페이지 이동
    function go_reply(mapping_value, page_value, memo_id) {
        with(document.frm) {
            if (mapping_value != "" && page_value != "") {
                page_gbn.value = page_value;
                student_memo_id.value = memo_id;
            }
            action = getContextPath()+"/"+mapping_value+".do";
            submit();
        }
    }
</script>


<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" id="student_id" value="<%=student_id%>">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden"  id="sPage" value="<%=sPage%>">
    <input type="hidden" name="student_memo_id" id="student_memo_id">
    <span id="l_memoType"></span>
<div>
    <textarea id="consultMemo" cols="50" rows="5" placeholder="상담내용을 입력하세요"></textarea>
    <input type="button" value="상담저장" onclick="studentMemo();">
</div>
<br>
<div style="float:left;">
    <h1>[상담리스트]</h1>
        <!--검색단-->
        작성일:  <input type="text" id="monthpicker" placeholder="작성일">
        작성자:  <input type="text" id="member_name" placeholder="작성자">
        상담구분:<span id="sel_memo_type" ></span>
        내용  :  <input type="text" id="memo_content" placeholder="내용">
        <input type="button" value="검색" onclick="fn_search('new')">
        <!--검색단 끝-->
    <table class="table_list" border="1">
        <colgroup>
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
        </colgroup>
        <thead>
        <tr>
            <th>상담내용</th>
            <th>상담자</th>
            <th>상담구분</th>
            <th>상담날짜</th>
            <th>처리여부</th>
        </tr>
        </thead>
        <tbody id="dataList"></tbody>
        <tr>
            <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
        </tr>
    </table>
    <%@ include file="/common/inc/com_pageNavi.inc" %>
</div>
<script type='text/javascript' src='<%=webRoot%>/js/monthpicker.js'></script>
</form>
</body>