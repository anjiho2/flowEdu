<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 2;

    int siderMenuDepth1 = 1;
    int siderMenuDepth2 = 2;
    int siderMenuDepth3 = 1;

    String newRegPhoneNumber = Util.isNullValue(request.getParameter("phone_number"), "");
    Boolean consultYn = Boolean.valueOf(Util.isNullValue(request.getParameter("consult_yn"), ""));
    String savePath = ConfigHolder.uploadRoot();
    String apiHost = ConfigHolder.getFlowEduApiUrl();
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<style>
    .scrolltbody {
        display: block;
        border-collapse: collapse;
    }
    .scrolltbody tbody {
        display: block;
        height: 200px;
        overflow: auto;
    }
    .scrolltbody th:nth-of-type(1), .scrolltbody td:nth-of-type(1) { width: 6%; }
    .scrolltbody th:nth-of-type(2), .scrolltbody td:nth-of-type(2) { width: 8%; }
    .scrolltbody th:nth-of-type(3), .scrolltbody td:nth-of-type(3) { width: 11%; }
    .scrolltbody th:nth-of-type(4), .scrolltbody td:nth-of-type(4) { width: 17%; }
    .scrolltbody th:nth-of-type(5), .scrolltbody td:nth-of-type(5) { width: 12%; }
    .scrolltbody th:nth-of-type(6), .scrolltbody td:nth-of-type(6) { width: 12%; }
    .scrolltbody th:nth-of-type(7), .scrolltbody td:nth-of-type(7) { width: 12%; }
    .scrolltbody th:nth-of-type(8), .scrolltbody td:nth-of-type(8) { width: 15%; }

    .scrolltbody1 {
        display: block;
        border-collapse: collapse;
    }
    .scrolltbody1 tbody {
        display: block;
        height: 200px;
        overflow: auto;
    }
    .scrolltbody1 th:nth-of-type(3), .scrolltbody1 td:nth-of-type(3) { width: 10%; }
    .scrolltbody1 th:nth-of-type(4), .scrolltbody1 td:nth-of-type(4) { width: 17%; }
    .scrolltbody1 th:nth-of-type(5), .scrolltbody1 td:nth-of-type(5) { width: 12%; }
    .scrolltbody1 th:nth-of-type(6), .scrolltbody1 td:nth-of-type(6) { width: 12%; }
    .scrolltbody1 th:nth-of-type(7), .scrolltbody1 td:nth-of-type(7) { width: 12%; }
    .scrolltbody1 th:nth-of-type(8), .scrolltbody1 td:nth-of-type(8) { width: 15%; }
</style>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/studentService.js'></script>
<script type="text/javascript" charset="UTF-8">
    function init(val) {
        // 신규 상담에서 학생 등록 할때
        var newRegPhoneNumber = '<%=newRegPhoneNumber%>';
        if (newRegPhoneNumber != "") {
            fnSetPhoneNo("mother_phone1", "mother_phone2", "mother_phone3", newRegPhoneNumber);
            $("#mother_phone1").attr("disabled", true);
            $("#mother_phone2").attr("disabled", true);
            $("#mother_phone3").attr("disabled", true);
        }
        if (val == undefined) {
            val = "ELEMENT";
        }
        schoolSelectbox("student_grade","", val);
    }

    function save_student() { //저장
        var check = new isCheck();
        var school_type = getSelectboxValue("sel_schoolType");

        var student_email = getInputTextValue("student_email");
        if (student_email) {
            var is_email = fn_isemail(student_email);
            if (is_email == true) return false;
        }

        if ($("#student_name").val().length == 1) {
            alert("학생명은 2자 이상 이여야 합니다.");
            return false;
        }

        if (check.input("student_name", comment.input_student_name) == false) return;
        if (check.input("startDate", comment.input_member_startDate) == false) return;
        if (check.input("schoolname", comment.input_school_name) == false) return;
        if (check.selectbox("sel_school", comment.input_school) == false) return;
        if (check.input("mother_name", comment.input_mother_name) == false) return;
        if (check.input("mother_phone1", comment.input_mother_tel1) == false) return;
        if (check.input("mother_phone2", comment.input_mother_tel2) == false) return;
        if (check.input("mother_phone3", comment.input_mother_tel3) == false) return;
        if (check.input("email", comment.input_member_email) == false) return;
        if (check.input("email_domain", comment.input_member_email) == false) return;


        var student_name = getInputTextValue("student_name");    //학생이름
        var gender = get_radio_value("student_gender");    //성별
        var startDate = getInputTextValue("startDate");   //생일
        var studentStatus = getSelectboxValue("sel_studentStatus");   //학생상태
        var student_phonenum = get_allphonenum("student_phone1", "student_phone2", "student_phone3");   //전화번호
        var student_telnum = get_allphonenum("student_tel1", "student_tel2", "student_tel3");   //집전화번호
        var schoolname = getInputTextValue("schoolname");   //학교이름
        var student_grade = getInputTextValue("sel_school");    //학년
        var mother_name = getInputTextValue("mother_name"); //학부모 이름
        var mother_phonenum = get_allphonenum("mother_phone1", "mother_phone2", "mother_phone3");   //학부모 전화번호
        var email = make_email(getInputTextValue("email"), getInputTextValue("email_domain"));
        var isBusBoarding = get_radio_value("is_bus_boarding");
        var student_memo = getInputTextValue("student_memo");
        var school_type = getSelectboxValue("sel_schoolType");  //2017.12.13 셀렉트박스로 변경되면서 수정(안지호)
        var studentPasword = getInputTextValue("mother_phone3");

        var data = {
            studentName: student_name,
            studentPassword: studentPasword,
            studentGender: gender,
            studentBirthday: startDate,
            studentPhoneNumber: student_phonenum,
            homeTelNumber: student_telnum,
            studentEmail: email,
            studentGrade: student_grade,
            schoolType: school_type,
            schoolName: schoolname,
            studentMemo: student_memo,
            motherName: mother_name,
            motherPhoneNumber: mother_phonenum,
            studentStatus:studentStatus,
            officeId:'<%=officeId%>',
            busBoardYn:isBusBoarding
        };
        var addBrotherInfo= new Array();
        //형제 정보가 있으면 저장
        $('input[name^="addBrotherId[]"]').each(function() {
            var studentBrotherId = ($(this).attr("id"));
            var brotherId = ($(this).val());
            var data = {
                studentBrotherId:studentBrotherId,
                brotherId:brotherId,
            }
            addBrotherInfo.push(data);
        });
        if (confirm(comment.isSave2)) {
            studentService.saveStudentInfo(data, addBrotherInfo, function (studentId) {
                //저장 완료후 학생 상세페이지로 이동
                location.href = "<%=webRoot%>/student.do?page_gbn=modify_student&student_id=" + studentId;
            });
        }
    }

    function changeSchoolGrade(school_grade) {
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


    function school_search_popup() {//학교검색 팝업창 뛰우기
        //초기화
        reset_value("schoo_name");
        reset_html("a_school_name");

        schoolTypeSelectbox("l_schoolType", "");

        //var school_type =  getSelectboxValue("sel_schoolType");
        // var school_name = "";
        // if (school_type == "ELEMENT") {
        //     school_name = "초등학교";
        // } else if (school_type == "MIDDLE") {
        //     school_name = "중학교";
        // } else {
        //     school_name = "고등학교";
        // }
        //innerHTML("l_schoolName", school_name);
        initPopup($("#school_search_layer"));
    }

    function school_name_html() { //부모창에 input값넣기
        var school_name = getInnerHtmlValue("a_school_name");
        document.getElementById("schoolname").value = school_name;
        $("#close_btn").trigger("click");
    }

    function school_search() {//학교검색
        var check = new isCheck();
        var school_type =  getSelectboxValue("sel_schoolType");
        var region =  getSelectboxValue("inputregion");
        var searchSchoolName = getInputTextValue("schoo_name");

        if (check.selectbox("sel_schoolType", comment.select_school_type) == false) return;
        if (region == "0") {
            alert(comment.select_region);
            focusInputText("inputregion");
            return;
        }
        if (check.input("schoo_name", comment.input_school_name) == false) return;

        if (school_type == "ELEMENT") school_type = "elem_list";
        else if (school_type == "MIDDLE") school_type = "midd_list";
        else school_type = "high_list";

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
                        alert("알수없는 오류가 발생되었습니다.");
                    }
                });
            }
        }
    }

    //학생검색 팝업
    function student_search_popup(obj) {
        var id = $(obj).attr("id");

        schoolTypeSelectbox3("l_schoolType2", "");
        innerValue("addBrotherTextboxId", id);
        initPopup($("#StudentFindLayer"));
    }

    //학생 팝업에서 학생 리스트 검색
    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        //var schoolType = convert_school_value(getSelectboxValue("sel_schoolType"));
        var schoolType =  convert_school_value($("#l_schoolType2").find("select").val());
        var searchType = getSelectboxValue("sel_searchType");
        var searchValue = getInputTextValue("search_value");

        var check = new isCheck();
        if (check.input("search_value", comment.input_content) == false) return;

        if(val == "new") sPage = "1";

        gfn_emptyView2("H", "");
        $("#pages2").show();

        studentService.getStudentListByLectureRegSearchCount(schoolType, searchType, searchValue, function (cnt) {
            //paging.count2(sPage, cnt, '5', '5', comment.blank_list2);
            if (cnt == 0) {
                dwr.util.removeAllRows("dataList2");
                gfn_emptyView2("V", comment.blank_list2);
                return;
            }
            $("#searchTable tbody").css("height", "200px");

            var listNum = ((cnt-1)+1)-((sPage-1) * 5); //리스트 넘버링

            studentService.getStudentListByLectureRegSearch(schoolType, searchType, searchValue, function (selList) {
                dwr.util.removeAllRows("dataList2");
                if (selList.length == 0) return;
                dwr.util.addRows("dataList2", selList, [
                    function(data) { return "<input type=\"radio\" class=\"checkbox_t1\" name=\"sel_radio\" id='check_"+ data.studentId + "'   value='"+ data.studentId +"'>" },
                    function(data) { return listNum--},
                    function(data) { return data.studentName},
                    function(data) { return data.studentPhoneNumber == null ? "-" : fn_tel_tag(data.studentPhoneNumber)},
                    function(data) { return data.schoolName},
                    function(data) { return data.studentGrade},
                    function(data) { return data.motherName},
                    function(data) { return fn_tel_tag(data.motherPhoneNumber)},
                ], {escapeHtml:false});
            });
        });
    }
    //학생 검색 팝업에서 학생 선택시
    function select_student() {
        var addBrotherTextboxId = getInputTextValue("addBrotherTextboxId");
        var selectedStudentId = get_radio_value("sel_radio");

        studentService.getStudentInfo(selectedStudentId, function(studentInfo) {
            var input_value = studentInfo.studentName + " / " + studentInfo.schoolName + " / " + studentInfo.studentGrade + "학년";
            innerValue(addBrotherTextboxId, input_value);
            $("#"+addBrotherTextboxId).next().val(selectedStudentId);
        });
        $('#close_btn2').trigger('click');
    }

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

    $(document).ready(function () {
        //이메일 셀렉트 박스 변경
        $("#sel_emailDomain").change(function () {
            innerValue("email_domain", this.value == "" ? " " : this.value);
        });
    });
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/depth_menu.jsp" %>--%>
    <div class="title-top">학생관리</div>
</div>
</section>
<section class="content">
    <form name="frm" id="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="student_id">
    </form>
    <input type="hidden" id="addNewBrotherLen">
    <input type="hidden" id="addBrotherTextboxId">

    <h3 class="title_t1">학생정보등록</h3>
    <div class="cont-wrap">
        <div class="tb_t1 colTable">
            <table class="table_width">
                <colsgroup>
                    <col width="12%" />
                    <col width="38%" />
                    <col width="12%" />
                    <col width="38%" />
                </colsgroup>

                <tr>
                    <th>학생이름 <b>*</b></th>
                    <td><input type="text" class="form-control" id="student_name" maxlength="8" onkeypress="nonHangulSpecialKey()"></td>
                    <th>성별 <b>*</b></th>
                    <td>
                        <div class="checkbox_t1 black">
                            <label><input type="radio" name="student_gender" value="MALE" checked><span>남자</span></label>
                            <label><input type="radio" name="student_gender" value="FEMALE"><span>여자</span></label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>생일 <b>*</b></th>
                    <td>
                        <div class="input-group date">
                            <input type="text" id="startDate" class="form-control date-picker">
                            <span class="input-group-addon" id="datepicker_img">
                            <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </td>
                    <th>상태 <b>*</b></th>
                    <td>
                        <select class="form-control" id="sel_studentStatus">
                            <option value="WAIT">대기생</option>
                            <option value="ATTEND">재원생</option>
                            <option value="CLOSE">휴원생</option>
                            <option value="DISMISS">퇴원생</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td class="tel">
                        <div class="form-group row marginX">
                            <div class="inputs">
                                <input type="number" size="3" id="student_phone1" class="form-control" maxlength="3" max="999" onkeyup="js_tab_order(this,'student_phone2',3)">
                                <span class="hyphen">-</span>
                                <input type="number" size="4" id="student_phone2" class="form-control" maxlength="4" max="9999" onkeyup="js_tab_order(this,'student_phone3',4)">
                                <span class="hyphen">-</span>
                                <input type="number" size="4" id="student_phone3" class="form-control" maxlength="4" max="9999" onkeyup="js_tab_order(this,'student_tel1',4)">
                            </div>
                        </div>
                    </td>
                    <th>집전화번호</th>
                    <td class="tel">
                        <div class="form-group row marginX">
                            <div class="inputs">
                                <input type="number" size="3" id="student_tel1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,'student_tel2',3)">
                                <span class="hyphen">-</span>
                                <input type="number" size="4" id="student_tel2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'student_tel3',4)">
                                <span class="hyphen">-</span>
                                <input type="number" size="4" id="student_tel3" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'student_email',4)">
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>학교이름 <b>*</b></th>
                    <td>
                        <input type="text" class="form-control" id="schoolname" onclick="school_search_popup();">
                    </td>


                    <th>학년 <b>*</b></th>
                    <td>
                        <span id="student_grade"></span>
                    </td>
                </tr>

                <tr>
                    <th>학부모이름 <b>*</b></th>
                    <td><input type="text" class="form-control" id="mother_name"></td>
                    <th>학부모전화번호 <b>*</b></th>
                    <td class="tel">
                        <div class="form-group row marginX">
                            <div class="inputs">
                                <input type="number" size="4" id="mother_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,'mother_phone2',3)">
                                <span class="hyphen">-</span>
                                <input type="number" size="5" id="mother_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'mother_phone3',4)">
                                <span class="hyphen">-</span>
                                <input type="number" size="5" id="mother_phone3" class="form-control" maxlength="4" onkeyup="js_tab_order(this,'father_name',4)">
                            </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>이메일주소 <b>*</b></th>
                    <td class="email">
                        <input type="text" class="form-control" id="email">
                        <span>@</span>
                        <input type="text" class="form-control" id="email_domain">

                        <select class="form-control" id="sel_emailDomain">
                            <option value="">직접 입력</option>
                            <option value="naver.com">NAVER</option>
                            <option value="daum.net">DAUM</option>
                            <option value="hanmail.net">HANMAIL</option>
                            <option value="gmail.com">GMAIL</option>
                            <option value="nate.com">NATE</option>
                            <option value="hotmail.com">HOTMAIL</option>
                        </select>
                    </td>
                    <th>셔틀탑승여부 <b>*</b></th>
                    <td>
                        <div class="checkbox_t1 black">
                            <label><input type="radio" name="is_bus_boarding" value="true" checked><span>예</span></label>
                            <label><input type="radio" name="is_bus_boarding" value="false"><span>아니오</span></label>
                        </div>

                    </td>
                </tr>

                <tr class="brother">
                    <th>형제정보</th>
                    <td class="brother-input">
                        <%--<input type="text" class="form-control" id="">--%>
                            <input type='text' class='form-control' id="new_cur_0" onclick='student_search_popup(this);'>
                            <input type='hidden' name='addBrotherId[]' >
                    </td>
                    <td colspan="2" class="add">
                        <button class="btn_pack" onclick="brotherAdd();">+</button>
                    </td>
                </tr>

                <tr class="memo">
                    <th>메모</th>
                    <td colspan="4">
                        <textarea class="form-control" id="student_memo" name="student_memo" rows="5" onFocus="clearMessage(this.id);" onKeyUp="checkByte(this.id, 'messagebyte', 1000);" ></textarea>
                        <div class="memo_byte">
                            <span name="messagebyte" id="messagebyte" value="0" size="4" maxlength="2" readonly>0</span>/ 1000 byte
                        </div>
                    </td>
                </tr>
            </table>
        </div>


        <button class="btn_pack blue" type="button"  onclick="save_student();">저장</button>
        <button class="btn_pack blue" type="button" onclick="goPage('student','student_list')">목록</button>
        <%--<button class="btn_pack blue s2" type="button"  onclick="student_excel_upload_popup();">엑셀 업로드 하기</button>--%>
    </div>
</section>

    <!-- 학교 검색 팝업 레이어 시작 -->
    <div class="layer_popup_template apt_request_layer" id="school_search_layer" style="display: none;width: 450px;">
        <div class="layer-title">
            <h3>학교검색</h3>
        </div>
        <div class="layer-body">
            <div class="cont">
                <form class="form_st1" name="frm2" method="get">
                    <div class="form-group row">
                        <label>학교구분</label>
                        <span id="l_schoolType"></span>
                        <%--[ <span id="l_schoolName"></span> ]--%>
                    </div>
                    <div class="form-group row">
                        <label>지역</label>
                        <select title="선택" name="inputregion" id="inputregion" class="form-control" style="width: 140px;">
                            <option value="0" selected>선택</option>
                            <option value="">전체</option>
                            <option value="100260">서울특별시</option>
                            <option value="100267">부산광역시</option>
                            <option value="100269">인천광역시</option>
                            <option value="100272">대구광역시</option>
                            <option value="100275">광주광역시</option>
                            <option value="100271">대전광역시</option>
                            <option value="100273">울산광역시</option>
                            <option value="100704">세종특별자치시</option>
                            <option value="100276">경기도</option>
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
                </form>
            </div>
            <div class="bot_btns_t1">
                <button class="btn_pack btn-close" type="button">취소</button>
                <button class="btn_pack blue" type="button" onclick="school_search();">검색</button>
            </div>
        </div>

        <button id="close_btn" type="button" class="fa fa-close btn-close popup-close"></button>
    </div>
    <!-- 학교 검색 팝업 레이어 끝 -->
<!-- 학생 엑셀 업로드 팝업 레이어 시작 -->
<%--<form method="post" name="excel_frm">--%>
<%--<div class="layer_popup_template apt_request_layer" id="student_excel_upload_layer" style="display: none;">--%>
    <%--<div class="layer-title">--%>
        <%--<h3>학생 정보 엑셀 입력</h3>--%>
        <%--<button id="close_btn2" type="button" class="fa fa-close btn-close"></button>--%>
    <%--</div>--%>
    <%--<div class="layer-body">--%>
        <%--<div class="cont">--%>
            <%--<div class="form_st1">--%>
                <%--<label class="custom-file" id="custom-file">--%>
                    <%--<input type="file" id="excel_file"  class="custom-file-input" onchange="excel_file_onchange();">--%>
                    <%--<span class="custom-file-control"></span>--%>
                <%--</label>--%>
                <%--<span id="l_excel_file"></span>--%>
                <%--<button class="btn_pack blue" type="button" onclick="student_excel_upload();">업로드</button>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
<%--</form>--%>
<!-- 학교 검색 팝업 레이어 끝 -->
<div class="layer_popup_template apt_request_layer" id="StudentFindLayer" style="display: none;">
    <div class="layer-title" style="border-bottom: 0px ;">
        <button id="close_btn2" type="button" class="fa fa-close btn-close"></button>
    </div>
    <section class="content">
        <div class="tb_t1">
            <table>
                <thead>
                <tr>
                    <th>학교선택</th>
                    <td>
                        <span id="l_schoolType2"></span>
                    </td>
                </tr>
                <tr>
                    <th>검색정보</th>
                    <td colspan="2">
                        <div class="form-group row marginX">
                            <select id="sel_searchType" class="form-control" style="width: 15rem;">
                                <option value="STUDENT_NAME">이름</option>
                                <option value="PHONE_NUMBER">전화번호</option>
                                <option value="MOTHER_NAME">학부모(모)이름</option>
                                <option value="MOTHER_PHONE_NUMBER">학부모(모)전화번호</option>
                            </select>
                            <input type="text" id="search_value" class="form-control" onkeypress="javascript:if(event.keyCode == 13){fn_search('new'); return false;}">
                        </div>
                    </td>
                </tr>
            </table>
            <div class="bot_btns_t1">
                <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="tb_t1">
            <table id="searchTable" class="scrolltbody">
                <thead>
                <tr>
                    <th>선택</th>
                    <th>No.</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>학교명</th>
                    <th>학년</th>
                    <th>학부모(모) 이름</th>
                    <th>학부모(모) 전화번호</th>
                </tr>
                </thead>
                <tbody id="dataList2"></tbody>
                <tr>
                    <td id="emptys2" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
            <div>
                <button class="btn_pack blue" type="button" onclick="select_student();">선택</button>
                <button class="btn_pack btn-close" type="button">취소</button>
            </div>
        </div>
    </section>
</div>
<!--학생 추가 레이어 끝-->
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>
<script>
    $(".sidebar-menu > li").eq(1).addClass("active");
    $(".sidebar-menu > li:nth-child(2) > ul > li:nth-child(1) > a").addClass("on");
</script>