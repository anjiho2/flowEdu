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

        studentList("new");
    }

    //학생리스트 가져오기
    function studentList(val) {

        var paging = new Paging();
        var sPage = $("#sPage").val();

        if(val == "new") sPage = "1";

        studentService.getSudentListCount( function (cnt) {

            paging.count(sPage, cnt, '10', '5', comment.blank_list);

            studentService.getSudentList(sPage,'5',function (selList) {

                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        console.log(selList);
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            //var checkHTML = "<input type='checkbox' name='chk' id='chk' value='" + cmpList.studentId + "'/>";
                            var modifyHTML = "<input type='button'  name='addList' id='addList' value='추가' onclick='student_add(" + cmpList.studentId + ");'/>";
                            var cellData = [
                                //function(data) {return checkHTML;},
                                function(data) {return cmpList.studentName;},
                                function(data) {return cmpList.schoolName;},
                                function(data) {return convert_school(cmpList.schoolType);},
                                function(data) {return convert_lecture_grade(cmpList.studentGrade);},
                                function(data) {return modifyHTML;}
                            ];
                            dwr.util.addRows("studentList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }
            })
        });
        }
        
        function student_add(val) {
            $('#sel_student > tbody:last').append('<tr><td>test</td></tr>');
        }

</script>


<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lecture_id%>">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">

    강의명   :  <span id="lecture_name"></span> 강의 신청page <br>
    최대인원 :  <span id="lecture_limit"></span> 명 <br>
    현재인원 :  <span id=""></span> 명
    <br>
    <br>

    <!--학생리스트-->
    <div style="width:278px;text-align:center;float:left;">
        <table class="student_list" border="1">
            <colgroup>
                <col width="10%" />
                <col width="35%" />
                <col width="17%" />
                <col width="18%" />
                <col width="20%" />
            </colgroup>
            <thead>
            <tr>
                <th>이름</th>
                <th>학교이름</th>
                <th>구분</th>
                <th>학년</th>
                <th>추가</th>
            </tr>
            </thead>
            <tbody id="studentList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
        <%@ include file="/common/inc/com_pageNavi.inc" %>
    </div>

    <!--선택된학생리스트-->
    <div style="width:280px;text-align:center;float:left;position:relative;left:50px;">
        <table id="" border="1" cellspacing="3">
            <colgroup>
                <col width="10%" />
                <col width="35%" />
                <col width="17%" />
                <col width="18%" />
                <col width="20%" />
            </colgroup>
            <thead>
            <tr>
                <th>이름</th>
                <th>학교이름</th>
                <th>구분</th>
                <th>학년</th>
                <th>제거</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>

    <!--기존신청된학생들 리스트-->
    <div style="width:280px;text-align:center;float:left;position:relative;left:110px;">
        <table id="" border="1" cellspacing="3">
            <colgroup>
                <col width="10%" />
                <col width="35%" />
                <col width="17%" />
                <col width="18%" />
                <col width="20%" />
            </colgroup>
            <thead>
            <tr>
                <th>이름</th>
                <th>학교이름</th>
                <th>구분</th>
                <th>학년</th>
                <th>추가</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>

    </div>



</form>
</body>
</html>
