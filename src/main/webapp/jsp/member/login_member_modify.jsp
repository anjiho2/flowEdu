<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>

<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>

<body>
<form name="frm" id="frm" method="get">
    <div>
    <table>
        <h3>회원정보 수정page</h3>
            <h4>비밀번호 변경</h4>
            <tr>
                <th>ID :</th>
                <td><input type="text"></td>
            </tr>
            <tr>
                <th>기존비밀번호 :</th>
                <td><input type="text"></td>
            </tr>
            <tr>
                <th>새로운비밀번호 :</th>
                <td><input type="text"></td>
            </tr>
            <tr>
                <th>재확인비밀번호 :</th>
                <td><input type="text"></td>
            </tr>
            <tr><td><input type="button" value="변경" onclick=""></td></tr>
     </table>
        ----------------------------------------------------------
     <table>
            <h4>비밀번호 찾기</h4>
            <tr>
                <th>ID :</th>
                <td><input type="text"></td>
            </tr>
            <tr>
                <th>핸드폰번호 :</th>
                <td>
                    <input type="text" size="2" id="member_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.member_phone2,3)">
                    -
                    <input type="text" size="5" id="member_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.member_phone3,4)">
                    -
                    <input type="text" size="5" id="member_phone3" maxlength="4">
                </td>

            </tr>
            <tr>
                <th>이메일 :</th>\

                <td><input type="text"></td>
            </tr>
            <tr><td><input type="button" value="찾기" onclick=""></td></tr>
     </table>
</form>
</body>