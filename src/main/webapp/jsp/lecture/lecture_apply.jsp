<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
%>

<script type="text/javascript">
    function init() {
        //강의정보 가져오기
        var lecture_id = getInputTextValue("lecture_id");
        lectureService.getLectureInfo(lecture_id, function (sel) {
            $("#lecture_name").html(sel.lectureName);
            $("#lecture_limit").html(sel.lectureLimitStudent);
        });

        //강의 기존신청된 학생들 리스트 가져오기
        lectureService.getStudentListByLectureRegister(lecture_id, function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                console.log(selList);
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var modifyHTML = "<input type='button'  name='addList' id='"+cmpList.studentId+"' class='checkBtn' value='-' onclick=''/>";
                        var cellData = [
                            function(data) {return cmpList.studentName;},
                            function(data) {return cmpList.schoolName;},
                            function(data) {return modifyHTML;}
                        ];
                        dwr.util.addRows("exist_studentList", [0], cellData, {escapeHtml: false});
                    }
                }
            }
        });

        fn_search("new");
    }

    //학생리스트 가져오기
    function fn_search(val) {

        var paging = new Paging();
        var sPage = $("#sPage").val();

        if(val == "new") sPage = "1";
        dwr.util.removeAllRows("studentList");
        studentService.getSudentListCount( function (cnt) {

            paging.count(sPage, cnt, '10', '5', comment.blank_list);

            studentService.getSudentList(sPage,'5',function (selList) {

                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {

                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            //var checkHTML = "<input type='checkbox' name='chk' id='chk' value='" + cmpList.studentId + "'/>";
                            var modifyHTML = "<input type='button'  name='addList' id='"+cmpList.studentId+"' class='checkBtn' value='추가' onclick='add_student($(this), this.id);'/>";
                            var cellData = [
                                //function(data) {return checkHTML;},
                                function(data) {return cmpList.studentName;},
                                function(data) {return convert_lecture_grade(cmpList.studentGrade);},
                                function(data) {return cmpList.schoolName;},
                                function(data) {return modifyHTML;}
                            ];
                            dwr.util.addRows("studentList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }
            })
        });
    }

    function add_student(val, val2) {

        var str = "";
        var tdArr = new Array();
        var checkBtn = val;

        var lecture_id = getInputTextValue("lecture_id");
        var tr = checkBtn.parent().parent();
        var td = tr.children();
        var studentIds = new Array();

        lectureService.checkLectureStudentRel(lecture_id,val2, function (num) {
            if (num == 1){
                alert("강의 최대인원 초과되었습니다.");
                return false;
            }else if(num == 2){
                alert("기존 신청된 학생입니다.");
                return false;
            }else{
                $('li[name="student_id[]"]').each(function () {
                    studentIds.push($(this).val());
                });
                if ($.inArray(parseInt(val2), studentIds) != -1) {
                    alert("똑같은 학생이 선택되었습니다.");
                    return;
                } else {
                    var append = "<li name='student_id[]' value='" + val2 + "'>" + td.eq(0).text() + "</li>";
                    $("#sel_student").append(append);
                }
            }
        });

    }

    function save_lecture_student() {

        var studentIds = $.makeArray($('li[name="student_id[]"]').map(function () {
            return $(this).val();
        }));

        var lecture_id=getInputTextValue("lecture_id");
        lectureService.saveLectureStudentRel(lecture_id, studentIds, function (bl) {
            if(bl==true){
                alert("등록되었습니다.");
            }
        });
    }
</script>


<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lecture_id%>">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">

    강의명   :  <span id="lecture_name"></span> 강의 신청page <br>
    최대인원 :  <span id="lecture_limit"></span> 명 <br>
    현재인원 : <span id=""> </span> 명
    <br>
    <br>

    <!--학생리스트-->
    <div style="width:278px;text-align:center;float:left;">
        [학생 목록]
        <table class="student_list" border="1">
            <colgroup>
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
            </colgroup>
            <tbody id="studentList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
        <%@ include file="/common/inc/com_pageNavi.inc" %>
    </div>

    <!--선택된학생리스트-->
    <div id="sel_student" style="width:278px;text-align:center;float:left;">
        [선택된 학생 목록]
        <input type="button" value="저장" onclick="save_lecture_student();">
    </div>

    <!--기존신청된학생들 리스트-->
    <div style="width:200px;text-align:center;float:left;">
        [기존신청된 학생 목록]
        <table class="student_list" border="1">
            <tbody id="exist_studentList"></tbody>
        </table>
    </div>
</form>
</body>
</html>

