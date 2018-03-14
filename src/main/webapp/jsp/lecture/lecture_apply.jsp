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
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureManager.js'></script>
<script>
    var lecutreId = '<%=lectureId%>';

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

            var lectureStudentRelList = selList.lectureStudentRelList;
            if (lectureStudentRelList.length == 0) {
                gfn_emptyView("V", comment.not_lecture_student_rel);
                return;
            }

            var studentIds = new Array();
            for (var i=0; i<lectureStudentRelList.length; i++) {
                var studentId = lectureStudentRelList[i].studentId;
                studentIds.push(studentId);
            }
            $("#isAddStudentIds").val('');
            innerValue("isAddStudentIds", studentIds.join());

            dwr.util.addRows("dataList", lectureStudentRelList, [
                function (data) { return data.studentName},
                function (data) { return data.schoolName},
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

    function popupInit() {
        schoolTypeSelectbox("l_schoolType", "");
        dwr.util.removeAllRows("dataList2");
        $("#pages2").hide();
        gfn_emptyView2("V", comment.search_input_student_name);

    }

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
            var listNum = ((cnt-1)+1)-((sPage-1) * 5); //리스트 넘버링

            dwr.util.removeAllRows("dataList2");
            studentService.getStudentListByLectureRegSearch(sPage, 5, schoolType, searchType, searchValue, function (selList) {
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

    function removeStudent(val) {
        var lectureRelId = val;
        $("#tr_" + lectureRelId).remove();
    }

    //팝업창에서 학생 체크박스 선택시
    function addStudent(val) {
        var studentId = val;
        var addedStudentIds = getInputTextValue("isAddStudentIds");
        var splitStudentId = addedStudentIds.split(",");
        var addStudentIds = new Array();
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

        $trNew.find("td").eq(0).css("display","none").find("input").attr("name", "add_check");
        $trNew.find("td").eq(0).css("display","none").find("input").attr("checked", true);
        $trNew.find("td").eq(1).css("display","none");

        var $resultTableBody = $("#resultTable").find("tbody");
        $resultTableBody.after($trNew);


    }

    $(function () {
        $("#student_add").on('click', function () { //아이디찾기 팝업
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
        <table>
            <thead>
            <tr>
                <th>이름</th>
                <th>학교</th>
                <th>변경</th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
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
        <button class="btn_pack blue s2" >저장</button>
        <button class="btn_pack blue s2" onclick="go_list();">목록</button>
    </div>
</section>

<!--학생추가 레이어 시작-->
<div class="layer_popup_template apt_request_layer" id="StudentFindLayer" style="display: none;">
    <div class="layer-title" style="border-bottom: 0px ;">
        <button id="close_btn_pw" type="button" class="fa fa-close btn-close"></button>
    </div>
    <section class="content">
       <!-- <form name="frm" method="get">
            <input type="hidden"  id="sPage" value="<%=sPage%>">
        </form>-->
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
                <%--<input type="button" value="검색" class="btn_wrap blue" onclick="fn_search('new');">--%>
                <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="tb_t1">
            <table id="searchTable">
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
            <%--<%@ include file="/common/inc/com_pageNavi2.inc" %>--%>
            <%--<div class="bot_btns_t1" style="text-align: center;">--%>
                <%--<button class="btn_pack blue" type="button">선택</button>--%>
                <%--<button class="btn_pack btn-close" type="button" onclick="javascript:$('#close_btn').trigger('click');">취소</button>--%>
            <%--</div>--%>
            <!--<input type="button" class="btn_pack blue s2" value="선택" >
            <input type="button" class="btn_pack blue s2" value="취소">-->
        </div>
    </section>
    <section class="content">
        선택된 학생
        <div class="tb_t1">
            <table id="resultTable">
                <thead>
                <tr>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>학교명</th>
                    <th>학년</th>
                    <th>학부모(모) 이름</th>
                    <th>학부모(모) 전화번호</th>
                </tr>
                </thead>
                <tbody id="dataList3" style="overflow-y: scroll;"></tbody>
            </table>
            <div class="bot_btns_t1" style="text-align: center;">
                <button class="btn_pack blue" type="button">선택</button>
                <button class="btn_pack btn-close" type="button" onclick="javascript:$('#close_btn').trigger('click');">취소</button>
            </div>
            <!--<input type="button" class="btn_pack blue s2" value="선택" >
            <input type="button" class="btn_pack blue s2" value="취소">-->
        </div>
    </section>
</div>
<!--학생 추가 레이어 끝-->
<%@include file="/common/jsp/footer.jsp" %>
</body>

