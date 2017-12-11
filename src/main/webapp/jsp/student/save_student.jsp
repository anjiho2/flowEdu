<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 2;
    String newRegPhoneNumber = Util.isNullValue(request.getParameter("phone_number"), "");
    Boolean consultYn = Boolean.valueOf(Util.isNullValue(request.getParameter("consult_yn"), ""));
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script type="text/javascript" charset="UTF-8">

    function init() {
        // 신규 상담에서 학생 등록 할때
        var newRegPhoneNumber = '<%=newRegPhoneNumber%>';
        if (newRegPhoneNumber != "") {
            fnSetPhoneNo("mother_phone1", "mother_phone2", "mother_phone3", newRegPhoneNumber);
            $("#mother_phone1").attr("disabled", true);
            $("#mother_phone2").attr("disabled", true);
            $("#mother_phone3").attr("disabled", true);
        }
        schoolSelectbox("student_grade","", "");
    }

    function save_student() { //저장
        var check = new isCheck();

        /* if(check.input("student_name", comment.input_student_name)   == false) return;
         if(check.input("startDate", comment.input_member_startDate)   == false) return;
         if(check.input("sel_school", comment.input_student_grade)   == false) return;
         if(check.input("mother_name", comment.input_mother_name)   == false) return;
         if(check.input("mother_phone1", comment.input_mother_tel1)   == false) return;
         if(check.input("mother_phone2", comment.input_mother_tel2)   == false) return;
         if(check.input("mother_phone3", comment.input_mother_tel3)   == false) return;*/

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
                    var errorCode = data.result.error_code;
                    if (errorCode == "903") {
                        alert(comment.file_name_not_allow_korean);
                        return;
                    } else if (errorCode == "904") {
                        alert(comment.file_extension_not_allow);
                        return;
                    } else if (errorCode == "905") {
                        alert(comment.file_size_not_allow_300kb);
                        return;
                    }
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
                    var etc_phonenum = get_allphonenum("etc_phone1","etc_phone2","etc_phone3");
                    var etc_name     = getInputTextValue("etc_name");

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
                        etcName:etc_name,
                        etcPhoneNumber:etc_phonenum,
                    };
                    if (confirm(comment.isSave)) {
                        studentService.saveStudentInfo(data, function () {
                            alert("학생정보가 등록 되었습니다.");
                            location.reload();
                        });
                    }
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
            var etc_phonenum = get_allphonenum("etc_phone1","etc_phone2","etc_phone3");
            var etc_name     = getInputTextValue("etc_name");

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
                etcName:etc_name,
                etcPhoneNumber:etc_phonenum,
            };
            if (confirm(comment.isSave)) {
                studentService.saveStudentInfo(data,function () {
                    alert("학생정보가 등록 되었습니다.");
                    isReloadPage(true);
                });
    }
    }8
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
        var school_name = "";
        if (school_type == "elem_list") {
            school_name = "초등학교";
        } else if (school_type == "midd_list") {
            school_name = "중학교";
        } else {
            school_name = "고등학교";
        }
        innerHTML("l_schoolName", school_name);
        initPopup($("#school_search_layer"));
    }

    function school_name_html() { //부모창에 input값넣기
        var school_name = getInnerHtmlValue("a_school_name");
        document.getElementById("schoolname").value = school_name;
        $("#close_btn").trigger("click");
    }

    function school_search() {//학교검색
        var school_type =  $(":input:radio[name=school_type]:checked").val();
        var region =  getSelectboxValue("inputregion");
        var searchSchoolName = getInputTextValue("schoo_name");
        if(region==""){
            alert("지역을 선택해 주세요.");
            return false;
        }else if(searchSchoolName == ""){
            alert("학교명을 입력해 주세요.");
            return false;
        }
        studentService.getApiSchoolName(school_type, region, searchSchoolName, function (schoolName) {
            gfn_display("search_result_div", true);
            if(schoolName == null){
                alert("학교검색 결과가 없습니다.");
                return;
            }
            innerHTML("a_school_name", schoolName ? remove_double_quotation(schoolName) : "학교검색 결과가 없습니다.");
        });
    }

    function student_excel_upload_popup() {
        initPopup($("#student_excel_upload_layer"));
    }

    function student_excel_upload() {
        var check = new isCheck();
        var formData = new FormData();

        formData.append("excel_file", $("#excel_file")[0].files[0]);

        var excel_file = fn_clearFilePath($("#excel_file").val());
        if (check.value(excel_file, comment.select_excel_file) == false) return;

        if (confirm(comment.isInsert)) {
            if (excel_file != null) {
                $.ajax({
                    url : "<%=webRoot%>/excel_read/student_info.do",
                    method : "POST",
                    dataType : "JSON",
                    data : formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success : function (data) {
                        console.log(data.result.code);
                        if (data.result.code == "EMPTY_FILE") {
                            alert("엑셀파일을 선택 해 주세요.");
                        } else if (data.result.code == "VALUE_EMPTY") {
                            alert("필수값이 없어나 값이 잘못되었습니다.");
                        } else if (data.result.code == "MOTHER") {
                            alert("[" + data.result.phoneNumber + "]전화번호는 이미 엄마 전화번호에 등록되어있는 전화번호 입니다.");
                        } else {
                            alert(comment.success_process);
                        }
                        isReloadPage(true);
                    },
                    error : function (data) {
                        alert(data)
                    }
                });
            }
        }
    }

    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/depth_menu.jsp" %>--%>
    </div>
    </section>
    <section class="content">
        <h3 class="title_t1">학생정보입력</h3>
        <div class="form_st1">
        <form name="frm" id="frm" method="get">
            <input type="hidden" name="page_gbn" id="page_gbn">
            <input type="hidden" name="student_id">
            <input type="hidden" id="school"  value="">
            <input type="hidden" id="fileName" value="">
            <input type="hidden" id="fileUrl" value="">
        </form>
            <div class="form-group row">
                <label>학생사진</label>
                <div>
                    <img id="modify_preView" src="" width="100px" height="100px" onerror="this.src='<%=webRoot%>/img/user_img_default.jpg'">
                </div>
                <div style="margin: 66px 0 0 10px">
                    <label class="custom-file">
                        <input type="file" id="attachFile" onchange="preViewImage(this, 'modify_preView', 'preview');" class="custom-file-input" required>
                        <span class="custom-file-control"></span>
                    </label>
                </div>
            </div>
            <%--<div class="form-group row" id="preview" style="display: none;">--%>
                <%--<label>학생사진미리보기</label>--%>
                <%--<div>--%>
                    <%--<img id="modify_preView" src="" width="100px" height="100px">--%>
                <%--</div>--%>
            <%--</div>--%>
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
            <div class="form-outer-group">
                <div class="form-group row">
                    <label>기타 이름</label>
                    <div><input type="text" class="form-control" id="etc_name"></div>
                </div>
                <div class="form-group row">
                    <label>기타 전화번호</label>
                    <div class="inputs">
                        <input type="text" size="2" id="etc_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.father_phone2,3)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="etc_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.father_phone3,4)">&nbsp;-&nbsp;
                        <input type="text" size="5" id="etc_phone3" class="form-control" maxlength="4">
                    </div>
                </div>
            </div>
            <div class="bot_btns">
                <button class="btn_pack blue s2" type="button"  onclick="save_student();">저장</button>
                <button class="btn_pack blue s2" type="button"  onclick="student_excel_upload_popup();">엑셀 업로드 하기</button>
            </div>
        </div>
    </section>
    <!-- 학교 검색 팝업 레이어 시작 -->
    <div class="layer_popup_template apt_request_layer" id="school_search_layer" style="display: none;">
        <div class="layer-title">
            <h3>학교검색</h3>
            <button id="close_btn" type="button" class="fa fa-close btn-close"></button>
        </div>
            <div class="layer-body">
                <div class="cont">
                    <form class="form_st1" name="frm2" method="get">
                        <div class="form-group row">
                            <label>학교구분</label> [ <span id="l_schoolName"></span> ]
                        </div>
                        <div class="form-group row">
                            <label>지역</label>
                            <select title="선택" name="inputregion" id="inputregion" class="form-control" style="width: 120px;">
                                <option value="">전체</option>
                                <option value="100260">서울특별시</option>
                                <option value="100267">부산광역시</option>
                                <option value="100269">인천광역시</option>
                                <option value="100272">대구광역시</option>
                                <option value="100275">광주광역시</option>
                                <option value="100271">대전광역시</option>
                                <option value="100273">울산광역시</option>
                                <option value="100704">세종특별자치시</option>
                                <option value="100276" selected>경기도</option>
                                <option value="100278">강원도</option>
                                <option value="100281">충청남도</option>
                                <option value="100280">충청북도</option>
                                <option value="100285">경상북도</option>
                                <option value="100291">경상남도</option>
                                <option value="100282">전라북도</option>
                                <option value="100283">전라남도</option>
                                <option value="100292">제주특별자치도</option>
                                <option value="100771">해외거주</option>
                            </select>
                        </div>
                        <div class="form-group row">
                            <label>학교이름</label>
                            <div><input type="text" id="schoo_name" class="form-control" style="width: 140px;" onkeypress="javascript:if(event.keyCode == 13){school_search(); return false;}"></div>
                        </div>
                        <div class="form-group row" style="display: none;" id="search_result_div">
                            <label>검색결과</label>
                            <a href="javascript:void(0);" onclick="school_name_html();" id="a_school_name"></a>
                        </div>
                    </form>
                </div>
                <div class="bot_btns_t1">
                    <button class="btn_pack btn-close" type="button">취소</button>
                    <button class="btn_pack blue" type="button" onclick="school_search();">검색</button>
                </div>
            </div>
    </div>
    <!-- 학교 검색 팝업 레이어 끝 -->
<!-- 학생 엑셀 업로드 팝업 레이어 시작 -->
<form method="post" name="excel_frm">
<div class="layer_popup_template apt_request_layer" id="student_excel_upload_layer" style="display: none;">
    <div class="layer-title">
        <h3>학생 정보 엑셀 입력</h3>
        <button id="close_btn2" type="button" class="fa fa-close btn-close"></button>
    </div>
    <div class="layer-body">
        <div class="cont">
            <div class="form_st1">
                <label class="custom-file" id="custom-file">
                    <input type="file" id="excel_file"  class="custom-file-input" onchange="excel_file_onchange();">
                    <span class="custom-file-control"></span>
                </label>
                <span id="l_excel_file"></span>
                <button class="btn_pack blue" type="button" onclick="student_excel_upload();">업로드</button>
            </div>
        </div>
    </div>
</div>
</form>
<!-- 학교 검색 팝업 레이어 끝 -->

</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>