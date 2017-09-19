<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<%
    Long officeId = Long.parseLong(request.getParameter("office_id"));
    int depth2 = 2;
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script>
    function modify_academy() { //학원정보 수정 저장
        if (confirm(comment.isUpdate)) {
            var officeId                = getInputTextValue("officeId");
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
    }

    function academyList() { //학원정보가져오기
        var officeId        = getInputTextValue("officeId");
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
<body onload="academyList();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/academy_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <h3 class="title_t1">학원정보수정</h3>
    <form name="frm" method="get" class="form_st1">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="officeId" id="officeId" value="<%=officeId%>" >
        <div class="form-group row">
            <label>그룹명<b>*</b></label>
            <div><span id="academy_group"></span></div>
        </div>
        <div class="form-group row">
            <label>관명<b>*</b></label>
            <div><input type="text" class="form-control" id="academy_name" style="width:150px;"></div>
        </div>
        <div class="form-group row">
            <label>원장이름<b>*</b></label>
            <div><input type="text" class="form-control" id="academy_directorname" style="width:150px;"></div>
        </div>
        <div class="form-outer-group">
            <div class="form-group row">
                <label>관 전화번호</label>
                <div class="inputs">
                    <input type="text"  id="academy_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.academy_phone2,3)" style="width:50px;">&nbsp;-&nbsp;
                    <input type="text"  id="academy_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.academy_phone3,4)" style="width:50px;">&nbsp;-&nbsp;
                    <input type="text"  id="academy_phone3" class="form-control" maxlength="4" style="width:50px;">
                </div>
            </div>
            <div class="form-group row">
                <label>팩스번호</label>
                <div class="inputs">
                    <input type="text"  id="academy_fax1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.academy_fax2,3)" style="width:50px;">&nbsp;-&nbsp;
                    <input type="text"  id="academy_fax2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.academy_fax3,4)" style="width:50px;">&nbsp;-&nbsp;
                    <input type="text"  id="academy_fax3" class="form-control" maxlength="4" style="width:50px;">
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label>관 주소<b>*</b></label>
            <div><input type="text" class="form-control" id="academy_address" ></div>
        </div>
        <div class="bot_btns">
            <button class="btn_pack blue s2" type="button"  onclick="modify_academy();">수정</button>
        </div>
        <%@ include file="/common/inc/com_pageNavi.inc" %>
        </div>
    </form>
</section>
</body>