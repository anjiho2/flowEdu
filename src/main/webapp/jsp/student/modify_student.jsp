<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 1;

    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    String imgUrl = ConfigHolder.getFileViewUrl();
    String savePath = ConfigHolder.uploadRoot();
    String apiHost = ConfigHolder.getFlowEduApiUrl();

    int siderMenuDepth1 = 1;
    int siderMenuDepth2 = 2;
    int siderMenuDepth3 = 1;
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
<script>
    function init(val) {
        studentList(val);
        student_memo_list();
    }

    function studentList(val) {
        var student_id        = getInputTextValue("student_id");
        studentService.getStudentInfo(student_id, function (selList) {
            innerValue("student_name", selList.studentName);
            innerValue("startDate", selList.studentBirthday);
            $("#sel_studentStatus").val(selList.studentStatus);
            genderRadio("l_gender", selList.studentGender, "");

            var studentGrade = selList.studentGrade;
            schoolSelectbox("student_grade", studentGrade, val == undefined ? convert_school_type(selList.schoolType) : val);
            fnSetPhoneNo(student_phone1, student_phone2, student_phone3, selList.studentPhoneNumber);
            fnSetPhoneNo(student_tel1,   student_tel2,   student_tel3,   selList.homeTelNumber);
            fnSetPhoneNo(mother_phone1,  mother_phone2,  mother_phone3,  selList.motherPhoneNumber);
            fn_mail_cut("email", "email_domain", selList.studentEmail);
            innerValue("student_email", selList.studentEmail);
            $("#sel_emailDomain").val(get_email_domain(selList.studentEmail));

            $('input:radio[name=is_bus_boarding]:input[value=' + selList.busBoardYn + ']').attr("checked", true);
            innerValue("student_grade", selList.memberAddress);
            innerValue("schoolname", selList.schoolName);
            innerValue("mother_name", selList.motherName);
            $("input[name=student_name]").val(selList.studentName);
            //checkByte(selList.studentMemo);
            //형제정보 가져오기
            studentService.getStudentBrother(student_id, function(brotherList) {
                var $brother_tr = $(".brother").find(".brother-input");
                if (brotherList.length == 0) {
                    var input = "<input type='text' class='form-control' id='cur_0' onclick='student_search_popup(this);'>\n" +
    "                            <input type='hidden' name='addBrotherId[]'>"
                    $brother_tr.append(input);
                    return;
                }
                for (var i=0; i<brotherList.length; i++) {
                    var cmpList = brotherList[i];
                    var input_value = cmpList.studentName + " / " + cmpList.schoolName + " / " + cmpList.studentGrade + "학년";
                    var input ="<input type='text' class='form-control' id='cur_"+ cmpList.studentBrotherId +"' value='"+ input_value +"' onclick='student_search_popup(this);'>";
                        input += "<input type='hidden' id='"+ cmpList.studentBrotherId +"' name='addBrotherId[]' value=" + cmpList.brotherId + ">";
                    $brother_tr.append(input);
                }
            });
            //메모 목록 가져오기
            studentService.getStudentSimpleMemo(student_id, function(simpleMemoList) {
               if (simpleMemoList.length == 0) return;

               var $memo_div = $(".memo-history");
               for (var i=0; i<simpleMemoList.length; i++) {
                   var cmpList = simpleMemoList[i];
                   var data =
                       "<div class=\"cont\">\n" +
                       "작성자: <span class=\"name\">"+ cmpList.memberName +"</span>\n" +
                       "작성일: <span class=\"date\">"+ getDateTimeSplitComma(cmpList.createDate) + "</span>\n" +
                       "<p class=\"memo-cont\">" + cmpList.memoContent + "</p>\n" +
                       "</div>"
                   $memo_div.append(data);
               }
            });
        });
    }

    //수정(2018. 04. 01 기획안 변경으로 내용 변경, 작성자 : 안지호)
    function modify_student() {
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
            studentId:'<%=student_id%>',
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
            busBoardYn:isBusBoarding
        };
        //형제 목록 값 가져오기
        var addBrotherInfo= new Array();
        $('input[name^="addBrotherId[]"]').each(function() {
            var studentBrotherId = ($(this).attr("id"));
            var brotherId = ($(this).val());
            var data = {
                studentBrotherId:studentBrotherId,
                brotherId:brotherId,
                studentId:'<%=student_id%>'
            }
            addBrotherInfo.push(data);
        });
        if (confirm(comment.isUpdate2)) {
            gfn_display("loadingbar", true);
            studentService.modifyStudentInfo(data, addBrotherInfo, function () {
                isReloadPage(true);
            });
            gfn_display("loadingbar", false);
        }
    }

    function changeSchoolGrade(school_grade) {
        schoolSelectbox("student_grade","", school_grade);
    }
    // 처리하기 버튼
    function changeProccessYn(studentMemoId) {
        if (confirm("처리하시겠습니까?")) {
            studentService.modifyMemoProcessYn(studentMemoId, true);
            isReloadPage(true)
        }
    }

    //최근상담 5건 리스트 (기획안 변경에 따른 수정 2018. 04. 01 안지호)
    function student_memo_list() {
        var student_id = getInputTextValue("student_id");
        studentService.getStudentMemoLastThree(student_id, function (memoList) {
            if (memoList.length > 0) {
                for (var i = 0; i < memoList.length; i++) {
                    var cmpList = memoList[i];
                    if (cmpList != undefined) {
                        var processHTML = "";
                        cmpList.processYn ==  false ? processHTML = "<span style='color: red;'>대기</a>" :  processHTML = "<span><h4>완료</h4></span>";

                        var memoTitleHTML = "<a href='<%=webRoot%>/student.do?page_gbn=detail_memo_student&student_id=" + student_id + "&student_memo_id="+ cmpList.studentMemoId+ "' class='font_color blue'>"+cmpList.memoTitle+"</a>";
                        var cellData = [
                            function(data) {return memoTitleHTML;},
                            function(data) {return cmpList.memberName;},
                            function(data) {return getDateTimeSplitComma(cmpList.createDate)},
                            function(data) {return cmpList.targetMemberName;},
                            function(data) {return processHTML;},//처리하기
                            function(data) {return cmpList.processDate == null ? "-" : getDateTimeSplitComma(cmpList.processDate)},
                        ];
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                    }
                }
            }else{
                gfn_emptyView("V", comment.not_consult_log_three);
            }
        });
    }
    //학교검색팝업
    function school_search_popup() {
        //var school_type =  $(":input:radio[name=school_type]:checked").val();
        //초기화
        reset_value("schoo_name");
        reset_html("a_school_name");
        schoolTypeSelectbox4("l_schoolType", "");

        initPopup($("#school_search_layer"));
    }

    function school_name_html() { //부모창에 input값넣기
        var school_name = getInnerHtmlValue("a_school_name");
        document.getElementById("schoolname").value = school_name;
        $("#close_btn").trigger("click");
    }
    //학교검색하기
    function school_search() {
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
    //학생검색 팝업에서 초,중,고 선택시 학년 변경하기
    function select_school_type(val) {
        var schoolType = val;
        schoolSelectbox("student_grade", "", schoolType);
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
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/student_depth_menu.jsp" %>
</div>
</section>
<span id="span_addBrother" style="display: none">

</span>

<section class="content detail">
    <form name="frm" id="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="student_id" name="student_id" value="<%=student_id%>">
    </form>
    <input type="hidden" id="addNewBrotherLen">
    <input type="hidden" id="addBrotherTextboxId">
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
                    <td><input type="text" class="form-control" id="student_name" maxlength="8" onkeypress="nonHangulSpecialKey();"></td>
                    <th>성별<b>*</b></th>
                    <td colspan="2">
                        <span id="l_gender"></span>
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
                        <input type="email" class="form-control" id="email">
                        <span>@</span>
                        <input type="email" class="form-control" id="email_domain">

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
                    </td>
                    <td colspan="2" class="add">
                        <button class="btn_pack" onclick="brotherAdd();">+</button>
                    </td>
                </tr>

                <tr class="memo">
                    <th>메모</th>
                    <td colspan="4">
                        <div class="memo-history"></div>

                        <textarea class="form-control" id="student_memo" name="student_memo" rows="5" onFocus="clearMessage(this.id);" onKeyUp="checkByte(this.id, 'messagebyte', 1000);" ></textarea>
                        <div class="memo_byte">
                            <span name="messagebyte" id="messagebyte" value="0" size="4" maxlength="2" readonly>0</span>/ 1000 byte
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div>
            <button class="btn_pack blue" type="button"  onclick="modify_student();">수정</button>
            <button class="btn_pack blue" type="button" onclick="goPage('student','student_list')">목록</button>
            <%--<button class="btn_pack blue s2" type="button"  onclick="student_excel_upload_popup();">엑셀 업로드 하기</button>--%>
        </div>
    </div>


    <h3 class="title_t1">최근상담내역</h3>
    <div class="cont-wrap">
        <div class="tb_t1">
            <table>
                <colsgroup>
                    <col width="30%" />
                    <col width="10%" />
                    <col width="20%" />
                    <col width="10%" />
                    <col width="10%" />
                    <col width="20%" />
                </colsgroup>

                <tr class="t_head">
                    <th>제목</th>
                    <th>등록자</th>
                    <th>동록일시</th>
                    <th>처리자</th>
                    <th>상태</th>
                    <th>처리일시</th>
                </tr>
                <tbody id="dataList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
        </div>
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

<div class="layer_popup_template apt_request_layer" id="StudentFindLayer" style="display: none;">
    <div class="layer-title" style="border-bottom: 0px ;">
        <button id="close_btn2" type="button" class="fa fa-close btn-close"></button>
    </div>
    <section class="content">
        <div class="tb_t1">
            <input type="hidden" id="sPage" value="<%=sPage%>">
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
</body>
<%@include file="/common/jsp/footer.jsp" %>
