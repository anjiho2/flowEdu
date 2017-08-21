<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureManager.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">

    function init() {
        fn_search("new");
    }

    function lecutre_detail_btn(lecture_id) {
        innerValue("lecture_id", lecture_id);
        goPage("lecture","lecture_detail");
    }

    function lecutre_modify_btn(lecture_id) {
        innerValue("lecture_id", lecture_id);
        goPage("lecture","lecture_modify");
    }

    function lecutre_calendar_btn(lecture_id) {
        innerValue("lecture_id", lecture_id);
        goPage("lecture","lecture_calendar");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        var title = $("#search_value").val();

        if(val == "new") {
            sPage = "1";
        }
        dwr.util.removeAllRows("dataList");

        lectureService.getLectureInfoCount( function(cnt) {
            paging.count(sPage, cnt, '10', '5', comment.blank_list);

            lectureService.getLectureInfoList(sPage, '5', '8', function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {

                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            // var checkHTML = "<input type='checkbox' name='chk' id='chk' value='" + cmpList.officeId + "'/>";
                            var detailHTML = "<input type='button'  value='상세' onclick='lecutre_detail_btn(" + cmpList.lectureId + ");'/>";
                            var modifyHTML = "<input type='button'  value='수정' onclick='lecutre_modify_btn(" + cmpList.lectureId + ");'/>";
                            var calendarHTML = "<input type='button'  value='달력보기' onclick='lecutre_calendar_btn(" + cmpList.lectureId + ");'/>";
                            var cellData = [

                                function(data) {return cmpList.officeName;},
                                function(data) {return cmpList.manageMemberName;},
                                function(data) {return cmpList.chargeMemberName;},
                                function(data) {return addThousandSeparatorCommas(cmpList.lecturePrice);},
                                function(data) {return cmpList.lectureName;},
                                function(data) {return convert_lecture_subject(cmpList.lectureSubject);},
                                function(data) {return convert_school(cmpList.schoolType);},
                                function(data) {return convert_lecture_level(cmpList.lectureLevel);},
                                function(data) {return convert_lecture_grade(cmpList.lectureGrade);},
                                function(data) {return cmpList.lectureOperationType == 'MONTH' ? '월' : '횟수';},
                                function(data) {return cmpList.lectureStartDate;},
                                function(data) {return cmpList.lectureEndDate;},
                                function(data) {return cmpList.lectureLimitStudent + "명";},
                                function(data) {return convert_lecture_status(cmpList.lectureStatus);},
                                function(data) {return detailHTML;},
                                function(data) {return modifyHTML;},
                                function(data) {return calendarHTML;}

                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }

            });
        });
    }
</script>

<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    <input type="hidden" name="lecture_id" id="lecture_id" value="">
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
                <!-- <th>
                     <input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');">
                 </th>-->
                <th>관명</th>
                <th>관리선생님</th>
                <th>담당선생님</th>
                <th>가격</th>
                <th>강의명</th>
                <th>강의과목</th>
                <th>학교구분</th>
                <th>학년</th>
                <th>레벨</th>
                <th>강의기간단위</th>
                <th>시작일</th>
                <th>종료일</th>
                <th>강의정원명</th>
                <th>강의상태</th>
                <th colspan="3"></th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
            <!--input type="button" value="삭제" onclick="Delete();">-->
        </table>
        <%@ include file="/common/inc/com_pageNavi.inc" %>
    </div>
    </div>
</form>

</body>
</html>
