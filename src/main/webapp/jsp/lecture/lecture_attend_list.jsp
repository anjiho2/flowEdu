<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureManager.js'></script>
<script type="text/javascript">

    function init() {
        myClassSelectbox("sel_myClass");

    }

    function fn_search() {
        dwr.util.removeAllRows("dataList");

        var selMyclass = getSelectboxValue('sel_myClass');

        if(selMyclass == "") alert(comment.input_myclass_type);

        var studentName = getInputTextValue("student_name");
        var searchDate  = getInputTextValue("endDate");

        lectureService.getLectureAttendListBySearch(selMyclass, studentName, searchDate, function (selList) {
            if(selList.length > 0){
                //$("#allStudent").text(selList.length); //전체 인원수 표시
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

                 //alert(cmpList.attendStartTime.length);
                 var checkHTML = "<input type='checkbox' class='form-control' name='chkList' value="+cmpList.studentId+" "+ check_start +">";
                 var class_attend_time = "<input type='text' class='form-control' name='start_time[]' id='class_start_"+ cmpList.studentId +"' value='"+ startTime +"' "+ isDisabled_start +">"; //등원시간
                 var class_close_time = "<input type='text' class='form-control' name='end_time[]' id='class_close_"+ cmpList.studentId +"' value='"+ endTime +"' "+ isDisabled_end +">"; //하원시간
                 var class_attend_memo = "<input type='text' class='form-control' name='memo[]' id='class_memo_"+ cmpList.studentId+"' value='"+ comment +"'>"; //메모
                 if(cmpList != undefined){
                        var cellData =[
                          function (data) {return checkHTML},
                          function (data) {return i+1},
                          function (data) {return cmpList.studentName},
                          function (data) {return class_attend_time},
                          function (data) {return class_close_time},
                          function (data) {return class_attend_memo}
                        ];
                     dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                 }
             }
            }
        });
    }

    $(function(){ //체크박스
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
        var start_time_list = get_array_values_by_name("input", "start_time[]");
        var end_time_list = get_array_values_by_name("input", "end_time[]");
        var memo_list = get_array_values_by_name("input", "memo[]");
        var attend_type = $("#attend_type").val();

        if (attend_type == Number("5")) {
            start_time_list = null;
        }
        $('input:checkbox[name=chkList]').each(function(i) {
            var attend_detail_info;
            if($(this).is(':checked')){
                if (start_time_list == null || start_time_list == undefined) {
                    attend_detail_info = {
                        lectureId: sel_myclass,
                        studentId: $(this).val(),
                        attendStartTime: "",
                        attendEndTime: end_time_list[i],
                        attendModifyComment: memo_list[i],
                        attendType: attend_type,
                    };
                } else {
                    attend_detail_info = {
                        lectureId: sel_myclass,
                        studentId: $(this).val(),
                        attendStartTime: start_time_list[i],
                        attendEndTime: end_time_list[i],
                        attendModifyComment: memo_list[i],
                        attendType: attend_type,
                    };
                }
            }
            attend_list.push(attend_detail_info)
        });
        console.log(attend_list);

       if(confirm(comment.isUpdate)){
            lectureManager.attendLecture(attend_list, function (bl) {
               if(bl == true){
                    switch (attend_type){
                        case '0':
                            alert("등원 하였습니다.");
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
                            alert("하원 하였습니다.");
                            break;
                        }
                   goPage("lecture","lecture_attend_list");
               }else{
                   alert("출석정보 저장중 오류발생하였습니다. 관리자문의 부탁드립니다.");
               }
         });
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

</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
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
            <table>
                <tbody>
                    <tr style="text-align: center;">
                        <td colspan="6">
                            [전체 : <span id="allStudent"></span>]&nbsp;
                            [등원 : <span id="">0</span>]&nbsp;
                            [지각 : <span>0</span>]&nbsp;
                            [조퇴 : <span>0</span>]&nbsp;
                            [결석 : <span>0</span>]
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
                <button class="btn_pack black" id="late_btn">지각</button>
                <button class="btn_pack black" id="leave_btn">조퇴</button>
                <button class="btn_pack black" id="absent_btn">결석</button>
                <button class="btn_pack black" id="makeup_btn">보강</button>
                <button class="btn_pack black" id="dismiss_btn" onclick="getTimeStamp('chkList', 'close')">하원</button>
            </div>
        </div>
    </section><!--content-->



<%@include file="/common/jsp/footer.jsp" %>
</body>
<script>
    $(".sidebar-menu > li").eq(2).addClass("active");
    $(".sidebar-menu > li:nth-child(3) > ul > li:nth-child(1) > a").addClass("on");
</script>
