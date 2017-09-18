<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
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
<form name="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" id="student_id" name="student_id">
    <div id="fixed-menu"><!--상담-->
        <nav>
            <ul>
                <li onclick="goPage('student', 'save_student')">학생관리</li>
                <li onclick="goPage('academy', 'save_academy')">학원정보</li>
                <li onclick="goPage('member', 'save_member')">운영자/선생님정보</li>
                <li onclick="goPage('lecture', 'lecture_info')">강의관리</li>
                <li onclick="goPage('template', 'dashboard')">강의관리</li>
                <li><input type="button" id="logoutBtn" value="로그아웃" onclick="goLogout();"></li>
                <li><a href="javascript:void(0);" onclick="goPage('member','login_member_modify')"><%=memberName%></a>님 반갑습니다.</li>
            </ul>
        </nav>
    </div>
    <div id="main-content"><!--content-->
            <table>
                <h1>학생검색</h1>
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
            </table>
            <br>
            <div id="memberList">
                <table class="table_list" border="1">
                    <colgroup>
                        <!-- <col width="2%" />-->
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                        <col width="*" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th>이름</th>
                        <th>학부모(모)이름</th>
                        <th>학생전화번호</th>
                        <th>학부모(모)전화번호</th>
                        <th>학교</th>
                        <th>학년</th>
                        <th>상세</th>
                    </tr>
                    </thead>
                    <tbody id="dataList"></tbody>
                    <tr>
                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                    </tr>
                    <!--<input type="button" value="삭제" onclick="Delete();">-->
                </table>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
            </div>
    </div>
</form>
</body>
</html>
