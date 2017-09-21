<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 5;
    int lectureId = Integer.parseInt(request.getParameter("lecture_id"));
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<style>
    .fc-sat { color:blue; }
    .fc-sun { color:red;  }
</style>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/calendarService.js'></script>
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
            });
        });
    });

</script>
<body>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <h2>강의달력</h2>
    <%--<%@include file="/common/jsp/depth_menu.jsp" %>--%>
</div>
</section>
<section class="content">
    <form name="frm" method="get" class="form_st1">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <div class="content">
            <div id='calendar'></div>
        </div>
    </form>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>