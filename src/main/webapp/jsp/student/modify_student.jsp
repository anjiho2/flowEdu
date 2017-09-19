<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<%
    int depth2 = 1;
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script>
    function init() {
        schoolSelectbox("student_grade","", "");
        studentList();
        student_memo_list();
    }

    function studentList() {
        var student_id        = getInputTextValue("student_id");
        studentService.getStudentInfo(student_id, function (selList) {
                    var file_url = 'C:/dev/download/'+selList.studentPhotoUrl+"/"+selList.studentPhotoFile;
                    $("#modify_preView").attr("src", file_url);
                    if(file_url != null) gfn_display("preview", true);

                    innerValue("student_name", selList.studentName);
                    innerValue("startDate", selList.studentBirthday);
                    $('input:radio[name=student_gender]:input[value=' + selList.studentGender + ']').attr("checked", true);
                    $('input:radio[name=school_type]:input[value=' + selList.schoolType + ']').attr("checked", true);
                    innerValue("sel_school", selList.studentGrade);
                    fnSetPhoneNo(student_phone1, student_phone2, student_phone3, selList.studentPhoneNumber);
                    fnSetPhoneNo(student_tel1,   student_tel2,   student_tel3,   selList.homeTelNumber);
                    fnSetPhoneNo(mother_phone1,  mother_phone2,  mother_phone3,  selList.motherPhoneNumber);
                    fnSetPhoneNo(father_phone1,  father_phone2,  father_phone3,  selList.fatherPhoneNumber);
                    innerValue("student_email", selList.studentEmail);
                    innerValue("student_grade", selList.memberAddress);
                    innerValue("schoolname", selList.schoolName);
                    innerValue("student_memo", selList.studentMemo);
                    innerValue("mother_name", selList.motherName);
                    innerValue("father_name", selList.fatherName);
        });
    }

    //수정
    function modify_student() {
        var check = new isCheck();
        var student_id   = getInputTextValue("student_id");
        var data = new FormData();

      /*  if(check.input("student_name", comment.input_member_name)   == false) return;
        if($(":input:radio[name=student_name]:checked").val()==null) return;
        if(check.input("startDate", comment.input_member_startDate)   == false) return;
        if(check.input("student_grade", comment.input_student_grade)   == false) return;
        if(check.input("mother_name", comment.input_mother_name)   == false) return;
        if(check.input("mother_phone1", comment.input_mother_tel1)   == false) return;
        if(check.input("mother_phone2", comment.input_mother_tel2)   == false) return;
        if(check.input("mother_phone3", comment.input_mother_tel3)   == false) return;*/

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
                    var student_phonenum = get_allphonenum("student_phone1","student_phone2","student_phone3");
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
                        studentId:student_id,
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
                    studentService.modifyStudentInfo(data,function () {
                        alert("학생정보가 수정 되었습니다.");
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
                studentPhotoFile:"", //파일명
                studentPhotoUrl:"", //경로
                studentId:student_id,
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
            studentService.modifyStudentInfo(data,function () {
                alert("학생정보가 수정 되었습니다.");
                location.reload();
            });
        }
    }

    function school_radio(school_grade) {
        schoolSelectbox("student_grade","", school_grade);
    }

    function school_search_popup() { //학교검색
        var school_type =  $(":input:radio[name=school_type]:checked").val();

        if(school_type == null){
            alert("학교구분을 선택해 주세요.");
            return false;
        }
        var param = "?school_type="+school_type;
        gfn_winPop(550,400,"jsp/popup/school_search_popup.jsp",param);
    }

    // 처리하기 버튼
    function changeProccessYn(studentMemoId) {
        if (confirm("처리하시겠습니까?")) {
            studentService.modifyMemoProcessYn(studentMemoId, true);
            isReloadPage(true)
        }
    }
    //상담리스트
    function student_memo_list() {
        var student_id = getInputTextValue("student_id");
        studentService.getStudentMemoLastThree(student_id, function (memoList) {
            if (memoList.length < 0) return;
            dwr.util.addRows("consultList", memoList, [
                function(data) {return data.memoContent},
                function(data) {return data.memberName;},
                function(data) {return convert_memo_type(data.memoType);},
                function(data) {return getDateTimeSplitComma(data.createDate);},
                function(data) {return data.processYn == false ? "<button class='btn_pack white' type='button' id="+data.studentMemoId+" onclick='changeProccessYn(this.id);'>처리하기</button>" : "처리완료";}
            ], {escapeHtml:false} );
        });
    }
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/student_depth_menu.jsp" %>
</div>
</section>
<section class="content">
    <h3 class="title_t1">학생정보/수정</h3>
    <form name="frm" id="frm" method="get" class="form_st1">
        <input type="hidden" id="school"  value="">
        <input type="hidden" id="fileName"  value="">
        <input type="hidden" id="fileUrl"  value="">
        <input type="hidden" id="student_id" name="student_id" value="<%=student_id%>">
        <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <div class="form-group row">
            <label>학생사진</label>
            <div>
                <label class="custom-file">
                    <input type="file" id="attachFile"  onchange="preViewImage(this, 'modify_preView', 'preview');" class="custom-file-input" required>
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
            <button class="btn_pack blue s2" type="button"  onclick="modify_student();">수정</button>
        </div>
    </form>
</section>
<section class="content">
    <h3 class="title_t1">최근 상담 3건</h3>
        <div class="tb_t1">
            <table>
                <colsgroup>
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="110">
                </colsgroup>
                <tr>
                    <th>상담내용</th>
                    <th>상담자</th>
                    <th>상담구분</th>
                    <th>상담날짜</th>
                    <th>처리여부</th>
                </tr>
                <tbody id="consultList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
        </div>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>
