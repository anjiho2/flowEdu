<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">

function init() {
    var lecture_id = getInputTextValue("lecture_id");
    lectureService.getStudentListByLectureRegister(lecture_id, function (selList) {
        if(selList.length > 0){
            for(var i =0 ; i < selList.length; i++){
                var cmpList = selList[i];
                if (cmpList != undefined) {{
                    var checkHTML = "<input type='checkbox' name='chk' id='chk' value='" + cmpList.studentId + "'/>";
                    var cellData = [
                        function(data) {return cmpList.studentName;},
                        function(data) {return cmpList.schoolName;},
                        function(data) {return checkHTML;}
                    ];
                    dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                }
            }
            }
        }
    });
}


function save_attend() {
    var lecture_id = getInputTextValue("lecture_id");
    var attendType = "ATTEND";


    $("input[name=chk]:checked").each(function() {
        var studentId = $(this).val();

        if (studentId == "") {
            alert(comment.blank_check);
            return;
        }
        lectureService.saveLectureAttend(lecture_id, studentId, attendType ,function() {
            alert("출석체크 완료.");
        });
    });
}
</script>

<body onload="init();">
<form name="frm" id="frm" method="get">

    <div>
        <table>
            <input type="hidden" name="page_gbn" id="page_gbn">
            <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lecture_id%>">
            <colgroup>
                <col width="*" />
                <col width="*" />
                <col width="2%" />
            </colgroup>
            <thead>
            <tr style="">
                <th>학생이름</th>
                <th>학생학교</th>
                <th><input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');"></th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
        </table>
    </div>

    <div>
        <input type="button" value="출석저장" onclick="save_attend();">
    </div>
</form>
</body>
</html>
