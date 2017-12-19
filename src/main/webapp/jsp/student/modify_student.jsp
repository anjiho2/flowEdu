<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 1;
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String imgUrl = ConfigHolder.getFileViewUrl();
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script>
    function init() {
        studentList();
        student_memo_list();
    }

    function studentList() {
        var student_id        = getInputTextValue("student_id");
        studentService.getStudentInfo(student_id, function (selList) {

            var file_url = '<%=imgUrl%>' + selList.studentPhotoUrl + "/" + selList.studentPhotoFile;
           
            $("#modify_preView").attr("src", file_url);
            if(file_url != null) gfn_display("preview", true);

            innerValue("student_name", selList.studentName);
            innerValue("startDate", selList.studentBirthday);
            genderRadio("l_gender", selList.studentGender, "");
            schoolTypeSelectbox("l_schoolType", selList.schoolType);
            //$('input:radio[name=school_type]:input[value=' + selList.schoolType + ']').attr("checked", true);
            //innerValue("sel_school", selList.studentGrade);
            schoolSelectbox("student_grade", selList.studentGrade, selList.schoolType);
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
            innerValue("etc_name", selList.etcName);
            fnSetPhoneNo(etc_phone1,  etc_phone2,  etc_phone3,  selList.etcPhoneNumber);
            $("input[name=student_name]").val(selList.studentName);
            checkByte(selList.studentMemo);
        });
    }

    //수정
    function modify_student() {
        var check = new isCheck();
        var student_id   = getInputTextValue("student_id");
        var data = new FormData();

        //이메일형식체크
        var student_email   = getInputTextValue("student_email");
        if(student_email){
            var is_email = fn_isemail(student_email);
            if (is_email == true) return false;
        }
        if(check.input("student_name", comment.input_student_name)   == false) return;
        if(check.input("startDate", comment.input_member_startDate)   == false) return;
        //if(check.input("sel_school", comment.input_student_grade)   == false) return;
        if(check.input("mother_name", comment.input_mother_name)   == false) return;
        if(check.input("mother_phone1", comment.input_mother_tel1)   == false) return;
        if(check.input("mother_phone2", comment.input_mother_tel2)   == false) return;
        if(check.input("mother_phone3", comment.input_mother_tel3)   == false) return;

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
                    var gender          = get_radio_value("gender_type");
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
                    //var school_type =  $(":input:radio[name=school_type]:checked").val();
                    var school_type = getSelectboxValue("sel_schoolType");  //2017.12.13 셀렉트박스로 변경되면서 수정(안지호)
                    var etc_phonenum = get_allphonenum("etc_phone1","etc_phone2","etc_phone3");
                    var etc_name     = getInputTextValue("etc_name");

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
                        etcName:etc_name,
                        etcPhoneNumber:etc_phonenum,
                    };
                    if (confirm(comment.isUpdate2)) {
                        studentService.modifyStudentInfo(data,function () {
                            goPage("student","student_list");
                        });
                    }
                },
                error : function (xhr, textStatus, errorThrown) {
                    alert(comment.file_name_not_allow_korean);
                    return;
                }
            });
        } else { //학생사진 없을때
            var mother_phone3    = getInputTextValue("mother_phone3");
            var student_name    = getInputTextValue("student_name");
            var gender          = get_radio_value("gender_type");
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
            //var school_type =  $(":input:radio[name=school_type]:checked").val();
            var school_type = getSelectboxValue("sel_schoolType");  //2017.12.13 셀렉트박스로 변경되면서 수정(안지호)
            var etc_phonenum = get_allphonenum("etc_phone1","etc_phone2","etc_phone3");
            var etc_name     = getInputTextValue("etc_name");

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
                etcName:etc_name,
                etcPhoneNumber:etc_phonenum,
            };
            if (confirm(comment.isUpdate2)) {
                studentService.modifyStudentInfo(data,function () {
                    goPage("student","student_list");
                });
            }
        }
    }

    function changeSchoolGrade(school_grade) {
        schoolSelectbox("student_grade","", school_grade);
    }
    /*
    function school_search_popup() { //학교검색 팝업창 뛰우기
        var school_type =  $(":input:radio[name=school_type]:checked").val();

        if(school_type == null){
            alert("학교구분을 선택해 주세요.");
            return false;
        }
        var param = "?school_type="+school_type;
        gfn_winPop(550,400,"jsp/popup/school_search_popup.jsp",param);
    }
    */
    // 처리하기 버튼
    function changeProccessYn(studentMemoId) {
        if (confirm("처리하시겠습니까?")) {
            studentService.modifyMemoProcessYn(studentMemoId, true);
            isReloadPage(true)
        }
    }

    //최근상담 3건 리스트
    function student_memo_list() {
        var student_id = getInputTextValue("student_id");
        studentService.getStudentMemoLastThree(student_id, function (memoList) {
            if (memoList.length > 0) {
                for (var i = 0; i < memoList.length; i++) {
                    var cmpList = memoList[i];
                    if (cmpList != undefined) {
                        var processHTML = "";
                        cmpList.processYn ==  false ? processHTML = "<a href='javascript:void(0);'  class='font_color blue'  id="+cmpList.studentMemoId+" onclick='changeProccessYn(this.id);'>처리하기</a>" :  processHTML = "<span><h4>완료</h4></span>";
                        var cellData = [
                            function(data) {return cmpList.memoTitle;},
                            function(data) {return ellipsis(cmpList.memoContent, 30);},
                            function(data) {return processHTML;},//처리하기
                            function(data) {return cmpList.memberName;},
                            function(data) {return getDateTimeSplitComma(cmpList.createDate);},
                        ];
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                    }
                }
            }else{
                gfn_emptyView("V", comment.not_consult_log_three);
            }
        });
    }
    //댓글 페이지 이동
    function go_reply(mapping_value, page_value, memo_id) {
        with(document.frm) {
            if (mapping_value != "" && page_value != "") {
                page_gbn.value = page_value;
                student_memo_id.value = memo_id;
            }
            action = getContextPath()+"/"+mapping_value+".do";
            submit();
        }
    }

    function school_search_popup() {//학교검색
        //var school_type =  $(":input:radio[name=school_type]:checked").val();
        //초기화
        reset_value("schoo_name");
        reset_html("a_school_name");

        var school_type =  getSelectboxValue("sel_schoolType");

        var school_name = "";
        if (school_type == "ELEMENT") {
            school_name = "초등학교";
        } else if (school_type == "MIDDLE") {
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
        var school_type =  getSelectboxValue("sel_schoolType");
        var region =  getSelectboxValue("inputregion");
        var searchSchoolName = getInputTextValue("schoo_name");

        if (school_type == "ELEMENT") school_type = "elem_list";
        else if (school_type == "MIDDLE") school_type = "midd_list";
        else school_type = "high_list";

        if(region==""){
            alert("지역을 선택해 주세요.");
            return false;
        }else if(searchSchoolName == ""){
            alert("학교명을 입력해 주세요.");
            return false;
        }
        studentService.getApiSchoolName(school_type, region, searchSchoolName, function (schoolName) {
            if(schoolName == null){
                alert("학교검색 결과가 없습니다.");
                return;
            } else {
                gfn_display("search_result_div", true);
                innerHTML("a_school_name", schoolName ? remove_double_quotation(schoolName) : "학교검색 결과가 없습니다.");
            }
        });
    }
    /*메모입력 바이트 제한기능*/
    var clearChk=true;
    var limitByte = 1000;
    // textarea에 마우스가 클릭되었을때 초기 메시지를 클리어
    function clearMessage(){
        if(clearChk){
            $("#student_memo").val("");
            clearChk=false;
        }
    }
    // textarea에 입력된 문자의 바이트 수를 체크
    function checkByte(val) {
        var totalByte = 0;
        var message = $("#student_memo").val();
        if (val != null || val != undefined) {
            message = val;
        }
        for (var i = 0; i < message.length; i++) {
            var currentByte = message.charCodeAt(i);
            if (currentByte > 128) totalByte += 2;
            else totalByte++;
        }
        $("#messagebyte").html(totalByte);
        if (totalByte > limitByte) {
            var memolimit = message.substring(0, limitByte);
            $("#student_memo").val(memolimit);
        }
    }

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/student_depth_menu.jsp" %>
</div>
</section>
<section class="content">
    <form name="frm" id="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="school"  value="">
        <input type="hidden" id="fileName"  value="">
        <input type="hidden" id="fileUrl"  value="">
        <input type="hidden" id="student_id" name="student_id" value="<%=student_id%>">
        <input type="hidden" name="student_memo_id" id="student_memo_id">
        <input type="hidden" name="student_name">
    </form>
    <div class="tb_t1">
        <table class="info_student">
            <tr>
                <th>학생사진</th>
                <td colspan="4">
                    <div style="display: flex;">
                        <div>
                            <img id="modify_preView" src="" width="100px" height="100px" onerror="this.src='<%=webRoot%>/img/user_img_default.jpg'">
                        </div>
                        <div class="form-group row" style="margin: 66px 0 0 10px;">
                            <label class="custom-file">
                                <input type="file" id="attachFile"  onchange="preViewImage(this, 'modify_preView', 'preview');" class="custom-file-input" required>
                                <span class="custom-file-control" style="width: 246px;"></span>
                            </label>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>학생이름</th>
                <td><input type="text" class="form-control" id="student_name" maxlength="8"></td>
                <th>성별<b>*</b></th>
                <td colspan="2">
                    <span id="l_gender"></span>
                    <%--<div class="checkbox_t1">--%>
                        <%--<label><input type="radio" name="student_gender" value="MALE" checked><span>남자</span></label>--%>
                        <%--<label><input type="radio" name="student_gender" value="FEMALE"><span>여자</span></label>--%>
                    <%--</div>--%>
                </td>
            </tr>
            <tr>
                <th>생일<b>*</b></th>
                <td colspan="4">
                    <div class="input-group date">
                        <input type="text" id="startDate" class="form-control date-picker">
                        <span class="input-group-addon">
                        <span class="fa fa-calendar"></span>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th>핸드폰번호</th>
                <td>
                    <div class="form-group row marginX">
                        <div class="inputs">
                            <input type="number" size="4" id="student_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,'student_phone2',3)">&nbsp;-&nbsp;
                            <input type="number" size="5" id="student_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'student_phone3',4)">&nbsp;-&nbsp;
                            <input type="number" size="5" id="student_phone3" class="form-control" maxlength="4" onkeyup="js_tab_order(this, 'student_tel1', 4)">
                        </div>
                    </div>
                </td>
                <th>집전화번호</th>
                <td colspan="2">
                    <div class="form-group row marginX">
                        <div class="inputs">
                            <input type="number" size="4" id="student_tel1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,'student_tel2',3)">&nbsp;-&nbsp;
                            <input type="number" size="5" id="student_tel2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'student_tel3',4)">&nbsp;-&nbsp;
                            <input type="number" size="5" id="student_tel3" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'student_email',4)">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td colspan="4"><input type="email" class="form-control datepicker" id="student_email"></td>
            </tr>
            <tr>
                <th>학교구분</th>
                <td><span id="l_schoolType"></span>
                    <%--<div class="checkbox_t1">--%>
                    <%--<label><input type="radio" name="school_type" class="form-control" value="elem_list"  onclick="school_radio(this.value);" checked><span>초등학교</span></label>--%>
                    <%--<label><input type="radio" name="school_type" class="form-control" value="midd_list"  onclick="school_radio(this.value);"><span>중학교</span></label>--%>
                    <%--<label><input type="radio" name="school_type" class="form-control" value="high_list"  onclick="school_radio(this.value);"><span>고등학교</span></label>--%>
                    <%--</div>--%>
                </td>
                <th>학교이름</th>
                <td>
                    <input type="text" class="form-control" id="schoolname" onclick="school_search_popup();">
                </td>
                <td>
                    <span id="student_grade"></span>
                </td>
            </tr>
            <tr>
                <th>메모</th>
                <td colspan="4">
                    <textarea class="form-control" id="student_memo" name="student_memo" rows="5" onKeyUp="checkByte();" ></textarea>
                    <div class="memo_byte">
                        <span name="messagebyte" id="messagebyte" value="0" size="4" maxlength="2" readonly>0</span>/ 1000 byte
                    </div>
                </td>
            </tr>
            <tr>
                <th>학부모(모)이름<b>*</b></th>
                <td><input type="text" class="form-control" id="mother_name"></td>
                <th>학부모(모)전화번호<b>*</b></th>
                <td colspan="2">
                    <div class="form-group row marginX">
                        <div class="inputs">
                            <input type="number" size="4" id="mother_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,'mother_phone2',3)">&nbsp;-&nbsp;
                            <input type="number" size="5" id="mother_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'mother_phone3',4)">&nbsp;-&nbsp;
                            <input type="number" size="5" id="mother_phone3" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'father_name',4)">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>학부모(부)이름</th>
                <td><input type="text" class="form-control" id="father_name"></td>
                <th>학부모(부)전화번호</th>
                <td colspan="2">
                    <div class="form-group row marginX">
                        <div class="inputs">
                            <input type="number" size="4" id="father_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,'father_phone2',3)">&nbsp;-&nbsp;
                            <input type="number" size="5" id="father_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'father_phone3',4)">&nbsp;-&nbsp;
                            <input type="number" size="5" id="father_phone3" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'etc_name',4)">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>기타이름</th>
                <td><input type="text" class="form-control" id="etc_name"></td>
                <th>기타번호</th>
                <td colspan="2">
                    <div class="form-group row marginX">
                        <div class="inputs">
                            <input type="number" size="4" id="etc_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,'etc_phone2',3)">&nbsp;-&nbsp;
                            <input type="number" size="5" id="etc_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'etc_phone3',4)">&nbsp;-&nbsp;
                            <input type="number" size="5" id="etc_phone3" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'',4)">
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div class="bot_btnswrap">
        <button class="btn_pack blue s2" type="button"  onclick="modify_student();">수정</button>
        <button class="btn_pack blue s2" type="button" onclick="goPage('student','student_list')">목록</button>
        <%--<button class="btn_pack blue s2" type="button"  onclick="student_excel_upload_popup();">엑셀 업로드 하기</button>--%>
    </div>
    <div class="tb_t1">
        <h3 class="title_t1">최근 상담 내역</h3>

        <table>
            <tr>
                <th>제목</th>
                <th>내용</th>
                <th>처리상태</th>
                <th>등록자</th>
                <th>등록일시</th>
            </tr>
            <tbody id="dataList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
    </div>
</section>

<!-- 학교 검색 팝업 레이어 시작 -->
<div class="layer_popup_template apt_request_layer" id="school_search_layer" style="display: none;width: 360px;">
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
                    <a href="javascript:void(0);" class="font_color blue" onclick="school_name_html();" id="a_school_name"></a>
                </div>
        </div>
        <div class="bot_btns_t1">
            <button class="btn_pack btn-close" type="button">취소</button>
            <button class="btn_pack blue" type="button" onclick="school_search();">검색</button>
        </div>
    </div>
</div>
<!-- 학교 검색 팝업 레이어 끝 -->
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>
<script>
    $(".sidebar-menu > li").eq(1).addClass("active");
    $(".sidebar-menu > li:nth-child(2) > ul > li:nth-child(1) > a").addClass("on");
</script>
