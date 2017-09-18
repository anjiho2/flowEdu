<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth2 = 2;
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type="text/javascript">
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
<body onload="academyList();academyGroupSelectbox('academy_group', '');">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/academy_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <h3 class="title_t1">학원정보입력</h3>
    <form name="frm" method="get" class="form_st1">
        <input type="hidden" name="office_id" id="office_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden"  id="sPage" value="<%=sPage%>">
        <div class="form-group row">
            <label>그룹명<b>*</b></label>
            <div><span id="academy_group"></span></div>
        </div>
        <div class="form-group row">
            <label>관명<b>*</b></label>
            <div><span id="academy_name"></span></div>
        </div>
            <!--
                <table>
                    <tr>
                        <th>그룹명</th>
                        <td>
                            <span id="academy_group"></span>
                        </td>
                    </tr>
                    <tr>
                        <th>관명</th>
                        <td>
                            <input type="text" id="academy_name">
                        </td>
                    </tr>
                    <tr>
                        <th>원장이름</th>
                        <td>
                            <input type="text" id="academy_directorname">
                        </td>
                    </tr>
                    <tr>
                        <th>관 전화번호</th>
                        <td>
                            <input type="text" size="2" id="academy_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.academy_phone2,3)">
                            -
                            <input type="text" size="5" id="academy_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.academy_phone3,4)">
                            -
                            <input type="text" size="5" id="academy_phone3" maxlength="4">
                        </td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>
                            <input type="text" id="academy_address">
                        </td>
                    </tr>
                    <tr>
                        <th>팩스번호</th>
                        <td>
                            <input type="text" size="2" id="academy_fax1">
                            -
                            <input type="text" size="5" id="academy_fax2">
                            -
                            <input type="text" size="5" id="academy_fax3">
                        </td>

                    </tr>
                </table>
                <input type="button" value="등록" onclick="save_academy();">
            -->

            <%@ include file="/common/inc/com_pageNavi.inc" %>
        </div>
    </form>
</section>
</body>
</html>
