<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int siderMenuDepth1 = 3;
    int siderMenuDepth2 = 4;
    int siderMenuDepth3 = 1;

    String officeId = Util.isNullValue(request.getParameter("office_id"), "");
    String savePath = ConfigHolder.getCertificateUploadsPath();
    String apiHost = ConfigHolder.getFlowEduApiUrl();
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/academyService.js'></script>
<script type="text/javascript">
    var officeId = '<%=officeId%>';

    function init() {
        if (officeId != '') {
            academyList();
        } else {
            academyGroupSelectbox("academy_group", "");
        }
    }

    function modify_academy() { //학원정보 수정 저장
        var check = new isCheck();
        if(check.selectbox("sel_academyGroup", comment.input_academy_group) == false) return;   //학원그룹명 추가로 기능 추가 (2017.09.12 안지호)
        if(check.input("academy_name", comment.input_academy_name) == false) return;
        //if(check.input("academy_directorname", comment.input_academy_directorname) == false) return;
        if(check.input("academy_phone1", comment.input_academy_phone1) == false) return;
        if(check.input("academy_phone2", comment.input_academy_phone2) == false) return;
        if(check.input("academy_phone3", comment.input_academy_phone3) == false) return;
        if(check.input("academy_fax1", comment.input_academy_fax) == false) return;
        if(check.input("academy_fax2", comment.input_academy_fax) == false) return;
        if(check.input("academy_fax3", comment.input_academy_fax) == false) return;
        if(check.input("zip_code", comment.input_zip_code) == false) return;
        if(check.input("academy_address", comment.input_academy_address) == false) return;
        if(check.input("academy_address_detail", comment.input_academy_address_detail) == false) return;

        var group_id = getSelectboxValue("sel_academyGroup");
        var academy_name            = getInputTextValue("academy_name");
        //var academy_directorname    = getInputTextValue("academy_directorname");
        var academy_address   = getInputTextValue("academy_address");
        var academy_address_detail = getInputTextValue("academy_address_detail");
        var academy_group_id  = getSelectboxValue("sel_academyGroup");
        var academy_phone1    = getInputTextValue("academy_phone1");
        var academy_phone2    = getInputTextValue("academy_phone2");
        var academy_phone3    = getInputTextValue("academy_phone3");
        var academy_allphone  = academy_phone1+academy_phone2+academy_phone3;//관전번호
        var academy_fax1 = getInputTextValue("academy_fax1");
        var academy_fax2 = getInputTextValue("academy_fax2");
        var academy_fax3 = getInputTextValue("academy_fax3");
        var academy_fax  = academy_fax1 + academy_fax2 + academy_fax3;//팩스번호
        var zip_code = getInputTextValue("zip_code");
        var academy_memo = getInputTextValue("academy_memo");

        var data = new FormData();
        data.append("save_path", '<%=savePath%>');
        $.each($("#attachFile")[0].files, function (i, file) {
            data.append("file_name", file);
        });
        var attachFile = fn_clearFilePath($("#attachFile").val());

        if (officeId == '' || officeId == undefined || officeId == null) {
            //입력일때
            if (confirm(comment.isSave)) {
                if (attachFile != '') {
                    alert(attachFile);
                    $.ajax({
                        url: "<%=apiHost%>/upload/certificate_file",
                        method: "post",
                        dataType: "JSON",
                        data: data,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            var errorCode = data.result.error_code;
                            if (errorCode == "907") {
                                alert(comment.file_size_not_allow_500kb);
                                return;
                            } else if (errorCode == "906") {
                                alert(comment.certificate_file_extension_not_allow);
                                return;
                            } else if (errorCode == "909") {
                                alert(comment.file_name_not_allow_korean);
                                return;
                            }
                            var fileName = data.result.file_name;
                            academyService.saveAcademy(
                                academy_name, "", academy_address, academy_allphone, academy_fax,
                                group_id, zip_code, academy_address_detail, academy_memo, fileName
                            );
                            goPage('academy', 'list_academy');
                        }
                    });
                } else {
                    academyService.saveAcademy(
                        academy_name, "", academy_address, academy_allphone, academy_fax,
                        group_id, zip_code, academy_address_detail, academy_memo, null
                    );
                    goPage('academy', 'list_academy');
                }
            }
        } else {
            //수정일때
            if (confirm(comment.isUpdate)) {
                if (attachFile != '') {
                    $.ajax({
                        url: "<%=apiHost%>/upload/certificate_file",
                        method: "post",
                        dataType: "json",
                        data: data,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            var errorCode = data.result.error_code;
                            if (errorCode == "907") {
                                alert(comment.file_size_not_allow_500kb);
                                return;
                            } else if (errorCode == "906") {
                                alert(comment.certificate_file_extension_not_allow);
                                return;
                            } else if (errorCode == "909") {
                                alert(comment.file_name_not_allow_korean);
                                return;
                            }
                            var fileName = data.result.file_name;
                            academyService.modifyAcademy(
                                officeId, academy_name, "", academy_address, academy_allphone, academy_fax,
                                group_id, zip_code, academy_address_detail, academy_memo, fileName
                            );
                            goPage('academy', 'list_academy');
                        }, error : function (jqXHR, exception) {
                            if (jqXHR.status === 0) {
                                alert('Not connect.\n Verify Network.');
                            } else if (jqXHR.status == 404) {
                                alert('Requested page not found. [404]');
                            } else if (jqXHR.status == 500) {
                                alert('Internal Server Error [500].');
                            } else if (exception === 'parsererror') {
                                alert('Requested JSON parse failed.');
                            } else if (exception === 'timeout') {
                                alert('Time out error.');
                            } else if (exception === 'abort') {
                                alert('Ajax request aborted.');
                            } else {
                                alert('Uncaught Error.\n' + jqXHR.responseText);
                            }
                        }
                    });
                } else {
                    academyService.modifyAcademy(
                        officeId, academy_name, "", academy_address, academy_allphone, academy_fax,
                        group_id, zip_code, academy_address_detail, academy_memo, null
                    );
                    goPage('academy', 'list_academy');
                }
            }
        }
    }

    function academyList() { //학원정보가져오기
        var officeId = '<%=officeId%>';
        academyService.getAcademyList(officeId, function (selList) {
        if (selList.length > 0) {
             for (var i=0; i<selList.length; i++) {
                 var cmpList = selList[i];
                 academyGroupSelectbox("academy_group", cmpList.academyGroupId);   //학원그룹명 추가로 기능 추가 (2017.09.12 안지호)
                 innerValue("academy_name", cmpList.officeName);
                 innerValue("academy_directorname", cmpList.officeDirectorName);
                 innerValue("zip_code", cmpList.zipCode);
                 innerValue("academy_address", cmpList.officeAddress);
                 innerValue("academy_address_detail", cmpList.officeAddressDetail);
                 fnSetPhoneNo(academy_phone1, academy_phone2, academy_phone3, cmpList.officeTelNumber);
                 fnSetPhoneNo(academy_fax1, academy_fax2, academy_fax3, cmpList.officeFaxNumber);
                 innerValue("academy_memo", cmpList.officeMemo);

                    //파일명이 있을때 파일명 보여주기
                    if (cmpList.certificateFileName != null) {
                        $(document).ready(function() {
                            $('.custom-file-control').html(cmpList.certificateFileName);
                        });
                    }
                }
            }
        });
    }

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    /*
    $(function () {
        $("#academy_directorname").on('click', function () {
            initPopup($("#find_member_popup"));
            focusInputText("member_name");
        });
    });
    */
    /*
    var checkUnload = true;
    $(window).on("beforeunload", function(){
        if(checkUnload)  return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
    });
    */

    var isChange = false;
    $(document).ready(function () {
        $("input, select, textarea").change(function () {
            isChange = true;
        });

        /*우편번호 레이아웃 숨기기*/
        $(document).mousedown(function(e){
            $('#layer').each(function(){
                if( $(this).css('display') == 'block' ){
                    var l_position = $(this).offset();
                    l_position.right = parseInt(l_position.left) + ($(this).width());
                    l_position.bottom = parseInt(l_position.top) + parseInt($(this).height());
                    if( ( l_position.left <= e.pageX && e.pageX <= l_position.right )
                        && ( l_position.top <= e.pageY && e.pageY <= l_position.bottom ) ){
                        //alert( 'popup in click' );
                    }
                    else{
                        //alert( 'popup out click' );
                        $(this).hide("fast");
                    }
                }
            });
        });
        /*우편번호 레이아웃 숨기기*/
    });

    function go_list() {
        alert("1");
        if(isChange) {
            if (confirm(comment.is_change_confirm)) {
                goPage('academy', 'list_academy');
            }
        } else {
              goPage('academy', 'list_academy');
        }
    }
</script>
<body onload="init();"> <!-- onload="academyList();" -->
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/academy_top_menu.jsp" %>--%>
    <div class="title-top">행정관리</div>
</div>
</section>
<section class="content">
    <h3 class="title_t1">학원정보수정</h3>
    <form name="frm" method="get"><!-- class="form_st1"-->
        <input type="hidden" name="page_gbn" id="page_gbn">
    </form>
    <form name="frm2" method="post">
    <div class="tb_t1">
        <table class="table_width">
            <tr>
                <th>그룹명<b>*</b></th>
                <td>
                    <span id="academy_group"></span>
                </td>
                <th>학원명<b>*</b></th>
                <td><input type="text" class="form-control" id="academy_name"></td>
                <%--<td colspan="2"></td>--%>
            </tr>
            <tr>
                <!--
                <th>원장명<b>*</b></th>
                <td><input type="text" class="form-control" id="academy_directorname"></td>
                -->
            </tr>
            <tr>
                <th>전화번호<b>*</b></th>
                <td>
                    <div class="form-group row marginX">
                        <div class="inputs">
                            <input type="number" id="academy_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this, 'academy_phone2', 3)">&nbsp;-&nbsp;
                            <input type="number" id="academy_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this, 'academy_phone3', 4)">&nbsp;-&nbsp;
                            <input type="number" id="academy_phone3" class="form-control" maxlength="4" onkeyup="js_tab_order(this, 'academy_phone3', 4)">
                        </div>
                    </div>
                </td>
                <th>팩스번호<b>*</b></th>
                <td>
                    <div class="form-group row marginX">
                        <div class="inputs">
                            <input type="number" id="academy_fax1" size="3" class="form-control" maxlength="3" onkeyup="js_tab_order(this, 'academy_fax2', 3)">&nbsp;-&nbsp;
                            <input type="number" id="academy_fax2" size="4" class="form-control" maxlength="4" onkeyup="js_tab_order(this, 'academy_fax3', 4)">&nbsp;-&nbsp;
                            <input type="number" id="academy_fax3" size="4" class="form-control" maxlength="4" onkeyup="js_tab_order(this, 'academy_fax3', 4)">
                        </div>
                    </div>
                </td>
            </tr>
                </td>
            <tr>
                <th>주소<b>*</b></th>
                <td colspan="3">
                    <div class="form-group row">
                        <input type="text" class="form-control" id="zip_code" style="width: 10rem;" onclick="openDaumPostcode();" placeholder="우편번호">&nbsp;
                        <%--<button class="btn_pack" onclick="openDaumPostcode();">우편번호 검색</button>--%>
                        <input type="button" class="btn_wrap pack" value="우편번호 검색" onclick="openDaumPostcode();">
                    </div>
                    <div class="form-group row marginX">
                        <input type="text" class="form-control" id="academy_address">
                        <input type="text" class="form-control" id="academy_address_detail">
                    </div>
            </tr>
            <tr>
                <th>메모</th>
                <td colspan="3">
                    <textarea rows="5" class="form-control" id="academy_memo"></textarea>
                </td>
            </tr>
            <tr>
                <th>증명서 업로드</th>
                <td colspan="3">
                    <label class="custom-file">
                        <input type="file" id="attachFile" class="custom-file-input">
                        <span class="custom-file-control"></span>
                    </label>
                    <span>첨부파일은 jpg, gif, pdf 파일 등록만 가능하며 500kbyte로 용량을 제한합니다.</span>
                </td>
            </tr>
        </table>
        <input type="button" class="btn_wrap s2 blue" value="저장" onclick="modify_academy();">
        <%--<button class="btn_pack s2 blue" onclick="modify_academy();">저장</button>--%>
        <input type="button" class="btn_wrap s2 blue" value="목록" id="list_btn" onclick="goPage('academy', 'list_academy');"/>
    </div>
    </form>
</section>
<!--원장명 검색 팝업 레이어 시작-->
<!--
<div class="layer_popup_template apt_request_layer" id="find_member_popup" style="display: none;width: 450px;">
    <div class="layer-title">
        <h3>회원검색</h3>
        <button id="close_btn" type="button" class="fa fa-close btn-close"></button>
    </div>
    <div class="layer-body">
        <div class="cont">
            <div class="form_st1">
                <div class="form-group row">
                    <label>이름</label>
                    <div><input type="text" id="member_name" class="form-control"></div>
                </div>
                <div class="form-group row" style="display: none;">
                    <label>검색결과</label>
                    <a href="#"></a>
                </div>
            </div>
        </div>
        <div class="bot_btns_t1">
            <button class="btn_pack btn-close" type="button">취소</button>
            <button class="btn_pack blue" type="button">검색</button>
        </div>
    </div>
</div>
-->
<!--원장명 검색 팝업 레이어 끝-->

<div id="layer" style="display:none;border:1px solid;position:fixed;width:500px;height:500px;left:50%;margin-left:-250px;top:50%;margin-top:-250px;overflow:hidden;z-index: 999;">
    <img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1;display:none;" onclick="closeDaumPostcode()" alt="접기 버튼">
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
                document.getElementById("academy_address").value = data.address;
                document.getElementById("academy_address_detail").focus();
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

    $(".sidebar-menu > li").eq(3).addClass("active");
    $(".sidebar-menu > li:nth-child(4) > ul > li:nth-child(1) > a").addClass("on");
</script>
</body>

