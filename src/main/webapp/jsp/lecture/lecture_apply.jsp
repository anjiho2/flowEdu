<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String lectureId = Util.isNullValue(request.getParameter("lecture_id"), "");

    int depth1 = 4;
    int depth2 = 3;

    int siderMenuDepth1 = 4;
    int siderMenuDepth2 = 5;
    int siderMenuDepth3 = 3;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<style>
    .scrolltbody {
        display: block;
        border-collapse: collapse;
    }
    .scrolltbody tbody {
        display: block;
        height: 200px;
        overflow: auto;
    }
    .scrolltbody th:nth-of-type(1), .scrolltbody td:nth-of-type(1) { width: 6%; }
    .scrolltbody th:nth-of-type(2), .scrolltbody td:nth-of-type(2) { width: 8%; }
    .scrolltbody th:nth-of-type(3), .scrolltbody td:nth-of-type(3) { width: 11%; }
    .scrolltbody th:nth-of-type(4), .scrolltbody td:nth-of-type(4) { width: 17%; }
    .scrolltbody th:nth-of-type(5), .scrolltbody td:nth-of-type(5) { width: 12%; }
    .scrolltbody th:nth-of-type(6), .scrolltbody td:nth-of-type(6) { width: 12%; }
    .scrolltbody th:nth-of-type(7), .scrolltbody td:nth-of-type(7) { width: 12%; }
    .scrolltbody th:nth-of-type(8), .scrolltbody td:nth-of-type(8) { width: 15%; }

    .scrolltbody1 {
        display: block;
        border-collapse: collapse;
    }
    .scrolltbody1 tbody {
        display: block;
        height: 200px;
        overflow: auto;
    }
    .scrolltbody1 th:nth-of-type(3), .scrolltbody1 td:nth-of-type(3) { width: 10%; }
    .scrolltbody1 th:nth-of-type(4), .scrolltbody1 td:nth-of-type(4) { width: 17%; }
    .scrolltbody1 th:nth-of-type(5), .scrolltbody1 td:nth-of-type(5) { width: 12%; }
    .scrolltbody1 th:nth-of-type(6), .scrolltbody1 td:nth-of-type(6) { width: 12%; }
    .scrolltbody1 th:nth-of-type(7), .scrolltbody1 td:nth-of-type(7) { width: 12%; }
    .scrolltbody1 th:nth-of-type(8), .scrolltbody1 td:nth-of-type(8) { width: 15%; }
</style>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/studentService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/lectureManager.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/lectureService.js'></script>
<script>
    var lecutreId = '<%=lectureId%>';
    //강의 기본정보, 기존수강중인 학생 목록
    function init() {
        lectureManager.getLectureRegInfo(lecutreId, function (selList) {
            var lectureInfo = selList.lectureInfo;
            innerHTML("l_lectureName", lectureInfo.lectureName);
            innerHTML("l_teacherName", lectureInfo.manageMemberName);
            innerHTML("l_limitStudent", lectureInfo.lectureLimitStudent);
            innerHTML("l_lecturePrice", addThousandSeparatorCommas(lectureInfo.lecturePrice));
            innerHTML("l_regCount", lectureInfo.regCount == 0 ? "0" : lectureInfo.regCount);

            innerHTML("l_limitCount", lectureInfo.regCount == 0 ? "0" : lectureInfo.regCount);
            innerHTML("l_isAddCount", (lectureInfo.lectureLimitStudent - lectureInfo.regCount));

            innerValue("regCount", (lectureInfo.lectureLimitStudent - lectureInfo.regCount));
            innerValue("addCount", lectureInfo.regCount == 0 ? "0" : lectureInfo.regCount);
            innerValue("limitStudentCount", lectureInfo.lectureLimitStudent);

            var lectureStudentRelList = selList.lectureStudentRelList;
            if (lectureStudentRelList.length == 0) {
                gfn_emptyView("V", comment.not_lecture_student_rel);
                return;
            }
            gfn_emptyView("H", "");
            var studentIds = new Array();
            for (var i=0; i<lectureStudentRelList.length; i++) {
                var studentId = lectureStudentRelList[i].studentId;
                studentIds.push(studentId);
            }
            $("#isAddStudentIds").val('');
            innerValue("isAddStudentIds", studentIds.join());

            dwr.util.addRows("dataList", lectureStudentRelList, [
                function (data) { return "<input type=\"hidden\" name=\"studentId[]\" class=\"form-control\" id='studentId_" + data.studentId + "' value='" + data.studentId + "'><span id='l_addedStudentName_" + data.studentId + "'>" + data.studentName + "</span>"},
                function (data) { return "<span>" + data.schoolName + "</span>"},
                function (data) { return "<div class=\"form-group row marginX draghandle\">\n" +
                    "                            <button type=\"button\" style=\"font-size: 25px\" class=\"fa fa-close\" aria-label=\"Close\" value='" + data.lectureRelId +"' onclick='removeStudent(this.value)'>\n" +
                    "                            </button>\n" +
                    "                        </div>"},
            ], {
                rowCreator:function(options) {
                    var row = document.createElement("tr");
                    var index = "tr_" + options.rowData.lectureRelId;
                    row.id = index;
                    return row;
                },
                escapeHtml:false});
        });
    }
    //팝업 콜 초기 값 세팅
    function popupInit() {
        schoolTypeSelectbox("l_schoolType", "");
        $("#sel_searchType").val("STUDENT_NAME");
        $("#search_value").val("");
        dwr.util.removeAllRows("dataList2");
        $('#resultTable tbody tr').empty();
        $("#pages2").hide();
        $("#searchTable tbody").css("height", "0px");
        gfn_emptyView2("V", comment.search_input_student_name);
    }
    //학생 팝업에서 학생 리스트 검색
    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        var schoolType = convert_school_value(getSelectboxValue("sel_schoolType"));
        var searchType = getSelectboxValue("sel_searchType");
        var searchValue = getInputTextValue("search_value");

        var check = new isCheck();
        if (check.input("search_value", comment.input_content) == false) return;

        if(val == "new") sPage = "1";

        gfn_emptyView2("H", "");
        $("#pages2").show();

        studentService.getStudentListByLectureRegSearchCount(schoolType, searchType, searchValue, function (cnt) {
            //paging.count2(sPage, cnt, '5', '5', comment.blank_list2);
            if (cnt == 0) {
                dwr.util.removeAllRows("dataList2");
                gfn_emptyView2("V", comment.blank_list2);
                return;
            }
            $("#searchTable tbody").css("height", "200px");

            var listNum = ((cnt-1)+1)-((sPage-1) * 5); //리스트 넘버링

            studentService.getStudentListByLectureRegSearch(schoolType, searchType, searchValue, function (selList) {
                dwr.util.removeAllRows("dataList2");
                if (selList.length == 0) return;
                dwr.util.addRows("dataList2", selList, [
                    function(data) { return "<input type=\"checkbox\" class=\"checkbox_t1\" name=\"chk\" id='check_"+ data.studentId + "'   value='"+ data.studentId +"' onclick='addStudent(this.value);'>" },
                    function(data) { return listNum--},
                    function(data) { return data.studentName},
                    function(data) { return data.studentPhoneNumber == null ? "-" : fn_tel_tag(data.studentPhoneNumber)},
                    function(data) { return data.schoolName},
                    function(data) { return data.studentGrade},
                    function(data) { return data.motherName},
                    function(data) { return fn_tel_tag(data.motherPhoneNumber)},
                ], {
                    rowCreator:function(options) {
                    var row = document.createElement("tr");
                    var index = "tr_" + options.rowData.studentId;
                    row.id = index;
                    return row;
                },
                escapeHtml:false});
            });
        });
    }
    //이미 등록 되어있는 학생 목록 삭제(x)이벤트
    function removeStudent(val) {
        var lectureRelId = val;
        var addCount = getInputTextValue("addCount");
        var regCount = getInputTextValue("regCount");
        var $tableBody = $("#duringStudentTable").find("tbody").find("tr");

        if (confirm(comment.isDelete)) {
            lectureService.deleteLectureStudentRel(lectureRelId);
            $("#tr_" + lectureRelId).remove();

            innerHTML("l_limitCount", --addCount);
            innerHTML("l_isAddCount", ++regCount);

            if ($tableBody.length == 1) {
                gfn_emptyView("V", comment.not_lecture_student_rel);
            }
        }
    }

    //입력해야할 학생 목록 삭제(x)이벤트
    function addRemoveStudent(val) {
        var addCount = $("#l_limitCount").html();
        var regCount = $("#l_isAddCount").html();

        if (confirm(comment.isDelete)) {
            $("#tr_" + val).remove();
            innerHTML("l_limitCount", --addCount);
            innerHTML("l_isAddCount", ++regCount);

            var $tableBody = $("#duringStudentTable").find("tbody").find("tr");
            if ($tableBody.length == 0) {
                gfn_emptyView("V", comment.not_lecture_student_rel);
            }
        }
    }
    //팝업창에서 학생 체크박스 선택시
    function addStudent(val) {
        var studentIds = new Array();
        $("input[name=add_check]").each(function () {
            studentIds.push($(this).val());
        });
        var joinStudentIds = studentIds.join();
        var splitJoinStudentIds =  joinStudentIds.split(",");


        if ($("#check_"+val).is(":checked") == true) {
            var studentId = val;
            var regCount = getInputTextValue("addCount");
            var limitStudent = getInputTextValue("limitStudentCount");
            var addedStudentIds = getInputTextValue("isAddStudentIds");
            var splitStudentId = addedStudentIds.split(",");
            //var addStudentIds = new Array();
            //인원수 체크
            if (Number(regCount) >= Number(limitStudent)) {
                alert(comment.excess_lecture_reg_student);
                $("input:checkbox[id='check_" + studentId + "']").prop("checked", false)
                return;
            } else {
                for ( var j in splitJoinStudentIds) {
                    if (studentId == splitJoinStudentIds[j]) {
                        alert("이미 추가된 학생압니다.\n다른 수강생을 선택하세요.");
                        $("input:checkbox[id='check_" + studentId + "']").prop("checked", false)
                        return;
                    }
                }
                for ( var i in splitStudentId ) {
                    if (studentId == splitStudentId[i]) {
                        alert("이미 수강생으로 등록된 학생압니다.\n다른 수강생을 선택하세요.");
                        $("input:checkbox[id='check_" + studentId + "']").prop("checked", false)
                        return;
                    }
                }
                var $tableBody = $("#searchTable").find("tbody"),
                    $trLast = $tableBody.find("#tr_" + val),
                    $trNew = $trLast.clone();

                $trNew.attr("id", "tr_add_" + val);
                $trNew.find("td").eq(0).css("display","none").find("input").attr("name", "add_check");
                $trNew.find("td").eq(0).css("display","none").find("input").attr("checked", true);
                $trNew.find("td").eq(1).css("display","none");

                var $resultTableBody = $("#resultTable tbody tr:last");
                $resultTableBody.after($trNew);

                innerValue("addCount", ++regCount);
            }
        }
    }
    //학생 선택 팝업창에서 선택버튼
    function selectStudent() {
        var addCount = getInputTextValue("addCount");
        var limitStudent = getInputTextValue("limitStudentCount");

        $("input[name=add_check]:checked").each(function() {
            var studentId = $(this).val();
            var $tr = $("#tr_add_" + studentId);
            var studentName = $tr.find("td").eq(2).html();
            var schoolName = $tr.find("td").eq(4).html();

            var $tableBody = $("#duringStudentTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
                $tr = $tableBody.find("tr");

            if ($tr.length == 0) {
                gfn_emptyView("H", "");

                var cellData = [
                    function (data) { return "<input type=\"hidden\" name=\"newAddStudentId[]\" class=\"form-control\" id='studentId_" + studentId + "' value='" + studentId + "'><span id='l_addedStudentName_" + studentId + "'>" + studentName + "</span>"},
                    function (data) { return "<span>" + schoolName + "</span>"},
                    function (data) { return "<div class=\"form-group row marginX draghandle\">\n" +
                        "                            <button type=\"button\" style=\"font-size: 25px\" class=\"fa fa-close\" aria-label=\"Close\" value='" + studentId +"' onclick='addRemoveStudent(this.value)'>\n" +
                        "                            </button>\n" +
                        "                        </div>"}
                ];
                dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                $("#duringStudentTable").find("tbody").find("tr:first").attr("id", "tr_" + studentId);

            } else {

                $trNew.attr("id", "tr_" + studentId);
                $trNew.find("td input").eq(0).attr("name", "newAddStudentId[]");
                $trNew.find("td input").eq(0).val(studentId).attr("id", "studentId_"+studentId);
                $trNew.find("td span").eq(0).attr("id", "l_addedStudentName_"+studentId).text(studentName);
                $trNew.find("td span").eq(1).text(schoolName);
                $trNew.find("td div").find("button").val(studentId);
                $trNew.find("td div").find("button").attr("onclick", "addRemoveStudent(this.value);");

                $trLast.after($trNew);
            }
        });
        var calcCount = limitStudent - addCount;
        innerHTML("l_isAddCount", calcCount == 0 ? "0" : calcCount);
        innerHTML("l_limitCount", addCount == 0 ? "0" : addCount);

        $('#close_btn').trigger('click');
    }
    //저장하기 버튼
    function save() {
        var studentIds = new Array();
        $("input[name='newAddStudentId[]']").each(function () {
            studentIds.push($(this).val());
        });
        console.log(studentIds);
        if (confirm(comment.isSave)) {
            $("#loadingbar").show();
            lectureService.saveLectureStudentRel(lecutreId, studentIds, function (bl) {
                if (bl == true) {
                    isReloadPage(true);
                }
            });
        }
        $("#loadingbar").hide();
    }

    $(function () {
        //추가버튼 시 학생검색 팝업
        $("#student_add").on('click', function () {
            var studentIds = new Array();
            $("input[name='studentId[]']").each(function () {
                studentIds.push($(this).val());
            });
            $("#isAddStudentIds").val('');
            innerValue("isAddStudentIds", studentIds.join());

            initPopup($("#StudentFindLayer"));
        });
    });

    var isChange = false;
    $(document).ready(function () {
        $("input, select, textarea").change(function () {
            isChange = true;
        });
    });

    function go_list() {
        if(isChange) {
            if (confirm(comment.is_change_confirm)) {
                goPage('lecture', 'lecture_list')
            }
        } else {
            goPage('lecture', 'lecture_list')
        }
    }
</script>

<body onload="init();">
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/lecture_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lecture_id%>">
    </form>
    <input type="hidden" id="isAddStudentIds">
    <div class="tb_t1">
        <table>
            <thead>
            <tr>
                <th>강의명</th>
                <td>
                    <span id="l_lectureName"></span>
                </td>
                <th>선생님</th>
                <td>
                    <span id="l_teacherName"></span>
                </td>
            </tr>
            <tr>
                <th>정원</th>
                <td>
                    <span id="l_limitStudent"></span>
                </td>
                <th>현재인원</th>
                <td>
                    <span id="l_regCount"></span>
                </td>
            </tr>
            <tr>
                <%--<th>강의실</th>--%>
                <%--<td>--%>
                <%--<span id="">201호</span>--%>
                <%--</td>--%>
                <th>수강료</th>
                <td >
                    <span id="l_lecturePrice"></span>
                </td>
            </tr>
        </table>
    </div>
</section>
<section class="content">
    <h3 class="title_t1">기존 수강중인 학생</h3>
    <div class="tb_t1">
        <input type="hidden" id="addCount">
        <input type="hidden" id="regCount">
        <input type="hidden" id="limitStudentCount">
        <table id="duringStudentTable">
            <thead>
            <tr>
                <th>이름</th>
                <th>학교</th>
                <th>변경</th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
        </table>
        <table>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
        <div class="tb_t1">
            <table>
                <td style="text-align:center;">현재인원 <span id="l_limitCount"></span>명 / <span id="l_isAddCount" style="color:#03a9f4;"></span>명 추가 가능</td>
                <td style="width:30px;"><button style="float:right;"  id="student_add" class="btn_pack blue s2" onclick="popupInit();">추가</button></td>
            </table>
        </div>
        <button class="btn_pack blue s2" onclick="save();">저장</button>
        <button class="btn_pack blue s2" onclick="go_list();">목록</button>
    </div>
</section>

<!--학생추가 레이어 시작-->
<div class="layer_popup_template apt_request_layer" id="StudentFindLayer" style="display: none;">
    <div class="layer-title" style="border-bottom: 0px ;">
        <button id="close_btn" type="button" class="fa fa-close btn-close"></button>
    </div>
    <section class="content">
        <div class="tb_t1">
            <input type="hidden" id="sPage" value="<%=sPage%>">
            <table>
                <thead>
                <tr>
                    <th>학교선택</th>
                    <td>
                      <span id="l_schoolType"></span>
                    </td>
                </tr>
                <tr>
                    <th>검색정보</th>
                    <td colspan="2">
                        <div class="form-group row marginX">
                                 <select id="sel_searchType" class="form-control" style="width: 15rem;">
                                    <option value="STUDENT_NAME">이름</option>
                                    <option value="PHONE_NUMBER">전화번호</option>
                                    <option value="MOTHER_NAME">학부모(모)이름</option>
                                    <option value="MOTHER_PHONE_NUMBER">학부모(모)전화번호</option>
                                </select>
                            <input type="text" id="search_value" class="form-control" onkeypress="javascript:if(event.keyCode == 13){fn_search('new'); return false;}">
                        </div>
                    </td>
                </tr>
            </table>
            <div class="bot_btns_t1">
                <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="tb_t1">
            <table id="searchTable" class="scrolltbody">
                <thead>
                <tr>
                    <th>선택</th>
                    <th>No.</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>학교명</th>
                    <th>학년</th>
                    <th>학부모(모) 이름</th>
                    <th>학부모(모) 전화번호</th>
                </tr>
                </thead>
                <tbody id="dataList2"></tbody>
            </table>
            <table>
                <tr>
                    <td id="emptys2" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
        </div>
    </section>
    <section class="content">
        선택된 학생
        <div class="tb_t1">
            <table id="resultTable" class="scrolltbody1">
                <thead>
                <tr>
                    <th style="width:10%;">이름</th>
                    <th style="width:19%;">전화번호</th>
                    <th style="width:12%;">학교명</th>
                    <th style="width:13%;">학년</th>
                    <th style="width:17%;">학부모(모) 이름</th>
                    <th style="width:16%;">학부모(모) 전화번호</th>
                </tr>
                </thead>
                <tbody id="dataList3">
                    <tr style="display:none;"></tr>
                </tbody>
            </table>
            <div class="bot_btns_t1" style="text-align: center;">
                <button class="btn_pack blue" type="button" onclick="selectStudent();">선택</button>
                <button class="btn_pack btn-close" type="button" onclick="javascript:$('#close_btn').trigger('click');">취소</button>
            </div>
        </div>
    </section>
</div>
<!--학생 추가 레이어 끝-->
<%@include file="/common/jsp/footer.jsp" %>
</body>

