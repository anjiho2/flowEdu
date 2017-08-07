<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>

<script type="text/javascript">
    function save_academy() {
        var academy_name     = getInputTextValue("academy_name");
        var academy_ledger    = getInputTextValue("academy_ledger");
        var academy_phone1  = getInputTextValue("academy_phone1");
        var academy_phone2  = getInputTextValue("academy_phone2");
        var academy_phone3  = getInputTextValue("academy_phone3");
        var academy_allphone = academy_phone1+academy_phone2+academy_phone3;
        var academy_address = getInputTextValue("academy_address");
        var academy_fax         = getInputTextValue("academy_fax");





    }
</script>
<body onload="init();">
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
                <input type="text" id="academy_ledger">
            </td>
        </tr>
        <tr>
            <th>관 전화번호</th>
            <td>
                <input type="text" size="3" id="academy_phone1">
                -
                <input type="text" size="5" id="academy_phone2">
                -
                <input type="text" size="5" id="academy_phone3">
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
</body>
</html>
