<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int siderMenuDepth1 = 0;
    int siderMenuDepth2 = 0;
    int siderMenuDepth3 = 0;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/studentService.js'></script>
<script>
    function student_modify(student_id) { //수정페이지 이동
        innerValue("student_id", student_id);
        goPage('student', 'modify_student');
    }

    function init() {
        gfn_emptyView("V", comment.search_input_student_name);
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
            paging.count(sPage, cnt, '10', '10', comment.blank_list2);

            studentService.getSudentList(sPage, '10', school_type, student_name, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var studentNameHTML = "<a href='javascript:void(0);' class='font_color blue' onclick='student_modify(" + cmpList.studentId + ");'>"+cmpList.studentName +"</a>";

                            var cellData = [
                                function(data) {return cnt--;},
                                function(data) {return studentNameHTML;},
                                function(data) {return fn_tel_tag(cmpList.studentPhoneNumber) == "" ? "-" : fn_tel_tag(cmpList.studentPhoneNumber)},
                                function(data) {return cmpList.schoolName == "" ? "-" : cmpList.schoolName},
                                function(data) {return cmpList.studentGrade;},
                                function(data) {return cmpList.motherName == "" ? "-" : cmpList.motherName},
                                function(data) {return fn_tel_tag(cmpList.motherPhoneNumber) == "" ? "-" : fn_tel_tag(cmpList.motherPhoneNumber)},
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }
            })
        });
    }

</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <h2>대시보드</h2>
    <%--<%@include file="/common/jsp/depth_menu.jsp" %>--%>
</div>
</section>
    <section class="content">

        <%--<h3 class="title_t1">학생 검색</h3>--%>
        <form name="frm" method="get">
            <input type="hidden" name="page_gbn" id="page_gbn">
            <input type="hidden"  id="sPage" value="<%=sPage%>">
        </form>
            <%--<div class="form-group row">--%>
                <%--<div class="checkbox_t1">--%>
                    <%--<label><input type="radio" name="school_type" value="elem_list" checked><span>초등학교</span></label>--%>
                    <%--<label><input type="radio" name="school_type" value="midd_list" ><span>중학교</span></label>--%>
                    <%--<label><input type="radio" name="school_type" value="high_list" ><span>고등학교</span></label>--%>
                    <%--<label><input type="text" class="form-control"  id="student_name" placeholder="학생이름입력" onkeypress="javascript:if(event.keyCode == 13){fn_search('new'); return false;}" ></label>--%>
                    <%--<button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="form-group row">--%>
                <%--<div class="checkbox_t1">--%>
                    <%--<label><input type="radio" name="school_type" value="elem_list" checked><span>초등학교</span></label>--%>
                    <%--<label><input type="radio" name="school_type" value="midd_list" ><span>중학교</span></label>--%>
                    <%--<label><input type="radio" name="school_type" value="high_list" ><span>고등학교</span></label>--%>
                    <%--<label><input type="text" class="form-control"  id="student_name" placeholder="학생이름입력" onkeypress="javascript:if(event.keyCode == 13){fn_search('new'); return false;}" ></label>--%>
                    <%--<button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="tb_t1">--%>
                <%--<table>--%>
                    <%--<colsgroup>--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                        <%--<col width="110">--%>
                    <%--</colsgroup>--%>
                    <%--<tr>--%>
                        <%--<th>No.</th>--%>
                        <%--<th>이름</th>--%>
                        <%--<th>전화번호</th>--%>
                        <%--<th>학교명</th>--%>
                        <%--<th>학년</th>--%>
                        <%--<th>학부모(모)이름</th>--%>
                        <%--<th>학부모(모)전화번호</th>--%>
                    <%--</tr>--%>
                    <%--<tbody id="dataList"></tbody>--%>
                    <%--<tr>--%>
                        <%--<td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>--%>
                    <%--</tr>--%>
                <%--</table>--%>
                <%--<button class="btn_pack blue" onclick='goPage("student", "save_student")'>학생정보입력</button>--%>
                <%--<div class="form-group row"></div>--%>
                <%--<%@ include file="/common/inc/com_pageNavi.inc" %>--%>
            <%--</div>--%>
    <%--</section>--%>

</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>

