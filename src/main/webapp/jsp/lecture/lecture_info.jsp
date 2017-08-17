<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>

<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<link rel="stylesheet" href="//cdn.rawgit.com/fgelinas/timepicker/master/jquery.ui.timepicker.css">
<style>
    /*초기화와 메뉴폭 지정*/
    #navi{padding:0;width:200px;margin:0;}
    #navi h2{margin: 0;padding: 0;}
    /*메인메뉴 스타일 지정*/
    #navi h2 a{display: block;font-weight: bold;text-decoration: none;margin: 0;padding: 10px;font-family:'돋움', sans-serif;font-size: 14px;color: #ccc;text-shadow: 0 1px 1px #000; background:#1d4ab3;background: -moz-linear-gradient(#1d4ab3 0%, #163887 100%);background: -webkit-linear-gradient(#1d4ab3 0%, #163887 100%);background: -o-linear-gradient(#1d4ab3 0%, #163887 100%);background: linear-gradient(#1d4ab3 0%, #163887 100%);}

    /*메인 메뉴에 대한 마우스 이벤트에 대한 효과 지정*/
    #navi :target h2 a,
    #navi h2 a:focus,
    #navi h2 a:hover,
    #navi h2 a:active{background:#1a1a1a;background:-moz-linear-gradient(#1a1a1a 0%, #000000 100%);background:-webkit-linear-gradient(#1a1a1a 0%, #000000 100%);background:-o-linear-gradient(#1a1a1a 0%, #000000 100%);background:linear-gradient(#1a1a1a 0%, #000000 100%);color:#eee;text-shadow: 0 1px 1px #000000;}
</style>
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

    function lecture_go(val) {
        if(val=="price"){
            goPage('lecture','lecture_price');
        }else if(val=="room"){
            goPage('lecture','lecture_room');
        }
    }

    function school_radio(school_grade) {
        schoolSelectbox("student_grade","", school_grade);
    }

    function academy_sel_change(val) {
        init(val);
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

    
    function save_lecture_info() {
        var price_list = new Array();
        var start_time_list = new Array();
        $('select[name="sel_lecturePrice[]"]').each(function () {
            //   alert($(this).val());
            price_list.push($(this).val());
        });

        $('select[name="start_time[]"]').each(function () {
            //   alert($(this).val());
            start_time_list.push($(this).val());
        });
        alert(start_time_list);

    }

    $(document).ready(function () {
            $("#start_time_2").timepicker({
                hourText: '시',
                minuteText: '분'
            });
            $.timepicker.setDefaults($.timepicker.regional['ko']);
    });

</script>
<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <div id="navi">
        <div id="menu1">
            <h2><a href="">강의관리</a></h2>
            <p><a onclick="lecture_go('price');">강의가격</a></p>
            <p><a onclick="lecture_go('room');">강의룸</a></p>
        </div>
    </div>
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
                    <input type="text" id="">
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
    <input type="button" value="추가" class="add_btn" id="addBtn" onclick="trans_html();">
    <input type="button" value="저장" onclick="save_lecture_info();">
    <div id="input1" class="clonedDiv">
      <table border="1">
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
      </table>
        <br>
    </div>
</form>

</body>
</html>
