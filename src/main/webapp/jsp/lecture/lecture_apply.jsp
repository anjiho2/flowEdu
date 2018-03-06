<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));

    int depth1 = 5;
    int depth2 = 1;

    int siderMenuDepth1 = 4;
    int siderMenuDepth2 = 0;
    int siderMenuDepth3 = 0;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script type="text/javascript">
    function init() {
        //강의정보 가져오기
        var lecture_id = getInputTextValue("lecture_id");
        lectureService.getLectureInfo(lecture_id, function (sel) {
            innerHTML("lecture_name", sel.lectureName);
            innerHTML("lecture_limit", sel.lectureLimitStudent);
            innerHTML("lecture_reg_count", sel.regCount);
            innerValue("max_student_count", sel.lectureLimitStudent);
        });

        //강의 기존신청된 학생들 리스트 가져오기
        lectureService.getStudentListByLectureRegister(lecture_id, function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var delHTML = "<button class='btn_pack white' type='button' style='min-width:36px;' id='"+cmpList.lectureRelId+"' onclick='delete_student(this.id)'>X</button>";
                        var cellData = [
                            function(data) {return cmpList.studentName;},
                            function(data) {return cmpList.schoolName;},
                            function(data) {return delHTML;}
                        ];
                        dwr.util.addRows("exist_studentList", [0], cellData, {escapeHtml: false});
                    }
                }
            }
        });

        fn_search("new");
    }

    //강의에서 신청된학생 삭제
    function delete_student(val) {
        if(confirm("삭제 하시겠습니까?")){
            lectureService.modifyLectureStudentRel(val, 0, 0, false, function () {
                alert("삭제되었습니다.");
                location.reload();
            });
        }
    }

    function detail_student_page(student_id) {
        innerValue("student_id", student_id);
        goPage('student', 'modify_student');
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
                            var modifyHTML = "<button class='btn_pack white' type='button' id='"+cmpList.studentId+"' style='min-width:36px;' onclick='add_student($(this), this.id);'/>┼</button>";
                            var detailStudent = "<a href='javascript:void(0);' onclick='detail_student_page("+cmpList.studentId+")' >"+cmpList.studentName+"</a>"
                            var cellData = [
                                function(data) {return detailStudent;},
                                //function(data) {return cmpList.studentName;},
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
        var count = getInnerHtmlValue("selected_count");
        var limitCount = getInputTextValue("max_student_count");
        var regCount = getInnerHtmlValue("lecture_reg_count");

        lectureService.checkLectureStudentRel(lecture_id,val2, function (num) {
            if (num == 1 || ( (parseInt(count)  + parseInt(regCount)) >= limitCount) ){
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
                                                                                                                                    //<button class='btn_pack white' type='button' style='min-width:36px;' id='"+val2+"' onclick='remove_student(this.id)'>X</button>";
                    var append = "<li name='student_id[]' value='" + val2 + "' id=student_li_"+ val2 + ">" + td.eq(0).text() + "&nbsp;<button class='btn_pack white' type='button' style='min-width:36px;' id='"+val2+"' onclick='remove_student(this.id)'>X</button></li>";
                    $("#sel_studentlist").append(append);
                    count++;
                    innerHTML("selected_count", count);
                }
            }
        });
    }

    function save_lecture_student() {

        var Ids_length = $.makeArray($('li[name="student_id[]"]').map(function () {return $(this).val();}));
        if(Ids_length == "") {alert("선택된 학생이 없습니다."); return;}

        if (confirm(comment.isInsert)) {
            var studentIds = $.makeArray($('li[name="student_id[]"]').map(function () {
                return $(this).val();
            }));

            var lecture_id = getInputTextValue("lecture_id");
            lectureService.saveLectureStudentRel(lecture_id, studentIds, function (bl) {
                if (bl == true) {
                    alert("등록되었습니다.");
                    isReloadPage(true);
                }
            });
        }
    }

    //선택된 학생 목록 삭제
    function remove_student(val) {
        var count = getInnerHtmlValue("selected_count");
        var li_id = "student_li_" + val;
        var li_value = getInputTextValue(li_id);
        if (li_value != "") {
            $("#"+li_id).remove();
            count--;
            if (count == 0) count = "0";
            innerHTML("selected_count", count);
        }
    }
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/lecture_top_menu.jsp" %>
</div>
</section>
<form name="frm" id="frm" method="get">
    <section class="content">
        <h3 class="title_t1">강의신청</h3>
            <div class="tb_t1">
                <table>
                    <tr style="">
                        <th> 강의명   :  <span id="lecture_name"></span></th>
                        <th> 최대인원 :  <span id="lecture_limit"></span>명</th>
                        <th> 현재인원 :  <span id="lecture_reg_count">0</span>명</th>
                    </tr>
                </table>
            </div>
    </section>
    <section class="content divide">
        <div class="left">
            <div class="tile_box">
                <h3 class="title_t1">학생목록</h3>
                <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lecture_id%>">
                <input type="hidden" name="page_gbn" id="page_gbn">
                <input type="hidden" name="student_id" id="student_id">
                <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
                <input type="hidden" id="max_student_count">
                <!--학생리스트-->
                <div class="tb_t1">
                    <table class="checkbox_t2">
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
            </div>

        </div>
        <div class="right">
            <div class="tile_box">
                <div class="form-group row">
                    <div><h3 class="title_t1">신청목록</h3></div>
                    <div> <span id="selected_count">0</span>명</div>
                    <div><button class='btn_pack white' type='button' id='"+cmpList.lectureRelId+"' onclick="save_lecture_student();">저장</button></div>
                </div>
                <!--선택된학생리스트-->
                <div class="tb_t1" id="sel_student">
                    <ul class="list_t2 checkbox_t2" id="sel_studentlist">
                    </ul>
                </div>
            </div>
        </div>
        <!--기존신청된학생들 리스트-->
        <div class="tb_t1">
            <div class="tile_box">
                <h3 class="title_t1">기존 수강중인 학생</h3>
                <table><!--class="student_list"-->
                    <tbody id="exist_studentList"></tbody>
                </table>
            </div>
        </div>
</section>
</form>
</body>

