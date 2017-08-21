<%
    int lectureId = Integer.parseInt(request.getParameter("lecture_id"));
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>

<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/calendarService.js'></script>

<style>
    .fc-sat { color:blue; }
    .fc-sun { color:red;  }
</style>
<script type="text/javascript">
    var lectureId = '<%=lectureId%>';

    $(document).ready(function() {
        // page is now ready, initialize the calendar...
        calendarService.getCalendarLectureInfo(lectureId, function (calendarInfo) {

            $('#calendar').fullCalendar({
                lang:'ko',
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay,listWeek'
                },
                // put your options and callbacks here
                eventDrop: function(event, delta, revertFunc) {
                    //alert(event.id);
                    alert("강의달력은 변경할수 없습니다.");
                    revertFunc();
                    /*
                    if (!confirm("change??")) {
                        revertFunc();
                    }
                    */
                },
                editable: true,
                defaultView: 'month',
                eventRender: function (event, element, view) {
                    return (event.ranges.filter(function (range) {
                            return (event.start.isBefore(range.end) &&
                            event.end.isAfter(range.start));
                        }).length) > 0;
                },
                events:calendarInfo
                /*
                 [ {
                 id:1,
                 title:"Repeating event",
                 start: '06:00:00',
                 end: '08:00:00',
                 dow:[0],
                 ranges: [{ //repeating events are only displayed if they are within one of the following ranges.
                 start: '2017-08-01', //next two weeks
                 end: '2017-08-31',
                 }],
                 },
                 {
                 id:2,
                 title:"Repeating event",
                 start: '10:00:00',
                 end: '12:00:00',
                 dow:[6],
                 ranges: [{ //repeating events are only displayed if they are within one of the following ranges.
                 start: '2017-08-01', //next two weeks
                 end: '2017-08-31',
                 }],
                 }]
                 */
                /*
                 [
                 {
                 title: 'All Day Event',
                 start: YM + '-01'
                 },
                 {
                 title: 'Long Event',
                 start: YM + '-07',
                 end: YM + '-10'
                 },
                 {
                 id: 999,
                 title: 'Repeating Event',
                 start: YM + '-09T16:00:00'
                 },
                 {
                 id: 999,
                 title: 'Repeating Event',
                 start: YM + '-16T16:00:00'
                 },
                 {
                 title: 'Conference',
                 start: YESTERDAY,
                 end: TOMORROW
                 },
                 {
                 title: 'Meeting',
                 start: TODAY + 'T10:30:00',
                 end: TODAY + 'T12:30:00'
                 },
                 {
                 title: 'Lunch',
                 start: TODAY + 'T12:00:00'
                 },
                 {
                 title: 'Meeting',
                 start: TODAY + 'T14:30:00'
                 },
                 {
                 title: 'Happy Hour',
                 start: TODAY + 'T17:30:00'
                 },
                 {
                 title: 'Dinner',
                 start: TODAY + 'T20:00:00'
                 },
                 {
                 title: 'Birthday Party',
                 start: TOMORROW + 'T07:00:00'
                 },
                 {
                 title: 'Click for Google',
                 url: 'http://google.com/',
                 start: YM + '-28'
                 }
                 ]
                 */
            })
        });
    });

</script>
<body>
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <div class="content">
        <div id='calendar'></div>
    </div>
</form>
</body>
</html>
