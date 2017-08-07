<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type="text/javascript">
    function save_academy() {
        var check = new isCheck();

        if(check.input("academy_name", comment.input_academy_name) == false) return;
        if(check.input("academy_directorname", comment.input_academy_directorname) == false) return;
        if(check.input("academy_phone1", comment.input_academy_phone1) == false) return;
        if(check.input("academy_phone2", comment.input_academy_phone2) == false) return;
        if(check.input("academy_phone3", comment.input_academy_phone3) == false) return;
        if(check.input("academy_address", comment.input_academy_address) == false) return;
        if(check.input("academy_fax", comment.input_academy_fax) == false) return;

        var academy_name                = getInputTextValue("academy_name");
        var academy_directorname    = getInputTextValue("academy_directorname");
        var academy_phone1   = getInputTextValue("academy_phone1");
        var academy_phone2   = getInputTextValue("academy_phone2");
        var academy_phone3   = getInputTextValue("academy_phone3");
        var academy_allphone  = academy_phone1+academy_phone2+academy_phone3;
        var academy_address   = getInputTextValue("academy_address");
        var academy_fax           = getInputTextValue("academy_fax");

        academyService.saveAcademy(academy_name,academy_directorname,academy_address,academy_allphone,academy_fax,function () {
            alert("학원정보가 등록되었습니다.");
            location.reload();
        });
    }
    
    function js_tab_order(arg, nextname, len) {
        if (arg.value.length == len) {
             nextname.focus()
            return;
        }
    }
</script>
<body>
<form name="frm" method="post">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <h1>학원정보입력page</h1>
    <table>
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
                <input type="text" size="2" id="academy_phone1" maxlength="2" onkeyup="js_tab_order(this,frm.academy_phone2,2)">
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
                <input type="text" id="academy_fax">
            </td>
        </tr>
    </table>
    <input type="button" value="등록" onclick="save_academy();">
</form>

<h1>학원정보list</h1>
</body>
</html>