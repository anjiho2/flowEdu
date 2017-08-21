<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">

    function init() {
        fn_search();
    }

    function fn_search() {

        var lecture_id = $("#lecture_id").val();
            lectureService.getLectureDetailInfoList( lecture_id, function (selList) {

                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return cmpList.lectureRoomId;},
                                function(data) {return cmpList.officeName;},
                                function(data) {return cmpList.startTime;},
                                function(data) {return cmpList.endTime;},
                                function(data) {return cmpList.lectureDay;}
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }
            });
    }

</script>

<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lecture_id%>">
    <h1>강의상세정보리스트</h1>
    <div id="memberList">
        <table class="table_list" border="1">
            <colgroup>
                <!-- <col width="2%" />-->
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
            </colgroup>
            <thead>
            <tr>
                <!-- <th>
                     <input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');">
                 </th>-->
                <th>강의실룸</th>
                <th>관명</th>
                <th>시작시간</th>
                <th>종료시간</th>
                <th>요일</th>
                <th></th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
        </table>
        <%@ include file="/common/inc/com_pageNavi.inc" %>
    </div>
    </div>
</form>

</body>
</html>
