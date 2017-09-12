<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureManager.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type="text/javascript">

    function init(val) {

        var office_id = 0;
        if (val != undefined) {
             office_id = getInputTextValue("office_id");
        }
        schoolSelectbox("student_grade","", "");
        academyListSelectbox2("sel_academy", office_id);
        teacherList(office_id, "sel_member", "");
        //academy_sel_change();
        fn_search("new");
    }

    function lecture_page(lecture_id, lecture_type) {
        innerValue("lecture_id", lecture_id);
        goPage("lecture", lecture_type);
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        var office_id = getInputTextValue("office_id"); //관아이디
        var chargeMemberId = getSelectboxValue("sel_teacherList");
        var schoolType = get_radio_value("school_type");
        var lectureGrade = getSelectboxValue("sel_school");

        if(office_id == undefined && chargeMemberId == undefined && schoolType == undefined && lectureGrade == undefined ){
            office_id = 0;
            chargeMemberId = 0;
            schoolType = "";
            lectureGrade = 0;
        }
        if(val == "new") {
            sPage = "1";
        }
        dwr.util.removeAllRows("dataList");

        lectureService.getLectureInfoCount(office_id, chargeMemberId, schoolType, lectureGrade, function(cnt) {
            paging.count(sPage, cnt, '10', '5', comment.blank_list);

            lectureService.getLectureInfoList(sPage, '5', office_id, chargeMemberId, schoolType, lectureGrade, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            //cmpList.lectureStartDate
                            //cmpList.lectureEndDate
                            var detailHTML = "<input type='button'  value='상세' id='"+cmpList.lectureId+"' onclick='lecture_page(this.id, "+ '"' + 'lecture_detail' + '"' + ");'/>";
                            var modifyHTML = "<input type='button'  value='수정'  id='"+cmpList.lectureId+"' onclick='lecture_page(this.id, "+ '"' + 'lecture_modify' + '"' + ");''/>";
                            //var calendarHTML = "<input type='button'  value='달력보기'  id='"+cmpList.lectureId+"' onclick='lecture_page(this.id, "+ '"' + 'lecture_calendar' + '"' + ");''/>";
                            var applyHTML = "<input type='button'  value='강의신청' id='"+cmpList.lectureId+"' onclick='lecture_page(this.id, "+ '"' + 'lecture_apply' + '"' + ");' style='background:gray;'/>";

                            //출첵버튼 && 강의상태가 개강인것만
                            if(compareTime_startend(today(),cmpList.lectureStartDate,cmpList.lectureEndDate) && cmpList.lectureStatus == "OPEN"){
                                var attendHTML = "<input type='button'  value='출첵' id='"+cmpList.lectureId+"' onclick='lecture_page(this.id, "+ '"' + 'lecture_attend' + '"' + ");'/>";
                            }else{
                                 var attendHTML = "";
                            }
                            var cellData = [
                                function(data) {return cmpList.officeName;},
                                function(data) {return cmpList.lectureName;},
                                function(data) {return cmpList.chargeMemberName;},
                                function(data) {return cmpList.lectureStartDate;},
                                function(data) {return cmpList.lectureEndDate;},
                                function(data) {return cmpList.regCount + "명";},
                                function(data) {return cmpList.lectureLimitStudent + "명";},

                                function(data) {return detailHTML;},
                                function(data) {return modifyHTML;},
                               //function(data) {return calendarHTML;},
                                function(data) {return applyHTML;},
                                function(data) {return attendHTML;}
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }
            });
        });
    }

    function academy_sel_change(val) {
      //  if(val == undefined){
        //    $("#office_id").val("");
            //fn_search("new");
       // }else{
            $("#office_id").val(val);
            init(val);
            //fn_search("new");
        //}
    }
    function school_radio(school_grade) {
        schoolSelectbox("student_grade","", school_grade);
    }

</script>
<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden"  id="sPage" value="<%=sPage%>">
    <input type="hidden" name="lecture_id" id="lecture_id" value="">
    <input type="hidden" id="office_id" value="">
    <h1>강의상세정보리스트</h1>
    <div id="memberList">
        <span id="sel_academy"></span>
        <span id="sel_member"></span>
        <input type="radio" name="school_type" value="elem_list" onclick="school_radio(this.value);">초등학교
        <input type="radio" name="school_type" value="midd_list" onclick="school_radio(this.value);">중학교
        <input type="radio" name="school_type" value="high_list" onclick="school_radio(this.value);">고등학교
        <span id="student_grade"></span>
        <input type="button" value="검색" onclick="fn_search('new');">
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
            </colgroup>
            <thead>
            <tr>
                <!-- <th>
                     <input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');">
                 </th>-->
                <th>관명</th>
                <th>강의과목</th>
                <th>담당선생님</th>
                <th>시작일</th>
                <th>종료일</th>
                <th>현재정원명</th>
                <th>강의정원명</th>
                <th>상세</th>
                <th>수정</th>
                <!--<th>달력보기</th>-->
                <th>강의신청</th>
                <th>출첵</th>
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
