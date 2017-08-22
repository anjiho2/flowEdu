<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script type="text/javascript">

function init() {
    fn_search("new");
    schoolSelectbox("student_grade","", "");
}

function fn_search(val) {

    var paging = new Paging();
    var sPage = $("#sPage").val();
    var title = $("#search_value").val();
    if(val == "new") {
        sPage = "1";
    }
    dwr.util.removeAllRows("dataList");

    studentService.getSudentListCount( function (cnt) {
        paging.count(sPage, cnt, '10', '5', comment.blank_list);

        studentService.getSudentList(sPage,'5',function (selList) {

            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {

                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        //var checkHTML = "<input type='checkbox' name='chk' id='chk' value='" + cmpList.studentId + "'/>";
                        var modifyHTML = "<input type='button'  name='modify' id='modify' value='수정' onclick='student_modify(" + cmpList.studentId + ");'/>";
                        var cellData = [
                            //function(data) {return checkHTML;},
                            function(data) {return cmpList.studentName;},
                            function(data) {return cmpList.studentGender;},
                            function(data) {return cmpList.studentBirthday;},
                            function(data) {return cmpList.studentPhoneNumber;},
                            function(data) {return cmpList.homeTelNumber;},
                            function(data) {return cmpList.studentEmail;},
                            function(data) {return convert_lecture_grade(cmpList.studentGrade);},
                            function(data) {return cmpList.schoolName;},
                            function(data) {return cmpList.studentMemo;},
                            function(data) {return cmpList.motherName;},
                            function(data) {return cmpList.motherPhoneNumber;},
                            function(data) {return cmpList.fatherName;},
                            function(data) {return cmpList.fatherPhoneNumber;},

                            function(data) {return modifyHTML;}
                        ];
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                    }
                }
            }
        })
    });
}

function save_student() {

    var check = new isCheck();
    /*
    if(check.input("student_name", comment.input_member_name)   == false) return;
    if($(":input:radio[name=student_name]:checked").val()==null) return;
    if(check.input("startDate", comment.input_member_name)   == false) return;
    if(check.input("student_phone1", comment.input_member_name)   == false) return;
    if(check.input("student_phone2", comment.input_member_name)   == false) return;
    if(check.input("student_phone3", comment.input_member_name)   == false) return;
    if(check.input("student_tel1", comment.input_member_name)   == false) return;
    if(check.input("student_tel2", comment.input_member_name)   == false) return;
    if(check.input("student_tel3", comment.input_member_name)   == false) return;
    if(check.input("student_email", comment.input_member_name)   == false) return;
    if(check.input("student_grade", comment.input_member_name)   == false) return;
    if(check.input("schoolname", comment.input_member_name)   == false) return;
    */


    var data = new FormData();
    $.each($('#attachFile')[0].files, function(i, file) {
        data.append('file-' + i, file);
    });
    var attachFile = fn_clearFilePath($('#attachFile').val());
    if (attachFile != "") { //학생사진 업로드시
        $.ajax({
            url: "<%=webRoot%>/file/upload.do",
            method : "post",
            dataType: "JSON",
            data: data,
            cache: false,
            processData: false,
            contentType: false,
            success: function(data) {
                var fileName = data.result.file_name;
                var fileUrl = data.result.file_url;

                var mother_phone3   = getInputTextValue("mother_phone3");
                var student_name    = getInputTextValue("student_name");
                var gender          = get_radio_value("student_gender");
                var startDate       = getInputTextValue("startDate");
                var student_phonenum= get_allphonenum("student_phone1","student_phone2","student_phone3");
                var student_telnum  = get_allphonenum("student_tel1","student_tel2","student_tel3");
                var student_email   = getInputTextValue("student_email");
                var student_grade   = getInputTextValue("sel_school");
                var schoolname      = getInputTextValue("schoolname");
                var student_memo    = getInputTextValue("student_memo");
                var mother_name     = getInputTextValue("mother_name");
                var father_name     = getInputTextValue("father_name");
                var mother_phonenum = get_allphonenum("mother_phone1","mother_phone2","mother_phone3");
                var father_phonenum = get_allphonenum("father_phone1","father_phone2","father_phone3");
                var school_type =  $(":input:radio[name=school_type]:checked").val();

                var data = {
                    studentPhotoFile:fileName, //파일명
                    studentPhotoUrl:fileUrl, //경로
                    studentName:student_name,
                    studentPassword:mother_phone3,
                    studentGender:gender,
                    studentBirthday:startDate,
                    studentPhoneNumber:student_phonenum,
                    homeTelNumber:student_telnum,
                    studentEmail:student_email,
                    studentGrade:student_grade,
                    schoolType:school_type,
                    schoolName:schoolname,
                    studentMemo:student_memo,
                    motherName:mother_name,
                    motherPhoneNumber:mother_phonenum,
                    fatherName:father_name,
                    fatherPhoneNumber:father_phonenum,
                };

                studentService.saveStudentInfo(data,function () {
                    alert("학생정보가 등록 되었습니다.");
                    location.reload();
                });
            }
        });
    } else { //학생사진 없을때
        var mother_phone3    = getInputTextValue("mother_phone3");
        var student_name    = getInputTextValue("student_name");
        var gender          = get_radio_value("student_gender");
        var startDate       = getInputTextValue("startDate");
        var student_phonenum= get_allphonenum("student_phone1","student_phone2","student_phone3");
        var student_telnum  = get_allphonenum("student_tel1","student_tel2","student_tel3");
        var student_email   = getInputTextValue("student_email");
        var student_grade   = getInputTextValue("sel_school");
        var schoolname      = getInputTextValue("schoolname");
        var student_memo    = getInputTextValue("student_memo");
        var mother_name     = getInputTextValue("mother_name");
        var father_name     = getInputTextValue("father_name");
        var mother_phonenum = get_allphonenum("mother_phone1","mother_phone2","mother_phone3");
        var father_phonenum = get_allphonenum("father_phone1","father_phone2","father_phone3");
        var school_type =  $(":input:radio[name=school_type]:checked").val();

        var data = {
            studentName:student_name,
            studentPassword:mother_phone3,
            studentGender:gender,
            studentBirthday:startDate,
            studentPhoneNumber:student_phonenum,
            homeTelNumber:student_telnum,
            studentEmail:student_email,
            studentGrade:student_grade,
            schoolType:school_type,
            schoolName:schoolname,
            studentMemo:student_memo,
            motherName:mother_name,
            motherPhoneNumber:mother_phonenum,
            fatherName:father_name,
            fatherPhoneNumber:father_phonenum,
        };
        studentService.saveStudentInfo(data,function () {
            alert("학생정보가 등록 되었습니다.");
            location.reload();
        });
    }

}
function school_radio(school_grade) {
    schoolSelectbox("student_grade","", school_grade);
}

function student_modify(student_id) { //수정페이지 이동
    innerValue("student_id", student_id);
    goPage('student', 'modify_student');
}


function school_search_popup() {
    var school_type =  $(":input:radio[name=school_type]:checked").val();

    if(school_type == null){
        alert("학교구분을 선택해 주세요.");
        return false;
    }
    var param = "?school_type="+school_type;
     gfn_winPop(750,200,"jsp/popup/school_search_popup.jsp",param);
}
</script>
<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="student_id" id="student_id">
    <input type="hidden" id="school"  value="">
    <input type="hidden" id="fileName" value="">
    <input type="hidden" id="fileUrl" value="">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">

    <h1>학생정보입력</h1>
    <table>
        <tr>
            <th>학생사진</th>
            <td>
                <input type="file" id="attachFile"  onchange="preViewImage(this, 'modify_preView', 'preview');">
            </td>
        </tr>
        <tr id="preview" style="display: none;">
            <td>
                <img id="modify_preView" src="" width="80px" height="80px">
            </td>
        </tr>
        <tr>
            <th>학생이름</th>
            <td>
                <input type="text" id="student_name">
            </td>
        </tr>
        <tr>
            <th>성별</th>
            <td>
                <input type="radio" name="student_gender" value="MALE" checked>남
                <input type="radio" name="student_gender" value="FEMAIE">여
            </td>
        </tr>
        <tr>
            <th>학생생일</th>
            <td>
                <input type="text" id="startDate" >
            </td>
        </tr>
        <tr>
            <th>핸드폰번호</th>
            <td>
                <input type="text" size="2"  id="student_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.student_phone2,3)">
                -
                <input type="text" size="5"  id="student_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.student_phone3,4)">
                -
                <input type="text" size="5"  id="student_phone3" maxlength="4">
            </td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td>
                <input type="text" size="2"  id="student_tel1" maxlength="3" onkeyup="js_tab_order(this,frm.student_tel2,3)">
                -
                <input type="text" size="5"  id="student_tel2" maxlength="4" onkeyup="js_tab_order(this,frm.student_tel3,4)">
                -
                <input type="text" size="5"   id="student_tel3" maxlength="4">
            </td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>
                <input type="text" id="student_email">
            </td>
        </tr>
        <tr>
            <th>학교구분</th>
            <td>
                <input type="radio" name="school_type" value="elem_list" onclick="school_radio(this.value);" checked>초등학교
                <input type="radio" name="school_type" value="midd_list" onclick="school_radio(this.value);">중학교
                <input type="radio" name="school_type" value="high_list" onclick="school_radio(this.value);">고등학교
            </td>
        </tr>
        <tr>
            <th>학교이름</th>
            <td>
                <input type="text" id="schoolname" onclick="school_search_popup();">
            </td>
        </tr>
        <tr>
            <th>학년</th>
            <td>
                <span id="student_grade"></span>
            </td>
        </tr>
        <tr>
            <th>메모</th>
            <td>
                <input type="textarea" id="student_memo" >
            </td>
        </tr>
        <tr>
            <th>학부모(모)이름</th>
            <td>
                <input type="text" id="mother_name" >
            </td>
        </tr>
        <tr>
            <th>학부모(모)전화번호</th>
            <td>
                <input type="text" size="2" id="mother_phone1"  maxlength="3" onkeyup="js_tab_order(this,frm.mother_phone2,3)">
                -
                <input type="text" size="5" id="mother_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.mother_phone3,4)">
                -
                <input type="text" size="5" id="mother_phone3" maxlength="4">
            </td>
        </tr>

        <tr>
            <th>학부모(부)이름</th>
            <td>
                <input type="text" id="father_name" >
            </td>
        </tr>
        <tr>
            <th>학부모(부)전화번호</th>
            <td>
                <input type="text" size="2" id="father_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.father_phone2,3)">
                -
                <input type="text" size="5" id="father_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.father_phone3,4)">
                -
                <input type="text" size="5" id="father_phone3" maxlength="4">
            </td>
        </tr>


    </table>
    <input type="button" value="등록" onclick="save_student();">


<h1>학생정보입력 list</h1>
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
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
        </colgroup>
        <thead>
        <tr>
            <!--<th>
                <input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');">
            </th>-->
            <th>학생이름</th>
            <th>성별</th>
            <th>학생생일</th>
            <th>학생폰번호</th>
            <th>학생전화번호</th>
            <th>이메일</th>
            <th>학년</th>
            <th>학교이름</th>
            <th>메모</th>
            <th>학부모(모)이름</th>
            <th>학부모(모)전화번호</th>
            <th>학부모(부)이름</th>
            <th>학부모(부)전화번호</th>
            <th>수정</th>
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
</form>
</body>
</html>


