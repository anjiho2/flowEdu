<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
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
                console.log(selList);
                for(var i = 0; i < selList.length; i++){
                    var cmpList = selList[i];
                    var checkHTML = "<input type='checkbox' class='form-control' name='chkList' value="+cmpList.studentId+" checked>";
                    var class_attend_time =  "<input type='text' class='form-control' id='class_start_"+ cmpList.studentId +"'>"; //등원시간
                    var class_close_time =  "<input type='text' class='form-control' id='class_close_"+ cmpList.studentId +"'>"; //하원시간
                    var class_attend_memo =  "<input type='text' class='form-control' id='class_memo_"+ cmpList.studentId+"'>"; //메모
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


</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
</div>
</section>
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
</form>

<section class="content">
    <div class="title_top">학습관리</div>
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
                    [전체 : <span>5</span>]&nbsp;
                    [등원 : <span>0</span>]&nbsp;
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
            <!--<tbody>
                <tr>
                    <td><input type="checkbox" class="form-control" name="" value=""></td>
                    <td>5</td>
                    <td>이성우</td>
                    <td><input type="text" class="form-control"></td>
                    <td><input type="text" class="form-control"></td>
                    <td><input type="text" class="form-control"></td>
                </tr>
            </tbody>-->
        </table>
        <button class="btn_pack blue s2">저장</button>
        <div style="float: right; margin-top:5px;">
            <button class="btn_pack black" onclick="getTimeStamp('chkList')">등원</button>
            <button class="btn_pack black">지각</button>
            <button class="btn_pack black">조퇴</button>
            <button class="btn_pack black">결석</button>
            <button class="btn_pack black">보강</button>
            <button class="btn_pack black">하원</button>
        </div>
    </div>
</section><!--content-->



<%@include file="/common/jsp/footer.jsp" %>
</body>
<script>
    $(".sidebar-menu > li").eq(2).addClass("active");
    $(".sidebar-menu > li:nth-child(3) > ul > li:nth-child(1) > a").addClass("on");
</script>