<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 1;
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script>
    function student_modify(student_id) { //수정페이지 이동
        innerValue("student_id", student_id);
        goPage('student', 'modify_student');
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        var school_type = get_radio_value("school_type");
        //var school_type = "high_list";
        var student_name = getInputTextValue("student_name");

        if(val == "new") sPage = "1";
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");

        studentService.getSudentListCount(school_type, student_name, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            studentService.getSudentList(sPage, '10', school_type, student_name, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var modifyHTML = "<button class='btn_pack white' type='button' onclick='student_modify(" + cmpList.studentId + ");'>상세정보</button>";
                            var cellData = [
                                function(data) {return cmpList.studentName;},
                                function(data) {return cmpList.motherName;},
                                function(data) {return fn_tel_tag(cmpList.studentPhoneNumber);},
                                function(data) {return fn_tel_tag(cmpList.motherPhoneNumber);},
                                function(data) {return cmpList.schoolName;},
                                function(data) {return convert_lecture_grade(cmpList.studentGrade);},
                                function(data) {return modifyHTML;}
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }
            })
        });
    }

</script>
<body>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <h2>대시보드</h2>
    <%--<%@include file="/common/jsp/depth_menu.jsp" %>--%>
</div>
</section>
    <section class="content">
        <h3 class="title_t1">학생 검색</h3>
        <form name="frm" method="get">
            <input type="hidden" name="page_gbn" id="page_gbn">
            <input type="hidden" id="student_id" name="student_id">
            <input type="hidden"  id="sPage" value="<%=sPage%>">
        </form>
            <div class="form-group row">
                <div class="checkbox_t1">
                    <label><input type="radio" name="school_type" value="elem_list" checked><span>초등학교</span></label>
                    <label><input type="radio" name="school_type" value="midd_list" ><span>중학교</span></label>
                    <label><input type="radio" name="school_type" value="high_list" ><span>고등학교</span></label>
                    <label><input type="text" class="form-control"  id="student_name" placeholder="학생이름입력" onkeypress="javascript:if(event.keyCode == 13){fn_search('new'); return false;}" ></label>
                    <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
                </div>
            </div>

            <div class="tb_t1">
                <table>
                    <colsgroup>
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="110">
                    </colsgroup>
                    <tr>
                        <th>이름</th>
                        <th>학부모(모)이름</th>
                        <th>학생전화번호</th>
                        <th>학부모(모)전화번호</th>
                        <th>학교</th>
                        <th>학년</th>
                        <th>상세</th>
                    </tr>
                    <tbody id="dataList"></tbody>
                    <tr>
                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                    </tr>
                </table>
                <div class="form-group row"></div>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
            </div>
    </section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>
