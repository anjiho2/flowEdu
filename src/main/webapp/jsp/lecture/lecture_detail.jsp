<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 5;
    int depth2 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
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
                                function(data) {return cmpList.officeName;},
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
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/lecture_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <h3 class="title_t1">강의상세정보</h3>
    <form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lecture_id%>">
        <div class="tb_t1"><!--리스트-->
            <table>
                <colgroup>
                    <!-- <col width="2%" />-->
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                </colgroup>
                <thead>
                <tr>
                    <th>강의실룸</th>
                    <th>관명</th>
                    <th>시작시간</th>
                    <th>종료시간</th>
                    <th>요일</th>
                </tr>
                </thead>
                <tbody id="dataList"></tbody>
            </table>
            <%@ include file="/common/inc/com_pageNavi.inc" %>
        </div>
        <div class="form-group row"></div>
        <div class="bot_btns">
            <button class="btn_pack blue s2" type="button"  onclick="goPage('lecture','lecture_list')">목록가기</button>
            <button class="btn_pack blue s2" type="button"  onclick="goPage('lecture','lecture_modify')">수정</button>
        </div>
    </form>
</section>
</body>
</html>