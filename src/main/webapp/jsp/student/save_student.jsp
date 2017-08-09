<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>

<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type="text/javascript">

}
</script>
<body onload="">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="member_id" id="member_id">
    <h1>운영자/선생님정보입력page</h1>
    <table>
        <tr>
            <th>직원타입</th>
            <td>
                <span id="l_memberType"></span>
            </td>
        </tr>
        <tr>
            <th>직원명</th>
            <td>
                <input type="text" id="member_name">
            </td>
        </tr>
        <tr>
            <th>핸드폰번호</th>
            <td>
                <input type="text" size="2" id="member_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.member_phone2,3)">
                -
                <input type="text" size="5" id="member_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.member_phone3,4)">
                -
                <input type="text" size="5" id="member_phone3" maxlength="4">
            </td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td>
                <input type="text" id="startDate" >
            </td>
        </tr>

        <tr>
            <th>주소</th>
            <td>
                <input type="text" id="member_address">
            </td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>
                <input type="text" id="member_email">
            </td>
        </tr>
        <tr>
            <th>직책</th>
            <td>
                <span id="l_jobPosition"></span>
            </td>
        </tr>
        <tr>
            <th>소속부서(학원)</th>
            <td>
                <span id="sel_academy"></span>
            </td>
        </tr>
        <tr>
            <th>소속팀</th>
            <td>
                <span id="l_FlowEduTeam"></span>
            </td>
        </tr>
        <tr>
            <th>성범죄경력조회 확인일자</th>
            <td>
                <input type="text" id="startSearchDate" >
            </td>
        </tr>
        <tr>
            <th>교육청 강사등록일자</th>
            <td>
                <input type="text" id="startSearchDate2" >
            </td>
        </tr>
        <tr>
            <th>수정</th>
            <td>

            </td>
        </tr>
    </table>
    <input type="button" value="등록" onclick="">


<h1>운영자/선생님정보 LIST</h1>
<div id="memberList">
    <table class="table_list" border="1">
        <colgroup>
            <col width="2%" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
        </colgroup>
        <thead>
        <tr>
            <th>
                <input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');">
            </th>
            <th>직원선택</th>
            <th>직원명</th>
            <th>직원핸드폰번호</th>
            <th>생년월일</th>
            <th>주소</th>
            <th>이메일</th>
            <th>직책</th>
            <th>소속부서</th>
            <th>소속팀</th>
            <th>성범죄경력조회 확인일자</th>
            <th>교육청 강사등록일자</th>
            <th>수정</th>
        </tr>
        </thead>
        <tbody id="dataList"></tbody>
        <tr>
            <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
        </tr>
        <input type="button" value="삭제" onclick="">
    </table>
    <%@ include file="/common/inc/com_pageNavi.inc" %>
</div>
</form>
</body>
</html>
