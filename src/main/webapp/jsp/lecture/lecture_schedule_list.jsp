<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String lectureId = Util.isNullValue(request.getParameter("lecture_id"), "");

    int depth1 = 4;
    int depth2 = 2;

    int siderMenuDepth1 = 4;
    int siderMenuDepth2 = 5;
    int siderMenuDepth3 = 3;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<link rel="stylesheet" href="//cdn.rawgit.com/fgelinas/timepicker/master/jquery.ui.timepicker.css">
<script>
    function init2() {
        var lectureId = '<%=lectureId%>';

        if (lectureId == "") return;

        lectureService.getLectureDetailInfoList(lectureId, function (selList) {
            if (selList.length == 0) return;
            for (var i=0; i<selList.length; i++) {
                var cmpList = selList[i];
                var cellData = [
                    function(data) { return "<input type=\"hidden\" name=\"lectureRoomId[]\" class=\"form-control\" id='lectureRoomId_" + i + "' value='" + cmpList.lectureRoomId + "'>" +
                                            "<input type=\"hidden\" name=\"lectureDetailId[]\" class=\"form-control\" id='lectureDetailId_" + i + "' value='" + cmpList.lectureDetailId + "'>" +
                                            "<select id='day_" + i + "' name=\"lecture_day[]\" class=\"form-control\"><option value=\"\">▶요일선택</option><option value=\"SUN\">일요일</option><option value=\"MON\">월요일</option><option value=\"TUE\">화요일</option><option value=\"WEN\">수요일</option><option value=\"THU\">목요일</option><option value=\"FRI\">금요일</option><option value=\"SAT\">토요일</option></select>" },
                    function(data) { return "<input type=\"text\" name=\"startTime[]\" class=\"form-control\" id='startTime_" + i + "' value='" + cmpList.startTime + "'>" },
                    function(data) { return "<input type=\"text\" name=\"endTime[]\" class=\"form-control\" id='endTime_" + i + "' value='" + cmpList.endTime + "'>" },
                    function(data) { return "<div class=\"form-group row marginX draghandle\">\n" +
                        "                            <input type=\"text\" class=\"form-control hasTimepicker\" name=\"roonName[]\" id='roomName_" + i + "' value='" + cmpList.lectureRoomName + "'  onclick='open_lecture_room(this.id);'>\n" +
                        "                            <button type=\"button\" class=\"fa fa-close\" aria-label=\"Close\" value='" + i +"' onclick='del_html(this.value)'>\n" +
                        "                            </button>\n" +
                        "                        </div>" },
                ];
                dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                $("#day_"+i).val(cmpList.lectureDay);
                $("#timeTableList").find("tbody").find("tr:last").attr("id", "tr_"+i);
            }
            /** timepicker 바인딩 하기 **/
            var elem1 = $("#timeTableList tbody tr td input[name='startTime[]']");
            elem1.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem2 = $("#timeTableList tbody tr td input[name='endTime[]']");
            elem2.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            $.timepicker.setDefaults($.timepicker.regional['ko']);
        });
    }
    //등록버튼 (리스트 복제하기)
    function trans_row() {
        var trLen = $("#timeTableList tbody tr").length;

        if (trLen == 0) {
            var i = getInputTextValue("num");
            var j = trLen + 1;

            var cellData = [
                function(data) { return "<input type=\"hidden\" name=\"lectureRoomId[]\" class=\"form-control\" id='lectureRoomId_" + i + "'><select id='day_" + i + "' name=\"lecture_day[]\" class=\"form-control\"><option value=\"\">▶요일선택</option><option value=\"SUN\">일요일</option><option value=\"MON\">월요일</option><option value=\"TUE\">화요일</option><option value=\"WEN\">수요일</option><option value=\"THU\">목요일</option><option value=\"FRI\">금요일</option><option value=\"SAT\">토요일</option></select>" },
                function(data) { return "<input type=\"text\" name=\"startTime[]\" class=\"form-control\" id='startTime_" + i + "'>" },
                function(data) { return "<input type=\"text\" name=\"endTime[]\" class=\"form-control\" id='endTime_" + i + "'>" },
                function(data) { return "<div class=\"form-group row marginX draghandle\">\n" +
                    "                            <input type=\"text\" class=\"form-control hasTimepicker\" name=\"roonName[]\" id='roomName_" + i + "' onclick='open_lecture_room(this.id);'>\n" +
                    "                            <button type=\"button\" class=\"fa fa-close\" aria-label=\"Close\" value='" + i +"' onclick='del_html(this.value)'>\n" +
                    "                            </button>\n" +
                    "                        </div>" },
            ];
            innerValue("num", ++i);
            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
            $("#timeTableList").find("tbody").find("tr:last").attr("id", "tr_"+i);

            /** timepicker 바인딩 하기 **/
            var elem1 = $("#timeTableList tbody tr td input[name='startTime[]']");
            elem1.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem2 = $("#timeTableList tbody tr td input[name='endTime[]']");
            elem2.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            $.timepicker.setDefaults($.timepicker.regional['ko']);
        } else {
            var newNum = trLen + 1;
            var $tableBody = $("#timeTableList").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();

            $trLast.after($trNew);

            $trNew.attr("id", "tr_" + trLen);
            $trNew.find("td input").eq(0).val('').attr("id", "lectureRoomId_" + trLen);
            $trNew.find("td input[name='lectureDetailId[]']").eq(0).val('').attr("id", "lectureDetailId_" + trLen);
            $trNew.find("td select").eq(0).val('').attr("id", "day_" + trLen);
            $trNew.find("td input").eq(1).val('');
            $trNew.find("td input").eq(2).val('').attr("id", "startTime_" + trLen);
            $trNew.find("td input").eq(3).val('').attr("id", "endTime" + trLen);
            $trNew.find("td input").eq(4).val('').attr("id", "roomName_" + trLen);
            /** timepicker 바인딩 하기 **/
            var elem1 = $("#timeTableList tbody tr td input[name='startTime[]']");
            elem1.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem2 = $("#timeTableList tbody tr td input[name='endTime[]']");
            elem2.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            $.timepicker.setDefaults($.timepicker.regional['ko']);
        }
    }
    //복제된 html 삭제하기
    function del_html(num) {
        if (num != "") {
            $('#tr_' + num).remove();
        }
    }
    //강의실 input 버튼 클릭시
    function open_lecture_room(val) {
        var val_arr = gfn_split(val, "_");
        var num = val_arr[1];

        var check = new isCheck();
        /** 필수 입력 값 체크 **/
        if (check.selectbox("day_"+num, comment.select_day) == false) return;
        if (check.input("startTime_"+num, comment.input_lecture_start_time) == false) return;
        if (check.input("endTime_"+num, comment.input_lecture_end_time) == false) return;

        innerValue("lectureRoomId", "lectureRoomId_"+num);
        innerValue("lectureDay", getSelectboxValue("day_"+num));
        innerValue("lectureStartTime", getInputTextValue("startTime_"+num));
        innerValue("lectureEndTime", getInputTextValue("endTime_"+num));

        innerValue("sel_academy", "");
        gfn_display("listDiv", false);
        $("#sel_academy").val('');
        //초기화하기
        for (var j=0; j<25; j++) {
            $("#class_"+j).attr('data-book', '');
            $("#class_"+j).addClass('class_btn class_btn_block class_btn_default');
            $("#class_"+j).find("input").val("");
        }
        initPopup($("#lectureRoomPopup"));
    }
    //강의실 리스트 불러오기
    function init(officeId) {
        if (officeId != "") {
            innerValue("isClassClick", "0");
            gfn_display("listDiv", true);
        }
        var spans = $('.ms-error');
        spans.text('');

        for (var k=1; k<=25; k++) {
            $("#td_"+k).hide();
            $("#class_"+k).attr('data-book', '');
            $("#class_"+k).addClass('class_btn class_btn_block class_btn_default');
            $("#class_"+k).find("input").val("");
        }

        var lectureDay = getInputTextValue("lectureDay");
        var lectureStartTime = getInputTextValue("lectureStartTime");
        var lectureEndTime = getInputTextValue("lectureEndTime");

        lectureService.getLectureRoomListByRegSuccess(officeId, lectureDay, lectureStartTime, lectureEndTime, function(selList) {
            if (selList.length == 0) return;
            //초기화하기
            for (var j=0; j<25; j++) {
                $("#class_"+j).attr('data-book', '0');
                $("#class_"+j).addClass('class_btn class_btn_block class_btn_default');
                $("#class_"+j).find("input").val("");
                //$("#class_"+j).find("input").after("<span class=\"ms-error\"></span>");
            }
            for (var i=0; i<selList.length; i++) {
                var j = i+1;
                $("#td_"+j).show();
                $("#class_"+j).removeClass();

                if (selList[i].cnt > 0)  {
                    $("#class_"+j).attr('data-book', '1');
                    $("#class_"+j).addClass('class_btn class_btn_block class_btn_checked');
                } else {
                    $("#class_"+j).addClass('class_btn class_btn_block class_btn_success');
                }
                $("#class_"+j).find("input").val(selList[i].lectureRoomId);
                $("#class_"+j).find("input").after("<span class=\"ms-error\">" + selList[i].lectureRoomName + " (" + selList[i].roomLimitStudent + ")</span>");
            }
        });
    }
    //강의실 최종 선택됬을때
    function selectLectureRoom() {
        $("input[name=class_check_list]:checked").each(function() {
            var classId = $(this).val();
            var classHTML = $(this).next().html();
            var classNames = gfn_split(classHTML, " ");
            var lectureRoomId = getInputTextValue("lectureRoomId");
            var nums = gfn_split(lectureRoomId, "_");

            innerValue("roomName_"+nums[1], classNames[0]);
            innerValue(lectureRoomId, classId);

            $("#sel_academy").val("");
            $("#close_btn").trigger("click");
            innerValue("isClassClick", "0");
        });
    }

    //강의실 리스트에 필요한 기능 바인딩 하기
    $(document).ready(function () {
        $(document).ready(function () {
            searchAcademySelectbox("sel_academy", "");
        });

        $("#classTable tbody td").each(function() {
            //var text = $(this).html();
            var isBook = $(this).find("label.class_btn").attr("data-book");
            if (isBook == 1) {
                $(this).find("label").addClass("class_btn class_btn_block class_btn_checked");
            }
        });

        $("label.class_btn").click(function() {
            var is_class = $(this).attr("data-book");
            if (is_class == "1") {
                alert("선택할 수 없는 강의실입니다.")
                return false;
            }
            //Find the child check box.
            var $input = $(this).find('input');

            $(this).toggleClass('class_btn_danger class_btn_success');
            //Remove the attribute if the button is "disabled"
            if ($(this).hasClass('class_btn_danger')) {
                var isClassClick = getInputTextValue("isClassClick");
                if (isClassClick == "1") {
                    alert("이미 강의실이 선택되었습니다.");
                    $(this).toggleClass('class_btn_danger class_btn_success');
                    return false;
                }
                $input.attr('checked', '');
                innerValue("isClassClick", "1");
            } else {
                $input.removeAttr('checked');
                innerValue("isClassClick", "0");
            }
            return false; //Click event is triggered twice and this prevents re-toggling of classes
        });
    });
    
    function saveLectueRoom() {
        var lectureRoomList = new Array();
        $("#timeTableList tbody tr").each(function () {
            var lectureDetailId = $(this).find("td input").next().eq(0).val();
            var lectureRoomId = $(this).find("td input").eq(0).val();
            var day = $(this).find("td select").eq(0).val();
            var startTime = $(this).find("td input").eq(2).val();
            var endTime = $(this).find("td input").eq(3).val();

            var lectureDetailInfo = {
                lectureId:'<%=lectureId%>',
                lectureDetailId:lectureDetailId,
                lectureRoomId:lectureRoomId,
                lectureDay:day,
                startTime:startTime,
                endTime:endTime
            }
            lectureRoomList.push(lectureDetailInfo);
        });
        if (lectureRoomList.length > 0) {
            if (confirm(comment.isSave)) {
                gfn_display("loadingbar", true);
                lectureService.saveLectureDetailInfo('<%=lectureId%>', lectureRoomList, function () {
                    isReloadPage(true);
                });
                gfn_display("loadingbar", false);
            }
        }
    }
</script>

<body onload="init2();">
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/lecture_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lectureId%>">
    </form>
    <div class="tb_t1">
        <input type="hidden" id="num" value="0">
        <table id="timeTableList">
            <thead>
            <tr>
                <th>요일</th>
                <th>강의시작시간</th>
                <th>강의종료시간</th>
                <th>강의실</th>
            </tr>
            </thead>
            <tbody id="dataList">
            </tbody>
        </table>
        <button class="btn_pack s2 blue" onclick="javascript:saveLectueRoom();">저장</button>
        <button class="btn_pack s2 blue" onclick="javascript:trans_row();">등록</button>
    </div>
</section>
<%@include file="/common/jsp/footer.jsp" %>
</body>
<!-- 강의실 리스트 팝업 시작 -->
<div class="layer_popup_template apt_request_layer" id="lectureRoomPopup">
    <div class="layer-title" style="margin-left: 0px;">
        <h3>강의실 검색</h3>
        <button id="close_btn" type="button" class="fa fa-close btn-close"></button>
    </div>
    <div class="layer-body">
        <div class="cont">
            <div class="tb_t1">
                <table>
                    <tbody>
                    <tr>
                        <th>학원정보</th>
                        <td>
                            <select id="sel_academy" class="form-control" onchange="init(this.value);">
                                <option value="">선택</option>
                            </select>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <br><br><br>
                <div id="listDiv" style="display: none">
                    <div>
                        <div style="text-align:center;font-size:32px;color:#FFFFFF;padding:10px;margin:10px;;background-color:#515357;width: 0px;float:left;">
                        </div>
                        <div style="float: left;width: 10%;margin-top: 11px;">
                            사용불가
                        </div>
                    </div>
                    <input type="hidden" id="lectureRoomId">
                    <input type="hidden" id="lectureDay">
                    <input type="hidden" id="lectureStartTime">
                    <input type="hidden" id="lectureEndTime">
                    <input type="hidden" id="isClassClick">
                    <table id="classTable">
                        <tbody id="dataList2">
                        <tr>
                            <% for (int i=1; i<=5; i++) { %>
                            <td data-toggle="buttons" id="td_<%=i%>" style="display: none">
                                <label style="width: 100px;" class="class_btn class_btn_block class_btn_default" id="class_<%=i%>">
                                    <input type="checkbox" id="check_<%=i%>" name="class_check_list" value=""  autocomplete="off">
                                </label>
                            </td>
                            <% } %>
                        </tr>
                        <tr>
                            <% for (int i=6; i<=10; i++) { %>
                            <td data-toggle="buttons" id="td_<%=i%>" style="display: none">
                                <label style="width: 100px;" class="class_btn class_btn_block class_btn_default" id="class_<%=i%>">
                                    <input type="checkbox" id="check_<%=i%>" name="class_check_list" value=""  autocomplete="off">
                                </label>
                            </td>
                            <% } %>
                        </tr>
                        <tr>
                            <% for (int i=11; i<=15; i++) { %>
                            <td data-toggle="buttons" id="td_<%=i%>" style="display: none">
                                <label style="width: 100px;" class="class_btn class_btn_block class_btn_default" id="class_<%=i%>">
                                    <input type="checkbox" id="check_<%=i%>" name="class_check_list" value="" autocomplete="off">
                                </label>
                            </td>
                            <% } %>
                        </tr>
                        <tr>
                            <% for (int i=16; i<=20; i++) { %>
                            <td data-toggle="buttons" id="td_<%=i%>" style="display: none">
                                <label style="width: 100px;" class="class_btn class_btn_block class_btn_default" id="class_<%=i%>">
                                    <input type="checkbox" id="check_<%=i%>" name="class_check_list" value=""  autocomplete="off">
                                </label>
                            </td>
                            <% } %>
                        </tr>
                        <tr>
                            <% for (int i=21; i<=25; i++) { %>
                            <td data-toggle="buttons" id="td_<%=i%>" style="display: none">
                                <label style="width: 100px;" class="class_btn class_btn_block class_btn_default" id="class_<%=i%>">
                                    <input type="checkbox" id="check_<%=i%>" name="class_check_list" value=""  autocomplete="off">
                                </label>
                            </td>
                            <% } %>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <br><br><br>
                <div style="text-align: center">
                    <input type="button" class="btn_wrap s2 blue" value="선택" onclick="selectLectureRoom();">
                    <input type="button" class="btn_wrap s2 blue" value="취소" onclick="javascript:$('#close_btn').trigger('click');">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 강의실 리스트 팝업 끝 -->
