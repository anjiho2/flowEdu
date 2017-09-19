<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script type="text/javascript">

    function init() {
        schoolSelectbox("student_grade","", "");
    }
    /*
     function fn_search(val) {
     var paging = new Paging();
     var sPage = $("#sPage").val();
     if(val == "new") sPage = "1";

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
     function(data) {return genderTrans(cmpList.studentGender);},
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
     */
    function save_student() { //저장

        var check = new isCheck();

        /*  if(check.input("student_name", comment.input_member_name)   == false) return;
         if($(":input:radio[name=student_name]:checked").val()==null) return;
         if(check.input("startDate", comment.input_member_startDate)   == false) return;
         if(check.input("student_grade", comment.input_student_grade)   == false) return;
         if(check.input("mother_name", comment.input_mother_name)   == false) return;
         if(check.input("mother_phone1", comment.input_mother_tel1)   == false) return;
         if(check.input("mother_phone2", comment.input_mother_tel2)   == false) return;
         if(check.input("mother_phone3", comment.input_mother_tel3)   == false) return;*/

        var data = new FormData();
        $.each($('#attachFile')[0].files, function(i, file) {
            data.append('file-' + i, file);
        });
        var attachFile = fn_clearFilePath($('#attachFile').val());
        alert(attachFile);

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

    function student_consult(student_id) {
        innerValue("student_id", student_id);
        goPage('student', 'consult_student');
    }


    function school_search_popup() {//학교검색
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
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/depth_menu.jsp" %>--%>
    </div>
    </section>
    <section class="content">
        <h3 class="title_t1">학생정보입력</h3>
        <form name="frm" id="frm" method="get" class="form_st1">
            <input type="hidden" name="student_id" id="student_id">
            <input type="hidden" id="school"  value="">
            <input type="hidden" id="fileName" value="">
            <input type="hidden" id="fileUrl" value="">
            <input type="hidden" name="page_gbn" id="page_gbn">
            <div class="form-group row">
                <label>학생사진</label>
                <div>
                    <label class="custom-file">
                        <input type="file" id="attachFile"  onchange="preViewImage(this, 'modify_preView', 'preview');" class="custom-file-input" required>
                        <%--<input type="file" id="attachFile"  onchange="preViewImage(this, 'modify_preView', 'preview');" >--%>
                        <span class="custom-file-control"></span>
                    </label>
                </div>
            </div>
            <div class="form-group row" id="preview" style="display: none;">
                <label>학생사진미리보기</label>
                <div>
                    <label class="custom-file">
                        <img id="modify_preView" src="" width="100px" height="100px">
                    </label>
                </div>
            </div>
            <div class="form-group row">
                <label>학생이름<b>*</b></label>
                <div><input type="text" class="form-control" id="student_name" style="width:150px;"></div>
            </div>
            <div class="form-outer-group">
                <div class="form-group row">
                    <label>성별<b>*</b></label>
                    <div>
                        <div class="checkbox_t1">
                            <label><input type="radio" name="student_gender" value="MALE" checked><span>남자</span></label>
                            <label><input type="radio" name="student_gender" value="FEMALE"><span>여자</span></label>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label>생일<b>*</b></label>
                    <div><input type="text" id="startDate" class="form-control date-picker" style="width:200px;"></div>
                </div>
            </div>
            <div class="form-outer-group">
                <div class="form-group row">
                    <label>핸드폰번호</label>
                    <div class="inputs">
                        <input type="text" size="2" id="student_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.student_phone2,3)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="student_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.student_phone3,4)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="student_phone3" class="form-control" maxlength="4">
                    </div>
                </div>
                <div class="form-group row">
                    <label>집전화번호</label>
                    <div class="inputs">
                        <input type="text" size="2" id="student_tel1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.student_tel2,3)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="student_tel2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.student_tel3,4)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="student_tel3" class="form-control" maxlength="4">
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label>이메일</label>
                <div><input type="email" class="form-control datepicker" id="student_email" style="width:422px;"></div>
            </div>
            <div class="form-outer-group">
                <div class="form-group row">
                    <label>학교구분</label>
                    <div class="checkbox_t1">
                        <label><input type="radio" name="school_type" class="form-control" value="elem_list"  onclick="school_radio(this.value);" checked><span>초등학교</span></label>
                        <label><input type="radio" name="school_type" class="form-control" value="midd_list"  onclick="school_radio(this.value);"><span>중학교</span></label>
                        <label><input type="radio" name="school_type" class="form-control" value="high_list"  onclick="school_radio(this.value);"><span>고등학교</span></label>
                    </div>
                </div>
                <div class="form-group row">
                    <label>학교이름</label>
                    <div><input type="text" class="form-control" id="schoolname" onclick="school_search_popup();"></div>
                </div>
                <div class="form-group row">
                    <label>학년</label>
                    <div>
                        <span id="student_grade"></span>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label>메모</label>
                <div><textarea class="form-control"  id="student_memo" rows="5"></textarea></div>
            </div>
            <div class="form-outer-group">
                <div class="form-group row">
                    <label>학부모(모)이름<b>*</b></label>
                    <div><input type="text" class="form-control" id="mother_name"></div>
                </div>
                <div class="form-group row">
                    <label>학부모(모)전화번호<b>*</b></label>
                    <div class="inputs">
                        <input type="text" size="2" id="mother_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.mother_phone2,3)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="mother_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.mother_phone3,4)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="mother_phone3" class="form-control" maxlength="4" >
                    </div>
                </div>
            </div>
            <div class="form-outer-group">
                <div class="form-group row">
                    <label>학부모(부)이름</label>
                    <div><input type="text" class="form-control" id="father_name"></div>
                </div>
                <div class="form-group row">
                    <label>학부모(부)전화번호</label>
                    <div class="inputs">
                        <input type="text" size="2" id="father_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.father_phone2,3)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="father_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.father_phone3,4)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="father_phone3" class="form-control" maxlength="4">
                    </div>
                </div>
            </div>
            <div class="bot_btns">
                <button class="btn_pack blue s2" type="button"  onclick="save_student();">저장</button>
            </div>
        </form>
    </section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>