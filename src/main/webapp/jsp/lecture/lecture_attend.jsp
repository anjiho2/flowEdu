<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">

function init() {
    attendTypeSelectbox("l_attendType",""); //출석타입 셀렉박스
    var lecture_id = getInputTextValue("lecture_id");
    //강의 학생리스트 불러오기
    lectureService.getLectureAttendList(lecture_id, function (selList) {
        if(selList.length > 0){
            for(var i =0 ; i < selList.length; i++){
                var cmpList = selList[i];
                //attendtype이 없는 학생들 리스트
                if(cmpList.attendType == null){
                    if (cmpList != undefined) {
                        var checkHTML = "<input type='checkbox' name='chk' id='chk' value='" + cmpList.studentId + "'/>";
                        var cellData = [
                            function(data) {return cmpList.studentName;},
                          //  function(data) {return cmpList.schoolName;},
                            function(data) {return checkHTML;}
                        ];
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                    }
                }else{ //출석 or 지각체크된 학생들 리스트
                    var cellData = [
                        function(data) {return cmpList.studentName;},
                        function(data) {return convert_attend(cmpList.attendType);},
                    ];
                    dwr.util.addRows("attend_dataList", [0], cellData, {escapeHtml: false});
                }
            }
        }
    });
}

//저장
function save_attend() {
    var lecture_id = getInputTextValue("lecture_id");
    var sel_attendType = getSelectboxValue("sel_attendType");
    var data_list = new Array();

    if(sel_attendType == "" || sel_attendType == undefined){
        alert("출석타입을 선택해주세요.");
        focusInputText("sel_attendType");
        return;
    }

    $("input[name=chk]:checked").each(function() {
        var studentIds = $(this).val();

        if (studentIds == "") {
            alert(comment.blank_check);
            return;
        }

        var data ={
            lectureId:lecture_id,
            studentId:studentIds,
            attendType:sel_attendType
        };
        data_list.push(data);
    });
    lectureService.saveLectureAttendList(data_list, function() {
        alert("출석체크 완료.");
        isReloadPage(true);
    });
}
</script>

<body onload="init();">
<form name="frm" id="frm" method="get">
    <div>
        <span id="l_attendType"></span>
        <table>
            <input type="hidden" name="page_gbn" id="page_gbn">
            <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lecture_id%>">
            <colgroup>
                <col width="*" />
                <col width="2%" />
            </colgroup>
            <thead>
            <tr style="">
                <th>학생이름</th>
                <th><input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');"></th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
        </table>
    </div>

    <div>
        <input type="button" value="출석저장" onclick="save_attend();">
    </div>

    <div>
        <h1>출석체크된 학생리스트</h1>
        <table>
            <colgroup>
                <col width="*" />
                <col width="*" />

            </colgroup>
            <thead>
            <tr style="">
                <th>학생이름</th>
                <th>결과</th>
            </tr>
            </thead>
            <tbody id="attend_dataList"></tbody>
        </table>
    </div>

</form>
</body>
</html>
