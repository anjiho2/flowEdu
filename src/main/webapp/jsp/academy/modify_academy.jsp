<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String officeId = Util.isNullValue(request.getParameter("office_id"), "");
    int depth1 = 3;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
        if(check.input("academy_directorname", comment.input_academy_directorname) == false) return;
        if(check.input("academy_phone1", comment.input_academy_phone1) == false) return;
        if(check.input("academy_phone2", comment.input_academy_phone2) == false) return;
        if(check.input("academy_phone3", comment.input_academy_phone3) == false) return;
        if(check.input("academy_address", comment.input_academy_address) == false) return;
        if(check.input("academy_fax", comment.input_academy_fax) == false) return;

        if (officeId != '') {
            //수정일때
            if (confirm(comment.isUpdate)) {
                //var officeId                = getInputTextValue("officeId");

                var academy_name            = getInputTextValue("academy_name");
                var academy_directorname    = getInputTextValue("academy_directorname");
                var academy_address   = getInputTextValue("academy_address");
                var academy_group_id  = getSelectboxValue("sel_academyGroup");
                var academy_phone1    = getInputTextValue("academy_phone1");
                var academy_phone2    = getInputTextValue("academy_phone2");
                var academy_phone3    = getInputTextValue("academy_phone3");
                var academy_allphone  = academy_phone1+academy_phone2+academy_phone3;//관전번호
                var academy_fax1 = getInputTextValue("academy_fax1");
                var academy_fax2 = getInputTextValue("academy_fax2");
                var academy_fax3 = getInputTextValue("academy_fax3");
                var academy_fax  = academy_fax1 + academy_fax2 + academy_fax3;//팩스번호

                academyService.modifyAcademy(officeId, academy_name, academy_directorname, academy_address, academy_allphone, academy_fax, academy_group_id ,function () {
                    alert("학원정보가 수정 되었습니다.");
                    goPage("academy","list_academy");
                });
            }
        } else {
            //저장일때
            if (confirm(comment.isSave)) {

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
                 innerValue("academy_address", cmpList.officeAddress);
                 fnSetPhoneNo(academy_phone1, academy_phone2, academy_phone3, cmpList.officeTelNumber);
                 fnSetPhoneNo(academy_fax1, academy_fax2, academy_fax3, cmpList.officeFaxNumber);
                }
            }
        });
    }
</script>
<body onload="init();"> <!-- onload="academyList();" -->
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/academy_top_menu.jsp" %>--%>
</div>
</section>
<section class="content">
    <div class="title_top">행정관리</div>
    <h3 class="title_t1">학원정보수정</h3>
    <form name="frm" method="get"><!-- class="form_st1"-->
        <input type="hidden" name="page_gbn" id="page_gbn">
        <%--<input type="hidden" name="officeId" id="officeId" value="<%=officeId%>" >--%>
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
                    <%--<input type="text"  id="academy_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.academy_phone2,3)" style="width:50px;">&nbsp;-&nbsp;--%>
                    <%--<input type="text"  id="academy_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.academy_phone3,4)" style="width:50px;">&nbsp;-&nbsp;--%>
                    <%--<input type="text"  id="academy_phone3" class="form-control" maxlength="4" style="width:50px;">--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="form-group row">--%>
                <%--<label>팩스번호</label>--%>
                <%--<div class="inputs">--%>
                    <%--<input type="text"  id="academy_fax1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.academy_fax2,3)" style="width:50px;">&nbsp;-&nbsp;--%>
                    <%--<input type="text"  id="academy_fax2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.academy_fax3,4)" style="width:50px;">&nbsp;-&nbsp;--%>
                    <%--<input type="text"  id="academy_fax3" class="form-control" maxlength="4" style="width:50px;">--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>관 주소<b>*</b></label>--%>
            <%--<div><input type="text" class="form-control" id="academy_address" ></div>--%>
        <%--</div>--%>
        <%--<div class="bot_btns">--%>
            <%--<button class="btn_pack blue s2" type="button"  onclick="modify_academy();">수정</button>--%>
        <%--</div>--%>
        <%--<%@ include file="/common/inc/com_pageNavi.inc" %>--%>
        <%--</div>--%>
    </form>

    <div class="tb_t1">
        <table class="table_width">
            <tr>
                <th>그룹명<b>*</b></th>
                <td>
                    <span id="academy_group"></span>
                </td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <th>학원명<b>*</b></th>
                <td><input type="text" class="form-control" id="academy_name"></td>
                <th>원장명<b>*</b></th>
                <td><input type="text" class="form-control" id="academy_directorname"></td>
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
            <tr>
                <th>주소<b>*</b></th>
                <td colspan="3">
                    <div class="form-group row">
                        <input type="text" class="form-control" id="zip_code" style="width: 10rem;">&nbsp;
                        <button class="btn_pack" onclick="openDaumPostcode();">우편번호 검색</button>
                    </div>
                    <div class="form-group row marginX">
                        <input type="text" class="form-control" id="academy_address">
                        <input type="text" class="form-control" id="academy_address_detail">
                    </div>

                </td>
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
                        <input type="file" class="custom-file-input">
                        <span class="custom-file-control"></span>
                    </label>
                    <span>첨부파일은 jpg, gif, pdf 파일 등록만 가능하며 500kbyte로 용량을 제한합니다.</span>
                </td>
            </tr>
            <!--
            <tr>
                <th>등록자</th>
                <td><input type="text" class="form-control" disabled placeholder="이상준"></td>
                <th>등록일</th>
                <td><input type="text" class="form-control" disabled placeholder="2018-01-03 17:25:43"></td>
            </tr>
            -->
        </table>
        <button class="btn_pack s2 blue" onclick="modify_academy();">저장</button>
        <button class="btn_pack s2 blue">목록</button>
    </div>
</section>
</body>

<%--<script  src="<%=webRoot%>/js/postcode.js"></script>--%>
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;"></div>
<div style="display:none;cursor:pointer;position:absolute;right:34.8%;top:15%;z-index:9999" id="closeBtn_layler">
    <img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>