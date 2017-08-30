<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
%>
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
        var detailId = $('input[name="lecture_detail_id[]"]').eq(0).val();
        var sel_lectureRoom = $('select[name="sel_lectureRoom[]"]').last().val();
        var sel_lectureDay = $('select[name="lecture_day[]"]').last().val();
        var start_time = $('input[name="start_time[]"]').last().val();
        var end_time = $('input[name="end_time[]"]').last().val();

        if (detailId == null) {
            lectureService.checkDuplicateLectureDetail(sel_lectureRoom, start_time, end_time, sel_lectureDay, function (bl) {
                if (bl == true) {
                    alert("등록할수없는 시간대와 강의실 입니다.\n다른 시간대와 강의실을 선택하세요.");
                    $('input[name="start_time[]"]').last().val("");
                    $('input[name="end_time[]"]').last().val("");
                }
            });
        }else{
            trans_html();
        }
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
        newElem.find('#lectureRoomSelectbox').after("<input type='button' class='btn_less1' onclick='del_html();' value='삭제' id='del_btn'/>")
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
    function modify_lecture_info() {
        var end_time_list = new Array();
        var start_time_list = new Array();
        var room_list = new Array();
        var day_list = new Array();
        var lecture_detail_id_list = new Array();

        var lecture_id   = getInputTextValue("lecture_id");
        var sel_academy  = getSelectboxValue("sel_academyList2");//관선택
        var manager      = getSelectboxValue("sel_teacherList2");//관리선생님
        var teacher      = getSelectboxValue("sel_teacherList");//담당선생님
        var sel_price    = getSelectboxValue("sel_lecturePrice");//가격
        var lecture_name = getInputTextValue("lecture_name");//강의명
        var lecture_subject   =  getSelectboxValue("sel_lectureSubject"); //강의과목
        var school_type    = get_radio_value("school_type");//학교구분
        var sel_school     = getSelectboxValue("sel_school");//학년
        var lecture_level  = get_radio_value("lecture_level");//레벨
        var lecture_operation = getSelectboxValue("sel_lectureOperationTypeList");//강의기간단위
        var lecture_start  = getInputTextValue("startDate");//강의시작일
        var lecture_end    = getInputTextValue("startDate2");//강의종료일
        var lecture_student_limit   = getSelectboxValue("sel_lectureStudentLimitList");//강의인원수
        var lecture_state  = getSelectboxValue("sel_lectureStatusList");//강의상태
        var lecture_info   = {
            lectureId : lecture_id,
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

        $('select[name="sel_lectureRoom[]"]').each(function () {
            room_list.push($(this).val());
        });
        $('select[name="lecture_day[]"]').each(function () {
            day_list.push($(this).val());
        });
        $('input[name="start_time[]"]').each(function () {
            start_time_list.push($(this).val());
        });
        $('input[name="end_time[]"]').each(function () {
            end_time_list.push($(this).val());
        });
        $('input[name="lecture_detail_id[]"]').each(function () {
            lecture_detail_id_list.push($(this).val());
        });
        var num = $('.clonedDiv').length;
        var detail_list = new Array();


        for(var i=0; i < num ; i++){
            var lecture_detail_info = {
                lectureRoomId: room_list[i],
                startTime: start_time_list[i],
                endTime: end_time_list[i],
                lectureDay: day_list[i],
                lectureDetailId :lecture_detail_id_list[i],
                lectureId:lecture_id
            };

            detail_list.push(lecture_detail_info);
        }
        lectureManager.modifyLecture(lecture_info, detail_list, function (bl) {
            alert(bl);
        });

    }

    function lecture_detail_List() {
        var lecture_id        = getInputTextValue("lecture_id");
        lectureService.getLectureInfo( lecture_id, function (selList) {

            academyListSelectbox2("sel_academy", selList.officeId);
            lectureOperationTypeSelectbox("sel_lectureOperation",selList.lectureOperationType);
            lectureStatusSelectbox("sel_lectureStatus",selList.lectureStatus,"50");
            lectureStudentLimitSelectbox("sel_lectureStudentlimit",selList.lectureLimitStudent, "30");
            schoolSelectbox("student_grade", selList.lectureGrade, selList.schoolType);
            lectureSubjectSelectbox("sel_lectureSubject",selList.lectureSubject);
           // lectureLevelRadio("lecture_level","HIGH","");
            lecturePriceSelectbox("lecture_price", selList.lecturePriceId);
            teacherList(selList.officeId, "sel_member", selList.manageMemberId);
            teacherList2(selList.officeId,"sel_member2",selList.chargeMemberId);
            innerValue("lecture_name", selList.lectureName);
            innerValue("startDate", selList.lectureStartDate);
            innerValue("startDate2", selList.lectureEndDate);
            //lectureDaySelectbox("lectureDaySelectbox","");
            //lectureRoomSelectbox(office_id,"lectureRoomSelectbox","");
        });

        lectureService.getLectureDetailInfoList(lecture_id, function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (selList != undefined && selList.length > 0) {
                        if(i > 0)  trans_html();
                        $('select[name="sel_lectureRoom[]"]').eq(i).val(cmpList.lectureRoomId);
                        $('select[name="lecture_day[]"]').eq(i).val(cmpList.lectureDay);
                        $('input[name="start_time[]"]').eq(i).val(cmpList.startTime);
                        $('input[name="end_time[]"]').eq(i).val(cmpList.endTime);
                        $('input[name="lecture_detail_id[]"]').eq(i).val(cmpList.lectureDetailId);
                    }
                }
            }
        });
    }

</script>
<body onload="init(); lecture_detail_List();">
<form name="frm" id="frm" method="post">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lecture_id%>">
    <div id="lectureInfo">
        <h1>강의정보입력</h1>
        <table>
            <tr>
                <th>관선택</th>
                <td>
                    <span id="sel_academy"></span>
                </td>
            </tr>
            <tr>
                <th>관리선생님</th>
                <td>
                    <span id="sel_member2"></span>
                </td>
            </tr>
            <tr>
                <th>담당선생님</th>
                <td>
                    <span id="sel_member"></span>
                </td>
            </tr>
            <tr>
                <th>가격</th>
                <td>
                    <span id="lecture_price"></span>
                </td>
            </tr>
            <tr>
                <th>강의명</th>
                <td>
                    <input type="text" id="lecture_name">
                </td>
            </tr>
            <tr>
                <th>강의과목</th>
                <td>
                    <span id="sel_lectureSubject"> </span>
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
                <th>학년</th>
                <td>
                    <span id="student_grade"></span>
                </td>
            </tr>
            <tr>
                <th>레벨</th>
                <td>
                    <span id="lecture_level"></span>
                </td>
            </tr>
            <tr>
                <th>강의기간단위</th>
                <td>
                    <span id="sel_lectureOperation"></span>
                </td>
            </tr>
            <tr>
                <th>시작일</th>
                <td>
                    <input type="text" id="startDate">
                </td>
            </tr>
            <tr>
                <th>종료일</th>
                <td>
                    <input type="text" id="startDate2">
                </td>
            </tr>
            <tr>
                <th>강의정원명</th>
                <td>
                    <span id="sel_lectureStudentlimit"></span>
                </td>
            </tr>
            <tr>
                <th>강의상태</th>
                <td>
                    <span id="sel_lectureStatus"></span>
                </td>
            </tr>
        </table>
    </div>
    <h2>강의 상세정보 입력</h2>
    <input type="button" value="추가" class="add_btn" id="addBtn" onclick="dupcheck_lecture_room();">
    <input type="button" value="수정" onclick="modify_lecture_info();">
    <div id="input1" class="clonedDiv">
        <table border="1">
            <input type="hidden" name="lecture_detail_id[]" value="">
            <tr>
                <th>강의실선택</th>
                <td>
                    <span id="lectureRoomSelectbox"></span>
                </td>
            </tr>
            <tr>
                <th>강의시작시간</th>
                <td id="start_time_input_1">
                    <input type="text" id="start_time_1" name="start_time[]">
                </td>
            </tr>
            <tr>
                <th>강의종료시간</th>
                <td id="end_time_input_1">
                    <input type="text" id="end_time" name="end_time[]">
                </td>
            </tr>
            <tr>
                <th>강의요일</th>
                <td>
                    <span id="lectureDaySelectbox"></span>
                </td>
            </tr>
            <tbody id="dataList"></tbody>
        </table>
        <br>
    </div>

</form>

</body>
</html>
