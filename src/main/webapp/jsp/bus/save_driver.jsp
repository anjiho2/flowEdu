<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/busService.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function init() {
        searchAcademySelectbox("sel_academy","");//소속
        jobPositionSelectbox("sel_jobPosition", "");//직책
    }

    function save_busDriver() {
        var check = new isCheck();
        var sel_academy = getSelectboxValue("sel_academy");//소속
        var sel_jobPosition = getSelectboxValue("sel_jobPosition");//직책
        var dirver_name = getInputTextValue("busDriver_name");
        var phoneNum1 = getInputTextValue("phoneNum1");
        var phoneNum2 = getInputTextValue("phoneNum2");
        var phoneNum3 = getInputTextValue("phoneNum3");
        var allphoneNum = phoneNum1 + phoneNum2 + phoneNum3;
        var startDate = getInputTextValue("startDate");//생일
        var sexualAssultDay = getInputTextValue("sexualAssultDay");//성범죄
        var registerDate = getInputTextValue("registerDate");//등록일
        var zip_code = getInputTextValue("zip_code");
        var driver_address = getInputTextValue("driver_address");
        var driver_address_detail = getInputTextValue("driver_address_detail");
        var busNum =  getInputTextValue("busNum");//차량변호
        var busPassNum = getInputTextValue("busPassNum");//승차정원
        var endDate = getInputTextValue("endDate");//안전필증

        if(sel_academy == ''){
            alert(comment.input_member_academy);
            return false;
        }
        if(sel_jobPosition == ''){
            alert(comment.input_member_posiotion);
            return false;
        }
        if(check.input("dirver_name", comment.search_input_id_name)   == false) return;
        if(check.input("phoneNum1", comment.input_academy_phone1)   == false) return;
        if(check.input("phoneNum2", comment.input_academy_phone2)   == false) return;
        if(check.input("phoneNum3", comment.input_academy_phone3)   == false) return;
        if(check.input("registerDate", comment.input_register_date)   == false) return;
        if(check.input("zip_code", comment.input_zip_code)   == false) return;
        if(check.input("driver_address", comment.input_member_address)   == false) return;
        if(check.input("busNum", comment.input_busdriver_number)   == false) return;
        if(check.input("busPassNum", comment.input_busPass_number)   == false) return;
        if(check.input("endDate", comment.input_bussafe_date)   == false) return;
        if(check.input("sexualAssultDay", comment.input_member_startSearchDate)   == false) return;

        gfn_display("loadingbar", true);

        if(confirm(comment.isSave)){
            busService.saveDriverInfo(sel_academy, sel_jobPosition, dirver_name, allphoneNum, startDate, registerDate,
                zip_code, driver_address, driver_address_detail, busNum, busPassNum, endDate, true, sexualAssultDay, function () {
                    gfn_display("loadingbar", false);
                    goPage('bus', 'bus_info');
        });
        }
    }

    function go_list() {
        if(isChange) {
            if (confirm(comment.is_change_confirm)) {
                goPage('bus', 'bus_info');
            }
        } else {
            goPage('bus', 'bus_info');
        }
    }

    var isChange = false;
    $(document).ready(function () {
        $("input, select, textarea").change(function () {
            isChange = true;
        });
        $('#registerDate').change(function () { //기사등록일기준 년차
            var registerDate = $("#registerDate").val();
            var driver_year  = getAnnual(registerDate);
            $("#driver_year").html(driver_year);
        });
    });
</script>
<body onload="init();">
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/member_top_menu.jsp" %>--%>
    <div class="title-top">운영관리</div>
</div>
</section>
<section class="content">
    <h3 class="title_t1">기사정보입력</h3>
    <form name="frm" method="get">
        <input type="hidden" name="member_id" id="member_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    </form>

    <div class="tb_t1">
        <table>
            <tr>
                <th>소속<b>*</b></th>
                <td>
                    <select id="sel_academy" class="form-control">
                        <option value="">전체</option>
                    </select>
                </td>
                <th>직책<b>*</b></th>
                <td>
                    <select id="sel_jobPosition" class="form-control">
                        <option value="">전체</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>이름<b>*</b></th>
                <td><input type="text" class="form-control" id="busDriver_name"></td>
                <th>핸드폰번호<b>*</b></th>
                <td>
                    <div class="form-group row marginX">
                        <input type="number" size="3" class="form-control" maxlength="3" max="999" id="phoneNum1">&nbsp;-&nbsp;
                        <input type="number" size="4" class="form-control" maxlength="4" max="9999" id="phoneNum2">&nbsp;-&nbsp;
                        <input type="number" size="4" class="form-control" maxlength="4" max="9999" id="phoneNum3">
                    </div>
                </td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td>
                    <div class="input-group date common">
                        <input type="text" id="startDate" class="form-control date-picker">
                        <span class="input-group-addon">
                            <span class="fa fa-calendar"></span>
                        </span>
                    </div>
                </td>
                <th>등록일<b>*</b></th>
                <td>
                    <div class="form-group row marginX">
                        <div class="input-group date common">
                            <input type="text" id="registerDate" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                        <div>&nbsp;[ <span id="driver_year"></span> 년차 ]</div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>주소<b>*</b></th>
                <td colspan="3">
                    <div class="form-group row">
                        <input type="text" id="zip_code" class="form-control" style="width: 10rem;" placeholder="우편번호" onclick="openDaumPostcode();">&nbsp;
                        <button class="btn_pack" onclick="openDaumPostcode();">우편번호 검색</button>
                    </div>
                    <div class="form-group row marginX">
                        <input type="text" class="form-control"  id="driver_address">
                        <input type="text" class="form-control"  id="driver_address_detail">
                    </div>
                </td>
            </tr>
            <tr>
                <th>차량번호<b>*</b></th>
                <td><input type="text" class="form-control" id="busNum"></td>
                <th>승차정원<b>*</b></th>
                <td><input type="text" class="form-control" id="busPassNum"></td>
            </tr>
            <tr>
                <th>안전필증<b>*</b></th>
                <td>
                    <div class="input-group date common">
                        <input type="text" id="endDate" class="form-control date-picker">
                        <span class="input-group-addon">
                            <span class="fa fa-calendar"></span>
                        </span>
                    </div>
                </td>
                <th>상태<b>*</b></th>
                <td>
                    <select class="form-control">
                        <option value="">선택</option>
                        <option value="1">재직</option>
                        <option value="0">퇴사</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>성범죄조회 확인일자<b>*</b></th>
                <td>
                    <div class="input-group date common">
                        <input type="text" id="sexualAssultDay" class="form-control date-picker">
                        <span class="input-group-addon">
                            <span class="fa fa-calendar"></span>
                        </span>
                    </div>
                </td>
                <td colspan="2"></td>
            </tr>
        </table>
        <button class="btn_pack s2 blue" onclick="save_busDriver();">저장</button>
        <button class="btn_pack s2 blue" onclick="go_list();">목록</button>
    </div>

</section>
<div id="layer" style="display:none;border:5px solid;position:fixed;width:500px;height:500px;left:50%;margin-left:-250px;top:50%;margin-top:-250px;overflow:hidden;z-index: 999">
    <img src="http://i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="closeDaumPostcode()">
</div>
<%@include file="/common/jsp/footer.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element.style.display = 'none';
    }

    function openDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분. 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                document.getElementById("zip_code").value = (data.postcode1 + data.postcode2);
                //document.getElementById("zip2").value = data.postcode2;
                document.getElementById("driver_address").value = data.address;
                document.getElementById("driver_address_detail").focus();
                // iframe을 넣은 element를 안보이게 한다.
                element.style.display = 'none';
                //$("#layer").css('display', 'none');
            },
            width : '100%',
            height : '100%'
        }).embed(element);
        // iframe을 넣은 element를 보이게 한다.
        element.style.display = 'block';
    }

    $(".sidebar-menu > li").eq(5).addClass("active");
    $(".sidebar-menu > li:nth-child(6) > ul > li:nth-child(2) > a").addClass("on");
</script>
</body>

