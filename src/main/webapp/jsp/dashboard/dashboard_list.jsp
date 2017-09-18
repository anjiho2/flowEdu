<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth2 = 0;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<!--
<style>
    body {margin: 0;}
    #fixed-menu {width: 100%;background-color: #ffffff;position: fixed;  top: 0px;left: 0px;}
    #main-content {width: 100%;margin-top: 120px;}
    ul{text-align:center;}
    #fixed-menu li {display: inline-block;margin-right: 40px;cursor: pointer;}
    ul li:last-child{margin-right: 0; }
    nav{margin-top: 20px;padding: 10px 0;border-top: 1px solid #969696;border-bottom: 1px solid #969696;}
    img {max-width: 100%;}
</style>
-->
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
        var student_name = getInputTextValue("student_name");

        if(val == "new") sPage = "1";
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");

        studentService.getSudentListCount(school_type, student_name, function (cnt) {
            paging.count(sPage, cnt, '10', '5', comment.blank_list);
            studentService.getSudentList(sPage,'5', school_type, student_name, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var modifyHTML = "<input type='button'  name='modify' id='modify' value='상세' onclick='student_modify(" + cmpList.studentId + ");'/>";
                            var cellData = [
                                function(data) {return cmpList.studentName;},
                                function(data) {return cmpList.motherName;},
                                function(data) {return cmpList.studentPhoneNumber;},
                                function(data) {return cmpList.motherPhoneNumber;},
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
    <section class="content">
        <h3 class="title_t1">학생 검색</h3>
        <form name="frm" method="get">
            <input type="hidden" name="page_gbn" id="page_gbn">
            <input type="hidden" id="student_id" name="student_id">
            <tr>
                <td>
                    <input type="radio" name="school_type" value="elem_list" onclick="school_radio(this.value);" checked>초등학교
                    <input type="radio" name="school_type" value="midd_list" onclick="school_radio(this.value);">중학교
                    <input type="radio" name="school_type" value="high_list" onclick="school_radio(this.value);">고등학교
                </td>
                <td>
                    <input type="text" id="student_name" placeholder="학생이름입력" onkeypress="javascript:if(event.keyCode == 13){fn_search('new'); return false;}" >
                    <input type="button" value="검색" onclick="fn_search('new');">
                </td>
            </tr>
            <div class="tb_t1" id="memberList">
                <table>
                    <colsgroup>
                        <!-- <col width="2%" />-->
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
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
                    <!--<input type="button" value="삭제" onclick="Delete();">-->
                </table>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
            </div>

            <%----%>
            <%----%>
            <%----%>
            <%--<div class="form-group row">--%>
                <%--<label>학생사진</label>--%>
                <%--<div>--%>
                    <%--<label class="custom-file">--%>
                        <%--<input type="file" id="file" class="custom-file-input" required>--%>
                        <%--<span class="custom-file-control"></span>--%>
                    <%--</label>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="form-group row">--%>
                <%--<label for="">학생이름<b>*</b></label>--%>
                <%--<div><input type="text" class="form-control" id=""></div>--%>
            <%--</div>--%>
            <%--<div class="form-outer-group">--%>
                <%--<div class="form-group row">--%>
                    <%--<label for="">성별<b>*</b></label>--%>
                    <%--<div>--%>
                        <%--<div class="checkbox_t1">--%>
                            <%--<label><input type="radio" name="gender" value="1" checked><span>남자</span></label>--%>
                            <%--<label><input type="radio" name="gender" value="2"><span>여자</span></label>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group row">--%>
                    <%--<label for="">생일<b>*</b></label>--%>
                    <%--<div><input type="text" class="form-control date-picker"></div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="form-outer-group">--%>
                <%--<div class="form-group row">--%>
                    <%--<label for="">핸드폰번호</label>--%>
                    <%--<div class="inputs">--%>
                        <%--<input type="text" size="2" id="student_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.student_phone2,3)">&nbsp;-&nbsp;--%>
                        <%--<input type="text" size="5" id="student_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.student_phone3,4)">&nbsp;-&nbsp;--%>
                        <%--<input type="text" size="5" id="student_phone3" class="form-control" maxlength="4">--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group row">--%>
                    <%--<label for="">집전화번호</label>--%>
                    <%--<div class="inputs">--%>
                        <%--<input type="text" size="2" id="student_tel1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.student_tel2,3)">&nbsp;-&nbsp;--%>
                        <%--<input type="text" size="5" id="student_tel2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.student_tel3,4)">&nbsp;-&nbsp;--%>
                        <%--<input type="text" size="5" id="student_tel3" class="form-control" maxlength="4">--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="form-group row">--%>
                <%--<label for="">이메일</label>--%>
                <%--<div><input type="email" class="form-control datepicker" id="student_email"></div>--%>
            <%--</div>--%>
            <%--<div class="form-outer-group">--%>
                <%--<div class="form-group row">--%>
                    <%--<label>학교구분</label>--%>
                    <%--<div class="checkbox_t1">--%>
                        <%--<label><input type="radio" name="school_type" class="form-control" value="elem_list" checked><span>초등학교</span></label>--%>
                        <%--<label><input type="radio" name="school_type" class="form-control" value="midd_list"><span>중학교</span></label>--%>
                        <%--<label><input type="radio" name="school_type" class="form-control" value="high_list"><span>고등학교</span></label>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group row">--%>
                    <%--<label>학교이름</label>--%>
                    <%--<div><input type="text" class="form-control" id=""></div>--%>
                <%--</div>--%>
                <%--<div class="form-group row">--%>
                    <%--<label>학년</label>--%>
                    <%--<div>--%>
                        <%--<select class="form-control">--%>
                            <%--<% for(int i = 1 ; i < 7; i++) {%>--%>
                            <%--<option value="<%=i%>"><%=i%>학년</option>--%>
                            <%--<% } %>--%>
                        <%--</select>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="form-group row">--%>
                <%--<label>메모</label>--%>
                <%--<div><textarea class="form-control"  rows="5"></textarea></div>--%>
            <%--</div>--%>
            <%--<div class="form-outer-group">--%>
                <%--<div class="form-group row">--%>
                    <%--<label for="">학부모(모)이름<b>*</b></label>--%>
                    <%--<div><input type="text" class="form-control" id=""></div>--%>
                <%--</div>--%>
                <%--<div class="form-group row">--%>
                    <%--<label for="">학부모(모)전화번호<b>*</b></label>--%>
                    <%--<div class="inputs">--%>
                        <%--<input type="text" size="2" id="" class="form-control" maxlength="3">&nbsp;-&nbsp;--%>
                        <%--<input type="text" size="5" id="" class="form-control" maxlength="4">&nbsp;-&nbsp;--%>
                        <%--<input type="text" size="5" id="" class="form-control" maxlength="4">--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="form-outer-group">--%>
                <%--<div class="form-group row">--%>
                    <%--<label for="">학부모(부)이름</label>--%>
                    <%--<div><input type="text" class="form-control" id=""></div>--%>
                <%--</div>--%>
                <%--<div class="form-group row">--%>
                    <%--<label for="">학부모(부)전화번호</label>--%>
                    <%--<div class="inputs">--%>
                        <%--<input type="text" size="2" id="" class="form-control" maxlength="3">&nbsp;-&nbsp;--%>
                        <%--<input type="text" size="5" id="" class="form-control" maxlength="4">&nbsp;-&nbsp;--%>
                        <%--<input type="text" size="5" id="" class="form-control" maxlength="4">--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="bot_btns">--%>
                <%--<button class="btn_pack blue s2">저장</button>--%>
            <%--</div>--%>
            <%----%>
        </form>
    </section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>





<%--<body>--%>
<%--<form name="frm" method="get">--%>
    <%--<input type="hidden" name="page_gbn" id="page_gbn">--%>
    <%--<input type="hidden" id="student_id" name="student_id">--%>
    <%--<div id="fixed-menu"><!--상담-->--%>
        <%--<nav>--%>
            <%--<ul>--%>
                <%--<li onclick="goPage('student', 'save_student')">학생관리</li>--%>
                <%--<li onclick="goPage('academy', 'save_academy')">학원정보</li>--%>
                <%--<li onclick="goPage('member', 'save_member')">운영자/선생님정보</li>--%>
                <%--<li onclick="goPage('lecture', 'lecture_info')">강의관리</li>--%>
                <%--<li onclick="goPage('template', 'formType1')">작업 페이지 확인</li>--%>
                <%--<li><input type="button" id="logoutBtn" value="로그아웃" onclick="goLogout();"></li>--%>
                <%--&lt;%&ndash;<li><a href="javascript:void(0);" onclick="goPage('member','login_member_modify')"><%=memberName%></a>님 반갑습니다.</li>&ndash;%&gt;--%>
            <%--</ul>--%>
        <%--</nav>--%>
    <%--</div>--%>
    <%--<div id="main-content"><!--content-->--%>
            <%--<table>--%>
                <%--<h1>학생검색</h1>--%>
                <%--<tr>--%>
                    <%--<td>--%>
                        <%--<input type="radio" name="school_type" value="elem_list" onclick="school_radio(this.value);" checked>초등학교--%>
                        <%--<input type="radio" name="school_type" value="midd_list" onclick="school_radio(this.value);">중학교--%>
                        <%--<input type="radio" name="school_type" value="high_list" onclick="school_radio(this.value);">고등학교--%>
                    <%--</td>--%>
                    <%--<td>--%>
                        <%--<input type="text" id="student_name" placeholder="학생이름입력" onkeypress="javascript:if(event.keyCode == 13){fn_search('new'); return false;}" >--%>
                        <%--<input type="button" value="검색" onclick="fn_search('new');">--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</table>--%>
            <%--<br>--%>
            <%--<div id="memberList">--%>
                <%--<table class="table_list" border="1">--%>
                    <%--<colgroup>--%>
                        <%--<!-- <col width="2%" />-->--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                        <%--<col width="*" />--%>
                    <%--</colgroup>--%>
                    <%--<thead>--%>
                    <%--<tr>--%>
                        <%--<th>이름</th>--%>
                        <%--<th>학부모(모)이름</th>--%>
                        <%--<th>학생전화번호</th>--%>
                        <%--<th>학부모(모)전화번호</th>--%>
                        <%--<th>학교</th>--%>
                        <%--<th>학년</th>--%>
                        <%--<th>상세</th>--%>
                    <%--</tr>--%>
                    <%--</thead>--%>
                    <%--<tbody id="dataList"></tbody>--%>
                    <%--<tr>--%>
                        <%--<td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>--%>
                    <%--</tr>--%>
                    <%--<!--<input type="button" value="삭제" onclick="Delete();">-->--%>
                <%--</table>--%>
                <%--<%@ include file="/common/inc/com_pageNavi.inc" %>--%>
            <%--</div>--%>
    <%--</div>--%>
<%--</form>--%>
<%--</body>--%>
<%--</html>--%>
