<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/loginService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>

<script type="text/javascript">

    var check = new isCheck();

    function init() {
        memberTypeSelectbox("l_memberType", "");
        //lectureLevelRadio("l_test", "HIGH", "loginCheck();");
        //lecturePriceSelectbox("l_test", "");
    }

    function loginCheck() {
        var phoneNumber = getInputTextValue("phoneNumber");
        var pass = getInputTextValue("memberPass");
        var memberType = getSelectboxValue("sel_memberType");

        if (check.selectbox("sel_memberType", comment.select_member) == false) return;
        if (check.input("phoneNumber", comment.insert_id) == false) return;
        if (check.input("memberPass", comment.insert_password) == false) return;

        loginService.isMember(phoneNumber, pass, memberType, function(data) {
            console.log(data);
            if (data.phoneNumber != null ) {
                loginOk(data);
            } else {
                alert("아이디또는 비밀번호가 잘못됬습니다.");
                return;
            }
        });
    }

    function loginOk(val) {
        with(document.frm) {
            innerValue("flow_member_id", val.flowMemberId);
            innerValue("office_id", val.officeId);
            innerValue("team_id", val.teamId);
            innerValue("phone_number", val.phoneNumber);
            innerValue("member_name", val.memberName);
            innerValue("member_type", val.memberType);

            page_gbn.value = "session";
            action = "<%=webRoot%>/login.do";
            submit();
        }
    }

    $(document).ready(function () {

        $('#btnAdd').click(function () {

            var num = $('.clonedInput').length;  // how many "duplicatable" input fields we currently have

            var newNum = num + 1;    // the numeric ID of the new input field being added

            // create the new element via clone(), and manipulate it's ID using newNum value

            var newElem = $('#input1').clone().attr('id', 'input' + newNum);

            // manipulate the name/id values of the input inside the new element


            newElem.find('#input_fn_1 input').attr('id', 'name1_' + newNum).attr('name', 'name1_' + newNum).val('');


            //newElem.find('#input_ln_1 input').attr('id', 'name2_' + newNum).attr('name', 'name2_' + newNum).val('');

            // insert the new element after the last "duplicatable" input field

            $('#input' + num).after(newElem);

            // enable the "remove" button

            //$('#btnDel').attr('disabled', false);

            // business rule: you can only add 5 names
            /*
            if (newNum == 5)
                $('#btnAdd').attr('disabled', 'disabled');
                */

        });

        $('#btnDel').click(function () {
            var num = $('.clonedInput').length; // how many "duplicatable" input fields we currently have
            $('#input' + num).remove();     // remove the last element
            // enable the "add" button

            $('#btnAdd').attr('disabled', false);
            // if only one element remains, disable the "remove" button

            if (num - 1 == 1)

                $('#btnDel').attr('disabled', 'disabled');

        });
    });

    function ttt(val) {
        $(function() {
            $("#"+val).removeClass('hasTimepicker');
            $("#"+val).timepicker({
                hourText: '시',
                minuteText: '분',
            });
            $.timepicker.setDefaults($.timepicker.regional['ko']);
        });
    }

</script>
<body onload="init();">
<form name="frm" method="post">
<input type="hidden" id="flow_member_id" name="flow_member_id" />
<input type="hidden" id="office_id" name="office_id" />
<input type="hidden" id="team_id" name="team_id" />
<input type="hidden" id="phone_number" name="phone_number" />
<input type="hidden" id="member_name" name="member_name" />
<input type="hidden" id="member_type" name="member_type" />
<input type="hidden" name="page_gbn" id="page_gbn">
<%
    if (session.getAttribute("member_info") == null) {
%>
    <span id="l_memberType"></span>
    <input type="text" id="phoneNumber">
    <input type="password" id="memberPass" name="memberPass">
    <input type="button" id="loginBtn" value="로그인" onclick="loginCheck();">

    <input type="text" class="time_11" id="time_1">
    <input type="text" class="time_11" id="time_1">

<br>
    <input type="button" value="추가" id="btnAdd">
    <input type="button" value="저장" onclick="save_lecture_info();">
    <div id="input1" class="clonedInput">
        <table border="1">
            <tr>
                <th>강의실선택</th>
                <td>
                    <span id="lectureRoomSelectbox"></span>
                </td>
            </tr>
            <tr>
                <th>강의시작시간</th>
                <td id="input_fn_1">
                    <input type="text" id="name1_1" name="start_time[]"  onclick="ttt(this.id);">
                </td>
            </tr>
            <tr>
                <th>강의종료시간</th>
                <td>
                    <input type="text" id="end_time" name="end_time[]">
                </td>
            </tr>
            <tr>
                <th>강의요일</th>
                <td>
                    <span id="lectureDaySelectbox"></span>
                </td>
            </tr>
        </table>
        <br>
    </div>

<%
    } else {
%>
    <input type="button" id="logoutBtn" value="로그아웃" onclick="goLogout();">
<%
    }
%>
</form>
</body>
</html>
