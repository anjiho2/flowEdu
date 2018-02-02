<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 4;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        //element_layer.style.display = 'none';
        $("#__daum__layer_1").css('display', 'none');
        $("#closeBtn_layler").css('display', 'none');
    }

    function openDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample2_address').value = fullAddr;
                document.getElementById('sample2_addressEnglish').value = data.addressEnglish;

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        $("#__daum__layer_1").css('position', 'absolute');
        $("#__daum__layer_1").css('width', '30%');
        $("#__daum__layer_1").css('height', '70%');
        $("#__daum__layer_1").css('z-index', '999');
        $("#__daum__layer_1").css('top', '15%');
        $("#__daum__layer_1").css('left', '35%');
        $("#__daum__layer_1").css('border', 'solid 2px black');
        $("#closeBtn_layler").css('display', '');

        initLayerPosition();

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.

    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition() {
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth) + 'px';
    }

    function init() {
        academyGroupSelectbox('academy_group', '');
        academyListSelectbox("academy_name","");//학원리스트
    }

    function save_academy() { //학원정보 저장
        var check = new isCheck();

        if(check.selectbox("sel_academyGroup", comment.input_academy_group) == false) return;   //학원그룹명 추가로 기능 추가 (2017.09.12 안지호)
        if(check.input("academy_name", comment.input_academy_name) == false) return;
        if(check.input("academy_directorname", comment.input_academy_directorname) == false) return;
        if(check.input("academy_phone1", comment.input_academy_phone1) == false) return;
        if(check.input("academy_phone2", comment.input_academy_phone2) == false) return;
        if(check.input("academy_phone3", comment.input_academy_phone3) == false) return;
        if(check.input("academy_address", comment.input_academy_address) == false) return;
        if(check.input("academy_fax", comment.input_academy_fax) == false) return;

        var academy_name            = getInputTextValue("academy_name");
        var academy_directorname    = getInputTextValue("academy_directorname");
        var academy_phone1          = getInputTextValue("academy_phone1");
        var academy_phone2          = getInputTextValue("academy_phone2");
        var academy_phone3          = getInputTextValue("academy_phone3");
        var academy_allphone        = academy_phone1+academy_phone2+academy_phone3;
        var academy_address         = getInputTextValue("academy_address");

        var academy_fax1 = getInputTextValue("academy_fax1");
        var academy_fax2 = getInputTextValue("academy_fax2");
        var academy_fax3 = getInputTextValue("academy_fax3");
        var academy_fax  = academy_fax1 + academy_fax2 + academy_fax3;
        var academy_group_id = getSelectboxValue("sel_academyGroup");   //학원그룹명 추가로 기능 추가 (2017.09.12 안지호)

        academyService.saveAcademy(academy_name, academy_directorname, academy_address, academy_allphone, academy_fax, academy_group_id, function () {
            alert("학원정보가 등록 되었습니다.");
            location.reload();
        });
    }
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/academy_top_menu.jsp" %>--%>
</div>
</section>
<section class="content">
    <div class="title_top">행정관리</div>
    <h3 class="title_t1">학원관리</h3>
    <form name="frm" method="get">
        <input type="hidden" name="office_id" id="office_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden"  id="sPage" value="<%=sPage%>">
        <%--<div class="form-group row">--%>
            <%--<label>그룹명<b>*</b></label>--%>
            <%--<div><span id="academy_group"></span></div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>관명<b>*</b></label>--%>
            <%--<div><input type="text" class="form-control" id="academy_name" style="width:150px;"></div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>원장이름<b>*</b></label>--%>
            <%--<div><input type="text" class="form-control" id="academy_directorname" style="width:150px;"></div>--%>
        <%--</div>--%>
        <%--<div class="form-outer-group">--%>
            <%--<div class="form-group row">--%>
                <%--<label>관 전화번호</label>--%>
                <%--<div class="inputs">--%>
                    <%--<input type="text"  id="academy_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.academy_phone2,3)" style="width:100px;">&nbsp;-&nbsp;--%>
                    <%--<input type="text"  id="academy_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.academy_phone3,4)" style="width:100px;">&nbsp;-&nbsp;--%>
                    <%--<input type="text"  id="academy_phone3" class="form-control" maxlength="4" style="width:100px;">--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="form-group row">--%>
                <%--<label>팩스번호</label>--%>
                <%--<div class="inputs">--%>
                    <%--<input type="text"  id="academy_fax1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.academy_fax2,3)" style="width:100px;">&nbsp;-&nbsp;--%>
                    <%--<input type="text"  id="academy_fax2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.academy_fax3,4)" style="width:100px;">&nbsp;-&nbsp;--%>
                    <%--<input type="text"  id="academy_fax3" class="form-control" maxlength="4" style="width:100px;">--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>관 주소<b>*</b></label>--%>
            <%--<div><input type="text" class="form-control" id="academy_address" ></div>--%>
        <%--</div>--%>
        <%--<div class="bot_btns">--%>
            <%--<button class="btn_pack blue s2" type="button"  onclick="save_academy();">등록</button>--%>
        <%--</div>--%>
            <%--<%@ include file="/common/inc/com_pageNavi.inc" %>--%>
        <%--</div>--%>
    </form>

    <div class="tb_t1">
        <table class="table_width">
            <tr>
                <th>그룹명<b>*</b></th>
                <td>
                    <select class="form-control">
                        <option value="">그룹선택</option>
                        <option value="">1그룹</option>
                        <option value="">2그룹</option>
                    </select>
                </td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <th>학원명<b>*</b></th>
                <td><input type="text" class="form-control"></td>
                <th>원장명<b>*</b></th>
                <td><input type="text" class="form-control"></td>
            </tr>
            <tr>
                <th>전화번호<b>*</b></th>
                <td>
                    <div class="form-group row marginX">
                        <div class="inputs">
                            <input type="number" size="3" class="form-control" maxlength="3" max="999">&nbsp;-&nbsp;
                            <input type="number" size="4" class="form-control" maxlength="4" max="9999">&nbsp;-&nbsp;
                            <input type="number" size="4" class="form-control" maxlength="4" max="9999">
                        </div>
                    </div>
                </td>
                <th>팩스번호<b>*</b></th>
                <td>
                    <div class="form-group row marginX">
                        <div class="inputs">
                            <input type="number" size="3" class="form-control" maxlength="3" max="999">&nbsp;-&nbsp;
                            <input type="number" size="4" class="form-control" maxlength="4" max="9999">&nbsp;-&nbsp;
                            <input type="number" size="4" class="form-control" maxlength="4" max="9999">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>주소<b>*</b></th>
                <td colspan="3">
                    <div class="form-group row">
                        <input type="text" class="form-control" id="addr1" style="width: 10rem;">&nbsp;
                        <button class="btn_pack" onclick="openDaumPostcode();">우편번호 검색</button>
                    </div>
                    <div class="form-group row marginX">
                        <input type="text" class="form-control" id="member_address">
                        <input type="text" class="form-control" id="member_address2">
                    </div>

                </td>
            </tr>
            <tr>
                <th>메모</th>
                <td colspan="3">
                    <textarea rows="5" class="form-control"></textarea>
                </td>
            </tr>
            <tr>
                <th>증명서 업로드</th>
                <td colspan="3">
                    <label class="custom-file">
                        <input type="file" class="custom-file-input">
                        <span class="custom-file-control"></span>
                    </label>
                    <span>첨부파일은 jpg, gif, pdf 파일 등록만 가능하며 500kbyte로 용량을 제한합니다.</span>
                </td>
            </tr>
            <tr>
                <th>등록자</th>
                <td><input type="text" class="form-control" disabled></td>
                <th>등록일</th>
                <td><input type="text" class="form-control" disabled></td>
            </tr>
        </table>
        <button class="btn_pack s2 blue">저장</button>
        <button class="btn_pack s2 blue">목록</button>
    </div>
</section>

</body>
</html>
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;overflow:hidden;-webkit-overflow-scrolling:touch;"></div>
<div style="display:none;cursor:pointer;position:absolute;right:34.8%;top:15%;z-index:9999" id="closeBtn_layler">
    <img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>