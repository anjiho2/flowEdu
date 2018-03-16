<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int siderMenuDepth1 = 2;
    int siderMenuDepth2 = 3;
    int siderMenuDepth3 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureManager.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

    var student_ids = new Array();

    function init() {
        myClassSelectbox("sel_myClass");
        gfn_emptyView("V", comment.attend_class_type);
    }

    function fn_search() {
        dwr.util.removeAllRows("dataList");

        var selMyclass = getSelectboxValue('sel_myClass');

        if(selMyclass == "") alert(comment.input_myclass_type);

        var studentName = getInputTextValue("student_name");
        var searchDate  = getInputTextValue("endDate");
        var start_student_num=0;
        var late_student_num=0;
        var leave_student_num=0;
        var absent_student_num=0;
        lectureService.getLectureAttendListBySearch(selMyclass, studentName, searchDate, function (selList) {
            if(selList.length > 0){
                $("#allStudent").html(selList.length); //전체학생수
             for(var i = 0; i < selList.length; i++){
                 var cmpList = selList[i];
                 var startTime = cmpList.attendStartTime == null ? '' : cmpList.attendStartTime; //등원시간
                 var endTime = cmpList.attendEndTime == null ? '' : cmpList.attendEndTime; // 하원시간
                 var comment = cmpList.attendModifyComment == null ? '' : cmpList.attendModifyComment; //메모
                 var isDisabled_start = 'disabled';
                 var isDisabled_end = 'disabled';
                 var check_start = 'checked';

                 if(cmpList.attendStartTime == null)  var isDisabled_start = '';
                 if(cmpList.attendEndTime == null) var isDisabled_end = '';
                 if(cmpList.attendType == 1 || cmpList.attendType == 2 || cmpList.attendType == 3 ) {//지각,조퇴,결석 학생이름 강조
                     var studnet_name_class = "style='color:red'";
                 }

                 /*인원수 체크*/
                 if(cmpList.attendType == 0) start_student_num++;
                 if(cmpList.attendType == 1) late_student_num++;
                 if(cmpList.attendType == 2) leave_student_num++;
                 if(cmpList.attendType == 3) absent_student_num++;
                 $("#start_student_num").html(start_student_num);
                 $("#late_student_num").html(late_student_num);
                 $("#leave_student_num").html(leave_student_num);
                 $("#absent_student_num").html(absent_student_num);

                 innerValue("l_attendId", cmpList.lectureAttendId);

                 var class_student_name = "<span " + studnet_name_class +" name='student_name[]'>"+cmpList.studentName+"</span>";
                 var checkHTML = "<input type='checkbox' class='form-control' name='chkList' value="+cmpList.studentId+" "+ check_start +">";
                 var class_attend_time = "<input type='text' class='form-control test1' name='start_time[]' id='class_start_"+ cmpList.studentId +"' value='"+ startTime +"' "+ isDisabled_start +">"; //등원시간
                 var class_close_time = "<input type='text' class='form-control' name='end_time[]' id='class_close_"+ cmpList.studentId +"' value='"+ endTime +"' "+ isDisabled_end +">"; //하원시간
                 var class_attend_memo = "<input type='text' class='form-control' name='memo[]' id='class_memo_"+ cmpList.studentId+"' value='"+ comment +"'>"; //메모
                 if(cmpList != undefined){
                        var cellData =[
                          function (data) {return checkHTML},
                          function (data) {return i+1},
                          function (data) {return class_student_name},
                          function (data) {return class_attend_time},
                          function (data) {return class_close_time},
                          function (data) {return class_attend_memo}
                        ];
                     dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                 }
             }
                function formatter(selList) {
                    return "<input type=hidden id='attendId_"+ selList.studentId +"' value="+selList.lectureAttendId +">";
                }
                dwr.util.addOptions("dataList2", selList, formatter, {escapeHtml: false}); //lecture_attend_id 값 ul태그
            }else{
                gfn_emptyView("V", "검색결과가 없습니다.");
            }
        });
    }

    $(function(){//처음화면 allcheck처리 함수
        $("#checkAll").click(function(){
            if($("#checkAll").prop("checked")) {
            $("input[type=checkbox]").prop("checked",true);}
            else {
                $("input[type=checkbox]").prop("checked",false);
            }
        });
    });

    function save_attend_lecture() {
        var attend_list  = new Array();
        var sel_myclass = getSelectboxValue('sel_myClass');
        var attend_type = $("#attend_type").val(); //출결타입

        //등원시간/하원시간/메모 체크된값 가져오기
        var start_time_array  = new Array()
        var end_time_array  = new Array();
        var memo_list_array  = new Array();
        var student_name_list_array  = new Array();
        for (var i = 2; i < $('table tr').size(); i++) {

            var chk = $('table tr').eq(i).children().find('input[type="checkbox"]').is(':checked');
            if (chk == true) {
                var start_time_list =  $('table tr').eq(i).find('input[name="start_time[]"]').val();
                var end_time_list   =  $('table tr').eq(i).find('input[name="end_time[]"]').val();
                var memo_list       =  $('table tr').eq(i).find('input[name="memo[]"]').val();
                var student_name_list  =  $('table tr').eq(i).find('span[name="student_name[]"]').text();
                /*var isChange = false;
                $('input[name="memo[]"]').change(function () {
                    isChange = true;
                    alert(isChange);
                });
                if(start_time_list != '' && end_time_list != '' ){
                    alert("기능을 입력할수 없습니다.");
                    return;
                }*/
                start_time_array.push(start_time_list);
                end_time_array.push(end_time_list);
                memo_list_array.push(memo_list);
                student_name_list_array.push(student_name_list);
            }
        }

        if (attend_type == Number("5")) start_time_list = null;

        $('input:checkbox[name=chkList]:checked').each(function(i) {
            var attend_detail_info;
            var lecture_attend_id =  $("#attendId_"+$(this).val()).val();

                if(lecture_attend_id != "null"){
                    if(attend_type == 1 || attend_type == 0){
                        alert( student_name_list_array[i] + "학생은 이미 등원처리가 된 학생입니다.");
                        return false;
                    }
                }
                if(lecture_attend_id == "null"){ //등원텍스트박스
                   if(start_time_array[i] == "" && end_time_array[i] != "") {//등원이 입력안됬을때, 하원 or 조퇴 저장시
                       alert(student_name_list_array[i] + "학생은 등원하지 않은학생입니다.");
                       return;
                   }
                      attend_detail_info = {
                          lectureId: sel_myclass,
                          studentId: $(this).val(),
                          attendStartTime: start_time_array[i],
                          attendEndTime: end_time_array[i],
                          attendModifyComment: memo_list_array[i],
                          attendType: attend_type,
                      };
                }else{ //학원텍스트박스
                       attend_detail_info = {
                           lectureAttendId: lecture_attend_id,
                           lectureId: sel_myclass,
                           studentId: $(this).val(),
                           attendStartTime: "",
                           attendEndTime: end_time_array[i],
                           attendModifyComment: memo_list_array[i],
                           attendType: attend_type,
                       };
               }
            attend_list.push(attend_detail_info)
        });


        if(attend_list.length > 0 ) {
            var comment_id;

            if(attend_type == 0) comment = "등원 처리 하시겠습니까?";
            if(attend_type == 1) comment = "지각 처리 하시겠습니까?";
            if(attend_type == 2) comment = "조퇴 처리 하시겠습니까?";
            if(attend_type == 3) comment = "결석 처리 하시겠습니까?";
            if(attend_type == 4) comment = "보강 처리 하시겠습니까?";
            if(attend_type == 5) comment = "하원 처리 하시겠습니까?";

            if (confirm(comment)) {
                lectureManager.attendLecture(attend_list, function (bl) {
                    if (bl == true) {
                        switch (attend_type) {
                            case '0':
                                alert("등원처리 완료되었습니다..");
                                break;
                            case '1':
                                alert("지각저장");
                                break;
                            case '2':
                                alert("조퇴저장");
                                break;
                            case '3':
                                alert("결석저장");
                                break;
                            case '4':
                                alert("보강저장");
                                break;
                            case '5':
                                alert("하원처리 완료되었습니다.");
                                break;
                        }
                        goPage("lecture", "lecture_attend_list");
                    } else {
                        alert("출석정보 저장중 오류발생하였습니다. 관리자문의 부탁드립니다.");
                    }
                });
            }
        }
     }

    $(function () { //출결타입설정
        $("#start_btn").click(function () {
            $("#attend_type").val(0);
        });
        $("#late_btn").click(function () {
            $("#attend_type").val(1);
        });
        $("#leave_btn").click(function () {
            $("#attend_type").val(2);
        });
        $("#absent_btn").click(function () {
            $("#attend_type").val(3);
        });
        $("#makeup_btn").click(function () {
            $("#attend_type").val(4);
        });
        $("#dismiss_btn").click(function () {
            $("#attend_type").val(5);
        });
    });

    $(document).ready(function () {
        /*
        $(window).on("beforeunload", function () {
            if (isChange) {
                return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
            }
        });
        */
        $("#btn1").click(function(){
            isChange = false;
        });
    });
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <div class="title-top">학습관리</div>
</div>
</section>
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="attend_type" id="attend_type">
</form>
    <section class="content">
        <h3 class="title_t1">출결 관리</h3>
        <div class="form-outer-group">
            <div class="form-group row">
                <select id="sel_myClass" class="form-control">
                    <option value="">▶강의선택</option>
                </select>
            </div>
            <div class="form-group row">
                <input type="text" class="form-control" id="student_name" placeholder="학생 이름을 입력하세요.">
            </div>
            <div class="form-group row">
                <div class="input-group date" style="width:250px">
                    <input type="text" id="endDate" class="form-control date-picker" placeholder="검색일">
                    <span class="input-group-addon" id="datepicker_img2">
                    <span class="fa fa-calendar"></span>
                </span>
                </div>
            </div>
            <div class="form-group row">
                <button class="btn_pack blue" type="button" onclick="fn_search();">검색</button>
            </div>
        </div>

        <div class="tb_t1 attend_tb1">
            <table class="tm">
                <tbody>
                    <tr style="text-align: center;">
                        <td colspan="6">
                            [전체 : <span id="allStudent"></span>]&nbsp;
                            [등원 : <span id="start_student_num">0</span>]&nbsp;
                            [지각 : <span id="late_student_num">0</span>]&nbsp;
                            [조퇴 : <span id="leaver_student_num">0</span>]&nbsp;
                            [결석 : <span id="absent_student_num">0</span>]
                        </td>
                    </tr>
                </tbody>
                <tbody>
                    <tr>
                        <th><input type="checkbox" class="form-control" name="checkAll" id="checkAll" checked></th>
                        <th>No.</th>
                        <th>이름</th>
                        <th>등원시간</th>
                        <th>하원시간</th>
                        <th>메모</th>
                    </tr>
                </tbody>
                <tbody id="dataList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
            <button class="btn_pack blue s2" onclick="save_attend_lecture()">저장</button>
            <div style="float: right; margin-top:5px;">
                <button class="btn_pack black" id="start_btn" onclick="getTimeStamp('chkList', 'start')">등원</button>
                <button class="btn_pack black" id="late_btn" onclick="getTimeStamp('chkList', 'start')">지각</button>
                <button class="btn_pack black" id="leave_btn" onclick="getTimeStamp('chkList', 'close')">조퇴</button>
                <button class="btn_pack black btngray btn" id="absent_btn" onclick="openDaumPostcode()">결석</button>
                <button class="btn_pack black" id="makeup_btn">보강</button>
                <button class="btn_pack black" id="dismiss_btn" onclick="getTimeStamp('chkList', 'close')">하원</button>
            </div>

            <ul id="dataList2"></ul>
        </div>
    </section><!--content-->
<%@include file="/common/jsp/footer.jsp" %>
</body>
