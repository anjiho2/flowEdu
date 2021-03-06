<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int siderMenuDepth1 = 1;
    int siderMenuDepth2 = 2;
    int siderMenuDepth3 = 1;
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
        //var school_type = get_radio_value("school_type");
        //varR school_type = "high_list";
        var searchType = getSelectboxValue("sel_searchType");
        var searchValue = getInputTextValue("search_value");

        if(val == "new") sPage = "1";

        gfn_emptyView("H", "");

        dwr.util.removeAllRows("dataList");
        studentService.getSudentListCount(searchType, searchValue, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list2);

            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링

            studentService.getSudentList(sPage, '10', searchType, searchValue, function (selList) {
                if (selList.length > 0) {
                    dwr.util.removeAllRows("dataList");
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var studentNameHTML = "<a href='javascript:void(0);' class='font_color blue' onclick='student_modify(" + cmpList.studentId + ");'>"+cmpList.studentName +"</a>";

                            var cellData = [
                                function(data) {return listNum--;},
                                function(data) {return studentNameHTML;},
                                function(data) {return convert_student_status(cmpList.studentStatus)},
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
    <%--<%@include file="/common/jsp/depth_menu.jsp" %>--%>
    <div class="title-top">학생관리</div>
</div>
</section>
    <section class="content">
        <h3 class="title_t1">학생 검색</h3>
        <form name="frm" method="get">
            <input type="hidden" name="page_gbn" id="page_gbn">
            <input type="hidden" id="student_id" name="student_id">
            <input type="hidden"  id="sPage" value="<%=sPage%>">
        </form>

        <div class="cont-wrap">
            <div class="tb_t1 colTable searchInfo">
                <table>
                    <colsgroup>
                        <col width="10%">
                        <col width="90%">
                    </colsgroup>
                    <tr>
                        <th>검색정보</th>
                        <td>
                            <div class="form-group">
                                <div class="search-box clear">
                                    <select id="sel_searchType" class="form-control">
                                        <option value="NAME">이름</option>
                                        <option value="PHONE">전화번호</option>
                                        <option value="MOTHER_NAME">학부모 이름</option>
                                        <option value="MOTHER_PHONE">학부모 전화번호</option>
                                    </select>
                                    <div class="search-input-box">
                                        <label><input type="text" class="form-control"  id="search_value" placeholder="" onkeypress="javascript:if(event.keyCode == 13){fn_search('new'); return false;}" ></label>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>

                <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
            </div>

            <div class="tb_t1">
                <table>
                    <colsgroup>
                        <col width="5%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="5%" />
                        <col width="15%" />
                        <col width="15%">
                    </colsgroup>
                    <tr class="t_head">
                        <th>No.</th>
                        <th>이름</th>
                        <th>상태</th>
                        <th>전화번호</th>
                        <th>학교명</th>
                        <th>학년</th>
                        <th>학부모이름</th>
                        <th>학부모전화번호</th>
                    </tr>
                    <tbody id="dataList">
                        <%--<tr>--%>
                            <%--<td>141</td>--%>
                            <%--<td><a href="javascript:void(0);" class="font_color blue" onclick="student_modify(559);">강민재</a></td>--%>
                            <%--<td>재원생</td>--%>
                            <%--<td>-</td>--%>
                            <%--<td>수내초등학교</td>--%>
                            <%--<td>3</td>--%>
                            <%--<td>강민재</td>--%>
                            <%--<td>010-5053-1224</td>--%>
                        <%--</tr>--%>
                    </tbody>
                    <tr>
                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                    </tr>
                </table>
                <button class="btn_pack blue" onclick='goPage("student", "save_student")'>등록</button>
                <div class="form-group row"></div>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
            </div>
        </div>
    </section>
</div>
</body>
<%@include file="/common/jsp/footer.jsp" %>
