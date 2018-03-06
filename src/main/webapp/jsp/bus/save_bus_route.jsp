<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String driverId = Util.isNullValue(request.getParameter("driver_id"), "");

    int depth1 = 5;
    int depth2 = 3;

    int siderMenuDepth1 = 5;
    int siderMenuDepth2 = 6;
    int siderMenuDepth3 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/busService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/busManager.js'></script>
<link rel="stylesheet" href="//cdn.rawgit.com/fgelinas/timepicker/master/jquery.ui.timepicker.css">
<script>
    var driverId = '<%=driverId%>';

    function init() {
        gfn_emptyView("V", comment.reg_add_btn_stop_station);
        gfn_emptyView2("V", comment.reg_add_btn_stop_station);
    }
    //추가버튼
    function trans_attendTime() {
        var trLength = $('#attendTimeList #dataList tr').length;
        if (trLength == 0) {
            var i = 1;
            var j = trLength + 1;
                var cellData = [
                    function(data) { return "<input type=\"checkbox\" name=\"chk\" value=\"1\">" },
                    function(data) { return "<input type=\"text\" class=\"form-control \" name=\"stationName[]\" id='statinName_" + i + "'>" },
                    function(data) { return "<input type=\"text\" class=\"form-control date-picker\" name=\"firstTime[]\" id='firstTime_" + i + "' >" },
                    function(data) { return "<input type=\"text\" class=\"form-control\" name=\"secondTime[]\" id='secondTime_" + i + "' >" },
                    function(data) { return "<input type=\"text\" class=\"form-control\" name=\"thirdTime[]\" id='thirdTime_" + i + "' >" },
                    function(data) { return "<input type=\"text\" class=\"form-control\" name=\"fourthTime[]\" id='fourthTime_" + i + "'>" },
                    function(data) { return "<input type=\"text\" class=\"form-control\" name=\"fifthime[]\" id='fifthime_" + i + "'>" },
                    function(data) { return "<div class=\"form-group row marginX draghandle\">\n" +
                        "<input type=\"text\" class=\"form-control\" name=\"sixthTime[]\" id='sixthTime_" + i + "'>\n" +
                        "<span class=\"fa fa-bars\"></span>\n" +
                        "</div>"}
                ];
            j++;
            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
            $("#attendTimeList").find("tbody").find("tr:last").attr('id', 'tr_1');

            /** timepicker 바인딩 하기 **/
            var elem1 = $("#attendTimeList tbody tr td input[name='firstTime[]']");
            elem1.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem2 = $("#attendTimeList tbody tr td input[name='secondTime[]']");
            elem2.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem3 = $("#attendTimeList tbody tr td input[name='thirdTime[]']");
            elem3.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem4 = $("#attendTimeList tbody tr td input[name='fourthTime[]']");
            elem4.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem5 = $("#attendTimeList tbody tr td input[name='fifthime[]']");
            elem5.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem6 = $("#attendTimeList tbody tr td input[name='sixthTime[]']");
            elem6.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            $.timepicker.setDefaults($.timepicker.regional['ko']);

            gfn_emptyView("H", "");
        } else {
            var num = $("input[name='chk']").length;
            var newNum = num + 1;
            var $tableBody = $('#attendTimeList').find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
                $trLast.after($trNew);

            $trNew.attr('id', 'tr_' + newNum);
            $trNew.find("td input").eq(0).val(newNum);
            $trNew.find("td input").eq(1).val('').attr('id', 'statinName_'+newNum);
            $trNew.find("td input").eq(2).attr('id', 'firstTime_'+newNum).val('');
            $trNew.find("td input").eq(3).attr('id', 'secondTime_'+newNum).val('');
            $trNew.find("td input").eq(4).attr('id', 'thirdTime_'+newNum).val('');
            $trNew.find("td input").eq(5).attr('id', 'fourthTime_'+newNum).val('');
            $trNew.find("td input").eq(6).attr('id', 'fifthTime_'+newNum).val('');
            $trNew.find("td input").eq(7).attr('id', 'sixthTime_'+newNum).val('');

            /** timepicker 바인딩 하기 **/
            var elem1 = $("#attendTimeList tbody tr td input[name='firstTime[]']");
            elem1.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem2 = $("#attendTimeList tbody tr td input[name='secondTime[]']");
            elem2.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem3 = $("#attendTimeList tbody tr td input[name='thirdTime[]']");
            elem3.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem4 = $("#attendTimeList tbody tr td input[name='fourthTime[]']");
            elem4.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem5 = $("#attendTimeList tbody tr td input[name='fifthime[]']");
            elem5.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            var elem6 = $("#attendTimeList tbody tr td input[name='sixthTime[]']");
            elem6.removeClass('hasTimepicker').removeData('timepicker').unbind().timepicker({
                hourText: '시',
                minuteText: '분'
            });
            $.timepicker.setDefaults($.timepicker.regional['ko']);
        }
    }

    //저장 버튼
    function save() {
        var check = new isCheck();
        /** 필수 입력 값 체크 **/
        if (check.input("l_routeNumber", comment.input_route_number) == false) return;
        if (check.input("l_startRouteName", comment.input_start_route_name) == false) return;
        if (check.selectbox("sel_busType", comment.select_category) == false) return;
        if (check.selectbox("sel_busStatus", comment.select_status) == false) return;
        if ($('#attendTimeList tbody tr').length == 0) {
            alert(comment.input_attend_time);
            return;
        }
        if (check.input("l_dismissFirstTime", comment.input_dismiss_time) == false) return;
        if (check.input("startDate", comment.input_apply_start_date) == false) return;
        if (check.input("endDate", comment.input_apply_end_date) == false) return;
        /** 종점이 입력이 안되었을때 시점 값으로 입력 **/
        var endRouteName = getInputTextValue("l_endRouteName");
        if (endRouteName == "" || endRouteName == undefined) {
            endRouteName = getInputTextValue("l_startRouteName");
        }
        /** 버스 기본정보 **/
        var busInfo = {
            routeNumber:getInputTextValue("l_routeNumber"),
            startRouteName:getInputTextValue("l_startRouteName"),
            endRouteName:endRouteName,
            busType:getSelectboxValue("sel_busType"),
            busStatus:getSelectboxValue("sel_busStatus") == "Y" ? true : false,
            applyStartDate:getInputTextValue("startDate"),
            applyEndDate:getInputTextValue("endDate"),
            busMemo:getInputTextValue("memo"),
            driverIdx:driverId
        };
        /** 등원정보 **/
        var busAttendTimeList = new Array();
        $('#attendTimeList tbody tr').each(function(index){
            var statinNames = $(this).find("td input").eq(1).val();
            var firstTimes = $(this).find("td input").eq(2).val();
            var secondTimes = $(this).find("td input").eq(3).val();
            var thirdTimes = $(this).find("td input").eq(4).val();
            var fourthTimes = $(this).find("td input").eq(5).val();
            var fifthTimes = $(this).find("td input").eq(6).val();
            var sixthTimes = $(this).find("td input").eq(7).val();
            var sortNums = index + 1;

            var busAttendTime = {
                stationName:statinNames, firstTime:firstTimes, secondTime:secondTimes,
                thirdTime:thirdTimes, fourthTime:fourthTimes, fifthTime:fifthTimes, sixthTime:sixthTimes, sortNumber:sortNums
            };
            busAttendTimeList.push(busAttendTime);
        });
        /** 하원정보 **/
        var busDismissTime = {
            firstTime:getInputTextValue("l_dismissFirstTime"),
            secondTime:getInputTextValue("l_dismissSecondTime"),
            thirdTime:getInputTextValue("l_dismissThirdTime"),
            fourthTime:getInputTextValue("l_dismissFourthTime"),
            fifthTime:getInputTextValue("l_dismissFifthTime"),
            sixthTime:getInputTextValue("l_dismissSixthTime"),
        };
        if (confirm(comment.isSave)) {
            gfn_display("loadingbar", true);
            busManager.saveRoute(busInfo, busAttendTimeList, busDismissTime, function () {
                isReloadPage(true);
                gfn_display("loadingbar", false);
            });
            goPage('bus', 'bus_route_info');
        }
    }
    //삭제 버튼
    function deleteAttendTime() {
        if (confirm(comment.isDelete)) {
            $("input[name=chk]:checked").each(function() {
                var checkVal = $(this).val();
                $("#tr_" + checkVal).remove();

                var chkLen = $("input[name='chk']").length;
                if (chkLen < 1) {
                    gfn_emptyView("V", comment.reg_add_btn_stop_station);
                }
                //var trLength = $('#attendTimeList #dataList tr').length;

            });
        }
    }

    function dismissAddBtn() {
        var trLen = $("#dataList2 tr").length;
        gfn_emptyView2("H", "");
        gfn_display("dataList2", true);
    }
</script>
<body onload="init();">
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/bus_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <%--<h4 class="title_t1"><span>강수원</span> 선생님의 노선 정보입니다.</h4>--%>
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="sPage" value="<%=sPage%>">
        <input type="hidden" name="driver_id" value="<%=driverId%>">
    </form>
    <div class="tb_t1">
        <table>
            <tr class="table_width">
                <th>노선번호<b>*</b></th>
                <td colspan="2">
                    <div class="form-group row">
                        <input type="text" class="form-control" id="l_routeNumber" placeholder="노선번호">&nbsp;
                    </div>
                </td>
                <td></td>
            </tr>
            <tr class="table_width">
                <th>노선명<b>*</b></th>
                <td colspan="2">
                    <div class="form-group row marginX">
                        <input type="text" class="form-control" id="l_startRouteName" placeholder="시점">&nbsp;
                        <input type="text" class="form-control" id="l_endRouteName" placeholder="종점">
                    </div>
                </td>
                <td></td>
            </tr>
            <tr>
                <th>구분<b>*</b></th>
                <td>
                    <select id="sel_busType" class="form-control">
                        <option value="">선택</option>
                        <option value="TERM">학기중</option>
                        <option value="VACATION">방학중</option>
                        <option value="ETC">기타</option>
                    </select>
                </td>
                <th>상태<b>*</b></th>
                <td>
                    <select id="sel_busStatus" class="form-control">
                        <option value="">선택</option>
                        <option value="Y">사용</option>
                        <option value="N">사용하지않음</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>등원<b>*</b></th>
                <td colspan="3">
                    <table id="attendTimeList">
                        <thead>
                            <tr>
                                <th><input type="checkbox" class="form-control" id="chkAll" onclick="javascript:checkall('chkAll');"></th>
                                <th style="width: 12rem;">정차위치</th>
                                <th>1T</th>
                                <th>2T</th>
                                <th>3T</th>
                                <th>4T</th>
                                <th>5T</th>
                                <th>6T</th>
                            </tr>
                        </thead>
                        <tbody id="dataList"></tbody>
                    </table>
                    <table>
                       <tr>
                            <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                        </tr>
                    </table>
                    <div>
                        <button class="btn_pack blue" onclick="deleteAttendTime();">삭제</button>
                        <button class="btn_pack blue float-right" onclick="trans_attendTime();">추가</button>
                    </div>
                </td>
            </tr>
            <tr>
                <th>하원<b>*</b></th>
                <td colspan="3">
                    <table>
                        <thead>
                        <tr>
                            <th style="width: 12rem;">정차위치</th>
                            <th>1T</th>
                            <th>2T</th>
                            <th>3T</th>
                            <th>4T</th>
                            <th>5T</th>
                            <th>6T</th>
                        </tr>
                        </thead>
                        <tbody id="dataList2" style="display: none;">
                        <tr>
                            <td>정차위치는 등원과 반대로 적용</td>
                            <td><input type="text" id="l_dismissFirstTime" class="form-control"></td>
                            <td><input type="text" id="l_dismissSecondTime" class="form-control"></td>
                            <td><input type="text" id="l_dismissThirdTime" class="form-control"></td>
                            <td><input type="text" id="l_dismissFourthTime" class="form-control"></td>
                            <td><input type="text" id="l_dismissFifthTime" class="form-control"></td>
                            <td><input type="text" id="l_dismissSixthTime" class="form-control"></td>
                        </tr>
                        </tbody>
                    </table>
                    <table>
                        <tr>
                            <td id="emptys2" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                        </tr>
                    </table>
                    <div>
                        <button class="btn_pack blue float-right" onclick="dismissAddBtn();">추가</button>
                    </div>
                </td>
            </tr>
            <tr>
                <th>적용 기간<b>*</b></th>
                <td colspan="2">
                    <div class="form-group row marginX">
                        <div class="input-group date common">
                            <input type="text" id="startDate" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>&nbsp;
                        <div class="input-group date common">
                            <input type="text" id="endDate" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </div>
                </td>
                <td></td>
            </tr>
            <tr>
                <th>메모</th>
                <td colspan="3">
                    <textarea rows="3" id="memo" class="form-control"></textarea>
                </td>
            </tr>
        </table>
        <button class="btn_pack s2 blue" onclick="save();">저장</button>
        <button class="btn_pack s2 blue">목록</button>
    </div>
</section>
<%@include file="/common/jsp/footer.jsp" %>

<script>
    $( "#attendTimeList tbody" ).sortable( {
        update: function( event, ui ) {
            $(this).children().each(function(index) {
                $(this).find('tr').last().html(index + 1);
            });
        }
    });
    $(function() {
        $("#l_dismissFirstTime").timepicker({
            hourText: '시',
            minuteText: '분'
        });
        $("#l_dismissSecondTime").timepicker({
            hourText: '시',
            minuteText: '분'
        });
        $("#l_dismissThirdTime").timepicker({
            hourText: '시',
            minuteText: '분'
        });
        $("#l_dismissFourthTime").timepicker({
            hourText: '시',
            minuteText: '분'
        });
        $("#l_dismissFifthTime").timepicker({
            hourText: '시',
            minuteText: '분'
        });
        $("#l_dismissSixthTime").timepicker({
            hourText: '시',
            minuteText: '분'
        });
        $.timepicker.setDefaults($.timepicker.regional['ko']);
    });
</script>

</body>

