<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/loginService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/calendarService.js'></script>
<!--
<style>
    .fc-sat { color:blue; }
    .fc-sun { color:red;  }

</style>
-->
<script type="text/javascript">

    var check = new isCheck();

    function init() {
        memberTypeSelectbox("l_memberType", "");
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
//
//    $(document).ready(function() {
//        // page is now ready, initialize the calendar...
//        calendarService.getCalendarLectureInfo(26, function (calendarInfo) {
//
//            $('#calendar').fullCalendar({
//                lang:'ko',
//                header: {
//                    left: 'prev,next today',
//                    center: 'title',
//                    right: 'month,agendaWeek,agendaDay,listWeek'
//                },
//                // put your options and callbacks here
//                eventDrop: function(event, delta, revertFunc) {
//                    alert(event.id);
//                    if (!confirm("change??")) {
//                        revertFunc();
//                    }
//                },
//                editable: true,
//                defaultView: 'month',
//                eventRender: function (event, element, view) {
//                    return (event.ranges.filter(function (range) {
//                            return (event.start.isBefore(range.end) &&
//                            event.end.isAfter(range.start));
//                        }).length) > 0;
//                },
//                events:calendarInfo
//                /*
//                    [ {
//                    id:1,
//                    title:"Repeating event",
//                    start: '06:00:00',
//                    end: '08:00:00',
//                    dow:[0],
//                    ranges: [{ //repeating events are only displayed if they are within one of the following ranges.
//                        start: '2017-08-01', //next two weeks
//                        end: '2017-08-31',
//                    }],
//                },
//                    {
//                        id:2,
//                        title:"Repeating event",
//                        start: '10:00:00',
//                        end: '12:00:00',
//                        dow:[6],
//                        ranges: [{ //repeating events are only displayed if they are within one of the following ranges.
//                            start: '2017-08-01', //next two weeks
//                            end: '2017-08-31',
//                        }],
//                    }]
//                    */
//                /*
//                 [
//                 {
//                 title: 'All Day Event',
//                 start: YM + '-01'
//                 },
//                 {
//                 title: 'Long Event',
//                 start: YM + '-07',
//                 end: YM + '-10'
//                 },
//                 {
//                 id: 999,
//                 title: 'Repeating Event',
//                 start: YM + '-09T16:00:00'
//                 },
//                 {
//                 id: 999,
//                 title: 'Repeating Event',
//                 start: YM + '-16T16:00:00'
//                 },
//                 {
//                 title: 'Conference',
//                 start: YESTERDAY,
//                 end: TOMORROW
//                 },
//                 {
//                 title: 'Meeting',
//                 start: TODAY + 'T10:30:00',
//                 end: TODAY + 'T12:30:00'
//                 },
//                 {
//                 title: 'Lunch',
//                 start: TODAY + 'T12:00:00'
//                 },
//                 {
//                 title: 'Meeting',
//                 start: TODAY + 'T14:30:00'
//                 },
//                 {
//                 title: 'Happy Hour',
//                 start: TODAY + 'T17:30:00'
//                 },
//                 {
//                 title: 'Dinner',
//                 start: TODAY + 'T20:00:00'
//                 },
//                 {
//                 title: 'Birthday Party',
//                 start: TOMORROW + 'T07:00:00'
//                 },
//                 {
//                 title: 'Click for Google',
//                 url: 'http://google.com/',
//                 start: YM + '-28'
//                 }
//                 ]
//                 */
//            })
//        });
//    });


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

    <%--<div id='calendar'></div>--%>
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
