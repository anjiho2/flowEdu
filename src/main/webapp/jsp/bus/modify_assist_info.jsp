<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long busdriver_id = Long.parseLong(request.getParameter("busdriver_id"));
    Long assister_id = Long.parseLong(request.getParameter("assister_id"));
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
        getAssisterinfo();//운영자정보가져오기
        var busdriver_id = <%=busdriver_id%>;
        busService.getDriverInfo(busdriver_id, function (sel) {
            searchAcademySelectbox("sel_academy", sel.officeId);//소속
        });
    }

    function modify_assist() {

        var check = new isCheck();
        var assister_id = <%=assister_id%>;
        var busdriver_id  = <%=busdriver_id%>;
        var sel_academy = getSelectboxValue("sel_academy");
        var assister_name =  getInputTextValue("assister_name");//이름
        var allPhoneNum   = phoneNumber_sum("phoneNum1", "phoneNum2", "phoneNum3");//폰번호
        var birthDay      = getInputTextValue("startDate");//생일
        var endDate       = getInputTextValue("endDate");//등록일
        var zip_code      =  getInputTextValue("zip_code");//우편번호
        var assister_address_detail = getInputTextValue("assister_address_detail");
        var assister_address = getInputTextValue("assister_address");
        var sexualAssultDay  =  getInputTextValue("sexualAssultDay");//성범죄조회일자
        var assister_state   = getSelectboxValue("assister_state");
        var state;
        if(assister_state == 1)  state = true;
        else state = false;

        if(assister_state == ""){
            alert("상태를 체크해 주세요.");
            return;
        }
        if(check.input("assister_name", comment.search_input_id_name)   == false) return;
        if(check.input("phoneNum1", comment.input_academy_phone1)   == false) return;
        if(check.input("phoneNum2", comment.input_academy_phone2)   == false) return;
        if(check.input("phoneNum3", comment.input_academy_phone3)   == false) return;
        if(check.input("endDate", comment.input_register_date)   == false) return;
        if(check.input("zip_code", comment.input_zip_code)   == false) return;
        if(check.input("assister_address", comment.input_member_address)   == false) return;
        if(check.input("assister_address_detail", comment.input_member_address_detail)   == false) return;
        if(check.input("sexualAssultDay", comment.input_member_startSearchDate)   == false) return;

        gfn_display("loadingbar", true);

        if(confirm(comment.isUpdate)){
            busService.modifyDriverHelperInfo(assister_id, busdriver_id, sel_academy, assister_name, allPhoneNum, birthDay, endDate, zip_code,
                assister_address, assister_address_detail, sexualAssultDay, state ,function () {
                    gfn_display("loadingbar", false);
                    isReloadPage(true);
                });
        }

    }

    function getAssisterinfo() {
        var assister_id = <%=assister_id%>;
        busService.getDriverHelperInfo(assister_id, function (sel) {
            innerValue("assister_name", sel.helperName);
            innerValue("startDate", sel.birthDay);
            innerValue("endDate", sel.regDate);
            innerValue("zip_code", sel.zipCode);
            innerValue("assister_address", sel.address);
            innerValue("assister_address_detail", sel.addressDetail);
            innerValue("sexualAssultDay", sel.sexualAssultConfirmDate);
            fnSetPhoneNo("phoneNum1", "phoneNum2", "phoneNum3", sel.phoneNumber);
            var state;
            if(sel.serveYn == true) state = 1;
            else state = 0;
            $("#assister_state").val(state);
        });
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

    function go_list() {
        if(isChange) {
            if (confirm(comment.is_change_confirm)) {
                goPage('bus', 'bus_info');
            }
        } else {
            goPage('bus', 'bus_info');
        }
    }

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
    <form name="frm" method="get">
        <input type="hidden" name="busdriver_id" id="busdriver_id" value="<%=busdriver_id%>">
        <input type="hidden" name="assister_id" id="assister_id" value="<%=assister_id%>">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    </form>

    <div class="tb_t1">
        <table>
            <tr>
                <th>소속<b>*</b></th>
                <td>
                    <select id="sel_academy" class="form-control" disabled>
                        <option value="">전체</option>
                    </select>
                </td>
                <th>상태<b>*</b></th>
                <td>
                    <select class="form-control" id="assister_state">
                        <option value="">선택</option>
                        <option value="1">재직</option>
                        <option value="0">퇴사</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>이름<b>*</b></th>
                <td><input type="text" class="form-control" id="assister_name"></td>
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
                    <div class="input-group date common">
                        <input type="text" id="endDate" class="form-control date-picker">
                        <span class="input-group-addon">
                            <span class="fa fa-calendar"></span>
                        </span>
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
                        <input type="text" class="form-control" id="assister_address">
                        <input type="text" class="form-control" id="assister_address_detail">
                    </div>
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
        <button class="btn_pack s2 blue" onclick="modify_assist();">수정</button>
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
                document.getElementById("assister_address").value = data.address;
                document.getElementById("assister_address_detail").focus();
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

