<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 6;
    int depth2 = 2;

    int siderMenuDepth1 = 4;
    int siderMenuDepth2 = 0;
    int siderMenuDepth3 = 0;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureManager.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<link rel="stylesheet" href="//cdn.rawgit.com/fgelinas/timepicker/master/jquery.ui.timepicker.css">
<script type="text/javascript">
    function init(val) {
        var office_id;
        if(val == undefined || val == "") office_id = 0;
        else office_id = val;

        academyListSelectbox2("sel_academy",office_id);
        lectureOperationTypeSelectbox("sel_lectureOperation","");
        lectureStatusSelectbox("sel_lectureStatus","","50");
        lectureStudentLimitSelectbox("sel_lectureStudentlimit","", "30");
        schoolSelectbox("student_grade","", "elem_list");
        lectureSubjectSelectbox("sel_lectureSubject","");
        lectureLevelRadio("lecture_level","HIGH","");
        lecturePriceSelectbox("lecture_price","");
        teacherList(office_id, "sel_member", "");
        teacherList2(office_id,"sel_member2","");
        lectureDaySelectbox("lectureDaySelectbox","");
        lectureRoomSelectbox(office_id,"lectureRoomSelectbox","");

    }
    // 관 선택시 onChange
    function academy_sel_change(val) {
        init(val);
    }
    //학년 구분에 따른 학년 셀렉트 박스 변경
    function school_radio(school_grade) {
        schoolSelectbox("student_grade","", school_grade);
    }
    //강의실 중복 체크
    function dupcheck_lecture_room() {
        var sel_lectureRoom = get_array_last_value_by_name("select", "sel_lectureRoom[]");
        var sel_lectureDay  = get_array_last_value_by_name("select", "lecture_day[]");
        var start_time  = get_array_last_value_by_name("input", "start_time[]");
        var end_time  = get_array_last_value_by_name("input", "end_time[]");

        var div_len = $(".clonedDiv").length;
        var sel_pre_lectureRoom = $('select[name="sel_lectureRoom[]"]').eq(div_len-2).val();
        var sel_pre_lectureDay  = $('select[name="lecture_day[]"]').eq(div_len-2).val();
        var pre_start_time      = $('input[name="start_time[]"]').eq(div_len-2).val()
        var pre_end_time        = $('input[name="end_time[]"]').eq(div_len-2).val();

        if(sel_lectureRoom == "" || sel_lectureDay == "" || start_time == "" || end_time == ""){
            alert("강의시간표 상세정보를 입력해 주세요.");
            return;
        }

        trans_html();
     /* var sel_lectureRoom = get_array_last_value_by_name("select", "sel_lectureRoom[]");
        var sel_lectureDay  = get_array_last_value_by_name("select", "lecture_day[]");
        var start_time  = get_array_last_value_by_name("input", "start_time[]");
        var end_time  = get_array_last_value_by_name("input", "end_time[]");

        var div_len = $(".clonedDiv").length;
        var sel_pre_lectureRoom = $('select[name="sel_lectureRoom[]"]').eq(div_len-2).val();
        var sel_pre_lectureDay  = $('select[name="lecture_day[]"]').eq(div_len-2).val();
        var pre_start_time      = $('input[name="start_time[]"]').eq(div_len-2).val()
        var pre_end_time        = $('input[name="end_time[]"]').eq(div_len-2).val();

        if(sel_lectureRoom == "" || sel_lectureDay == "" || start_time == "" || end_time == ""){
            alert("강의시간표 상세정보를 입력해 주세요.");
            return;
        }
        //시간 시간과 종료시간 비교 (2017. 09. 22 안지호)
        if (!compareTime(start_time, end_time)) {
            alert("강의 시간이 잘못되었습니다.\n시작시간은 종료시간보더 전이여야 합니다.");
            $('input[name="start_time[]"]').last().focus();
            return;
        }
        //추가버튼을 누를때 추가전의 값과 시간 비교 기능 추가 (2017. 09. 22 안지호)
        if (div_len > 1) {
            if ((sel_lectureDay == sel_pre_lectureDay) && (sel_lectureRoom == sel_pre_lectureRoom)) {
                if ((start_time < pre_end_time) && (end_time > pre_start_time)) {
                    alert("추가할수없는 시간대와 강의실 입니다.\n다른 시간대와 강의실을 선택하세요.");
                    $('select[name="sel_lectureRoom[]"]').last().val("");
                    $('select[name="lecture_day[]"]').last().val("");
                    $('input[name="start_time[]"]').last().val("");
                    $('input[name="end_time[]"]').last().val("");
                    return;
                }
            }
        }

        lectureService.checkDuplicateLectureDetail(sel_lectureRoom, start_time, end_time, sel_lectureDay, function (bl) {
            if(bl==true){
                alert("등록할수없는 시간대와 강의실 입니다.\n다른 시간대와 강의실을 선택하세요.");
                $('input[name="start_time[]"]').last().val("");
                $('input[name="end_time[]"]').last().val("");
            } else {
                trans_html();
            }
        });*/
    }

    //html 복제하기
    function trans_html() {
        var num = $(".clonedDiv").length;   //복사할 영역 클래스 길이
        var newNum = num + 1;
        var newElem = $("#input1").clone().attr('id', 'input' + newNum);    //복사할 영역 원본 id 값 변경
        newElem.find("#start_time_input_1 input").attr('id', 'start_time_' + newNum).val('');   //시간이 보여줄 input 접근 후 id 값 변경
        //복제된 영역에서 시간이 보여줄 input jquery.timepicker 바인딩시켜주기
        newElem.find("#start_time_input_1 input")
            .removeClass('hasTimepicker')
            .removeData('timepicker')
            .unbind()
            .timepicker({
                hourText: '시',
                minuteText: '분'
            });
            $.timepicker.setDefaults($.timepicker.regional['ko']);
        //종료시간 input박스
        newElem.find("#end_time_input_1 input").attr('id', 'end_time_' + newNum).val('');
        newElem.find("#end_time_input_1 input")
            .removeClass('hasTimepicker')
            .removeData('timepicker')
            .unbind()
            .timepicker({
                hourText: '시',
                minuteText: '분'
            });
        $.timepicker.setDefaults($.timepicker.regional['ko']);
        //복제시 삭제 버튼 추가
        newElem.find('#lectureDaySelectbox').after("<button class='btn_pack white' type='button' style='min-width:36px;' onclick='del_html();'>X</button>")
        $("#input" + num).after(newElem);
    }

    //복제된 html 삭제하기
    function del_html() {
        var num = $('.clonedDiv').length;
        $('#input' + num).remove();
        $('#del_btn').attr('disabled', false);
        if (num - 1 == 1) {
            $('#del_btn').attr('disabled', 'disabled');
        }
    }

    //강의정보 저장
    function save_lecture_info() {
        var sel_academy  = getSelectboxValue("sel_academyList2");//관선택
        var manager      = getSelectboxValue("sel_teacherList2");//관리선생님
        var teacher      = getSelectboxValue("sel_teacherList");//담당선생님
        var sel_price    = getSelectboxValue("sel_lecturePrice");//가격
        var lecture_name = getInputTextValue("lecture_name");//강의명
        var lecture_subject   =  getSelectboxValue("sel_lectureSubject");//강의과목
        var school_type  = get_radio_value("school_type");//학교구분
        var sel_school   = getSelectboxValue("sel_school");//학년
        var lecture_level  = get_radio_value("lecture_level");//레벨
        var lecture_operation = getSelectboxValue("sel_lectureOperationTypeList");//강의기간단위
        var lecture_start  = getInputTextValue("startDate");//강의시작일
        var lecture_end    = getInputTextValue("startDate2");//강의종료일
        var lecture_student_limit   = getSelectboxValue("sel_lectureStudentLimitList");//강의인원수
        var lecture_state  = getSelectboxValue("sel_lectureStatusList");//강의상태

        var lecture_info = {
            officeId: sel_academy,
            chargeMemberId: teacher,
            manageMemberId: manager,
            lecturePriceId: sel_price,
            lectureName: lecture_name,
            lectureSubject: lecture_subject,
            lectureGrade: sel_school,
            lectureLevel: lecture_level,
            lectureOperationType: lecture_operation,
            lectureStartDate: lecture_start,
            lectureEndDate: lecture_end,
            lectureLimitStudent: lecture_student_limit,
            lectureStatus: lecture_state,
            schoolType: school_type
        };

        var end_time_list = get_array_values_by_name("input", "end_time[]");
        var start_time_list = get_array_values_by_name("input", "start_time[]");
        var room_list = get_array_values_by_name("select", "sel_lectureRoom[]");
        var day_list = get_array_values_by_name("select", "lecture_day[]");
        var num = $('.clonedDiv').length;
        var detail_list = new Array();

        for(var i=0; i < num ; i++){
            //강의상세정보 강의시작/종료시간 유효성체크
            var detail_compare_time = compareTime(start_time_list[i], end_time_list[i]);
            if(detail_compare_time == false) {
                alert("강의종료시간이 강의시작시간보다 작습니다.");
                return false;
            }
            //배열에 값넣기 강의상세정보
            var lecture_detail_info = {
                lectureRoomId: room_list[i],
                startTime: start_time_list[i],
                endTime: end_time_list[i],
                lectureDay: day_list[i]
            };
            detail_list.push(lecture_detail_info);
        }

        //강의 시작일&종료일 시간비교 유효성체크
        if(!compareTime(lecture_start,lecture_end)) {
            alert("강의종료일이 강의시작일보다 작습니다.");
            focusInputText("startDate");
            return false;
        }
        /*
        if(sel_lectureRoom == "" || sel_lectureDay == "" || start_time == "" || end_time == ""){
            alert("상세정보를 입력해 주세요.");
            return;
        }
        */
        if (confirm(comment.isSave)) {
            lectureManager.regLecture(lecture_info, detail_list, function (bl) {
                if(bl==true){
                    //TODO : 등록이 완료되면 강의 리스트로 이동시키는 기능 추가하기
                    lecture_go('lecture_list');
                } else {
                    alert(comment.error);
                }
            });
        }
    }
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/lecture_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <h3 class="title_t1">강의정보입력</h3>
    <form name="frm" method="get" class="form_st1">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <div class="form-group row">
            <label>관선택<b>*</b></label>
            <div><span id="sel_academy"></span></div>
        </div>
        <div class="form-outer-group">
            <div class="form-group row">
                <label>관리선생님<b>*</b></label>
                <div><span id="sel_member2"></span></div>
            </div>
            <div class="form-group row">
                <label>담당선생님<b>*</b></label>
                <div><span id="sel_member"></span></div>
            </div>
        </div>
        <div class="form-outer-group">
            <div class="form-group row">
                <label>강의명<b>*</b></label>
                <div><input type="text" class="form-control" id="lecture_name"></div>
            </div>
            <div class="form-group row">
                <label>강의과목<b>*</b></label>
                <div><span id="sel_lectureSubject"></span></div>
            </div>
            <div class="form-group row">
                <label>강의기간단위<b>*</b></label>
                <div><span id="sel_lectureOperation"></span></div>
            </div>
        </div>
        <div class="form-outer-group">
            <div class="form-group row">
                <label>학교구분<b>*</b></label>
                <div>
                    <div class="checkbox_t1">
                        <label><input type="radio" name="school_type" value="elem_list" onclick="school_radio(this.value);" checked><span>초등학교</span></label>
                        <label><input type="radio" name="school_type" value="midd_list" onclick="school_radio(this.value);"><span>중학교</span></label>
                        <label><input type="radio" name="school_type" value="high_list" onclick="school_radio(this.value);"><span>고등학교</span></label>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label>학년<b>*</b></label>
                <div><span id="student_grade"></span></div>
            </div>
        </div>
        <div class="form-outer-group">
            <div class="form-group row">
                <label>가격<b>*</b></label>
                <div><span id="lecture_price"></span></div>
            </div>
            <div class="form-group row">
                <label>레벨<b>*</b></label>
                <span id="lecture_level"></span>
            </div>
        </div>
        <div class="form-outer-group">
            <div class="form-group row">
                <label>시작일<b>*</b></label>
                <div><input type="text" id="startDate" class="form-control date-picker" style="width:200px;"></div>
            </div>
            <div class="form-group row">
                <label>종료일<b>*</b></label>
                <div><input type="text" id="startDate2" class="form-control date-picker" style="width:200px;"></div>
            </div>
        </div>
        <div class="form-outer-group">
            <div class="form-group row">
                <label>강의정원명<b>*</b></label>
                <div><span id="sel_lectureStudentlimit"></span></div>
            </div>
            <div class="form-group row">
                <label>강의상태<b>*</b></label>
                <div><span id="sel_lectureStatus"></span></div>
            </div>
        </div>
    </form>
</section>
<!------------------------강의상세정보시작--------------------------------->
<section class="content">
    <h3 class="title_t1">강의시간표설정</h3>
    <div class="bot_btns">
        <button class="btn_pack blue s2" type="button" id="addBtn"  onclick="dupcheck_lecture_room();">추가</button>
        <button class="btn_pack blue s2" type="button"  onclick="save_lecture_info();">저장</button>
    </div>
    <div class="form-group row"></div>
    <form name="lecture_detail" class="form_st1">
        <div class="clonedDiv" id="input1">
            <input type="hidden" name="lecture_detail_id[]" value=""><!--강의상세정보아이디-->
            <div class="form-group row"><!--강의상세정보-->
                <div class="checkbox_t1">
                    <label id="lectureRoomSelectbox"></label>
                    <label id="start_time_input_1"><input type="text" class="form-control date-picker" id="start_time_1" name="start_time[]" placeholder="강의시작시간"></label>
                    <label id="end_time_input_1"><input type="text" class="form-control date-picker" id="end_time" name="end_time[]" placeholder="강의종료시간"></label>
                    <label id="lectureDaySelectbox"></label>
                </div>
            </div>
        </div>
    </form>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>
