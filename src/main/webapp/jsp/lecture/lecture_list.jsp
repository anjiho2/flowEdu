<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int siderMenuDepth1 = 4;
    int siderMenuDepth2 = 5;
    int siderMenuDepth3 = 3;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/studentService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
    function init(val) {
        if(val == undefined) {
            val = "ELEMENT";
            schoolTypeSelectbox("l_schoolType", val);
            schoolSelectbox("student_grade", "", val);
            searchAcademySelectbox("sel_academy", ""); //소속
            academyGroupSelectbox("sel_group", "");//그룹
            lectureStatusSelectbox("sel_lectureState", "");
            lectureSubjectSelectbox("sel_lectureSubject", "");
        }else{
            schoolTypeSelectbox("l_schoolType", val);
            schoolSelectbox("student_grade", "", val);
        }

        gfn_emptyView("V", comment.search_lecture);

    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();

        var academy_group =  getSelectboxValue("sel_group", "");//그룹
        var academy    =  getSelectboxValue("sel_academy", "");//학원
        var schoolType = convert_school_value(getSelectboxValue("sel_schoolType", ""));//학교구분
        var schoolNum  =  getSelectboxValue("sel_school", "");//학년구분
        var subject    =  getSelectboxValue("sel_lectureSubject", "");//과목
        var lectureState = getSelectboxValue("sel_lectureState", "");//강의상태
        var sel_search = getSelectboxValue("sel_search", "");//검색정보
        var search_info = getInputTextValue("search_info");

        if(val == "new")  sPage = "1";
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");//페이징 예외사항처리

        lectureService.getLectureInfoCount(academy_group, academy, schoolType, schoolNum, subject, lectureState, sel_search, search_info, function(cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링d
            lectureService.getLectureInfoList(sPage, '10', academy_group, academy, schoolType, schoolNum, subject, lectureState, sel_search, search_info, function (selList) {
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return listNum--;},
                    function(data) {return data.academyGroupName;},
                    function(data) {return data.officeName;},
                    function(data) {return "<a href='javascript:void(0);' style='color:blue;' onclick='lecture_page(" + data.lectureId + ")'>" + data.lectureName + "</a>";},
                    function(data) {return lecture_convert_school(data.schoolType);},
                    function(data) {return data.lectureGrade == ""? "-" : data.lectureGrade;},
                    function(data) {return data.memberName;},//선생님
                    function(data) {return data.regCount + " / " + data.lectureLimitStudent;},
                    function(data) {return convert_lecture_status(data.lectureStatus);},
                ],
                {
                cellCreator:function(options) {
                    console.log(options.rowData);
                    var td = document.createElement("td");
                    var index = 255 - (options.rowIndex * 50);
                    if (options.rowData.lectureStatus == "CLOSE") {
                        td.style.backgroundColor = "#e9edef";
                    }
                    return td;
                },
                escapeHtml:false});
            });
        });
    }

    function lecture_page(lecture_id) {
        innerValue("lecture_id", lecture_id);
        goPage('lecture', 'lecture_info');
    }
</script>

<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <div class="title-top">강의관리</div>
</div>
</section>
<section class="content">
    <h3 class="title_t1">강의관리</h3>
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="lecture_id" id="lecture_id">
        <input type="hidden" id="sPage" value="<%=sPage%>">
    </form>
    <div class="tb_t1">
        <table>
            <tr>
                <th>그룹</th>
                <td>
                    <select id="sel_group" class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
                <th>학원</th>
                <td>
                    <select id="sel_academy" class="form-control">
                        <option value="">전체</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>학교구분<b>*</b></th>
                <td>
                    <span id="l_schoolType"></span>
                </td>
                <th>학년구분<b>*</b></th>
                <td>
                    <span id="student_grade"></span>
                </td>
            </tr>
            <tr>
                <th>과목구분</th>
                <td>
                    <select  class="form-control" id="sel_lectureSubject">
                        <option value="">전체</option>
                    </select>
                </td>
                <th>강의상태</th>
                <td>
                    <select id="sel_lectureState" class="form-control">
                        <option value="">전체</option>
                    </select>
                </td>
            </tr>

            <tr>
                <th>검색정보</th>
                <td colspan="3">
                    <div class="form-group row marginX">
                        <select class="form-control select-space" id="sel_search">
                            <option value="name">이름</option>
                            <option value="phone">핸드폰번호</option>
                        </select>
                        <input type="text" class="form-control" id="search_info">
                    </div>
                </td>
            </tr>
        </table>
        <button class="btn_pack blue" onclick="fn_search('new')">검색</button>
    </div>

    <div class="tb_t1 top-space">
        <table>
            <thead>
            <tr>
                <th>No.</th>
                <th>그룹</th>
                <th>학원</th>
                <th>강의</th>
                <th>학교</th>
                <th>학년</th>
                <th>선생님</th>
                <th>정원</th>
                <th>상태</th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
        <button class="btn_pack blue s2" onclick="javascript:goPage('lecture', 'save_lecture')">등록</button>
    </div>
    <%@ include file="/common/inc/com_pageNavi.inc" %>
</section>
<%@include file="/common/jsp/footer.jsp" %>
</body>
</html>

<!--

<script type='text/javascript' src='<%=webRoot%>/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/lectureManager.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/memberService.js'></script>
<script type="text/javascript">

    function init(val) {
        var office_id;

        if (val == "" || val == undefined) office_id = 0;
        else office_id = getInputTextValue("office_id");

        schoolSelectbox("student_grade","", "");
        academyListSelectbox2("sel_academy", office_id);
        teacherList(office_id, "sel_member", "");
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

        if(office_id == undefined || chargeMemberId == undefined || schoolType == undefined || lectureGrade == undefined ){
            office_id = 0;
            chargeMemberId = 0;
            schoolType = "elem_list";
            lectureGrade = 0;
        }
        if(val == "new")  sPage = "1";
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");//페이징 예외사항처리

        lectureService.getLectureInfoCount(office_id, chargeMemberId, schoolType, lectureGrade, function(cnt) {
            paging.count(sPage, cnt, '10', '5', comment.blank_list);

            lectureService.getLectureInfoList(sPage, '5', office_id, chargeMemberId, schoolType, lectureGrade, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            //<button class='btn_pack blue s2' type='button'  onclick="modify_member();">저장</button>
                            var detailHTML = "<button class='btn_pack white' style='min-width:75px;' type='button' id='"+cmpList.lectureId+"' onclick='lecture_page(this.id, "+ '"' + 'lecture_detail' + '"' + ");'/>상세</button>";
                            //var modifyHTML = "<button class='btn_pack white' style='min-width:75px;' type='button' id='"+cmpList.lectureId+"' onclick='lecture_page(this.id, "+ '"' + 'lecture_modify' + '"' + ");''/>수정</button>";
                            var calendarHTML = "<button class='btn_pack white' style='min-width:75px;'    id='"+cmpList.lectureId+"' onclick='lecture_page(this.id, "+ '"' + 'lecture_calendar' + '"' + ");''/>달력보기</button>";
                            var applyHTML = "<button class='btn_pack white' style='min-width:75px;' type='button'  id='"+cmpList.lectureId+"' onclick='lecture_page(this.id, "+ '"' + 'lecture_apply' + '"' + ");' style='background:gray;'/>강의신청</button>";

                            //출첵버튼 && 강의상태가 개강인것만
                            if(compareTime_startend(today(),cmpList.lectureStartDate,cmpList.lectureEndDate) && cmpList.lectureStatus == "OPEN"){
                                var attendHTML = "<button class='btn_pack white' style='min-width:75px;' type='button'  id='"+cmpList.lectureId+"' onclick='lecture_page(this.id, "+ '"' + 'lecture_attend' + '"' + ");'/>출첵</button>";
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
                                function(data) {return calendarHTML;},
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
            $("#office_id").val(val);
            init(val);
    }
    function school_radio(school_grade) {
        schoolSelectbox("student_grade","", school_grade);
    }

</script>
<body onload="init();">
<div class="container">

</div>
</section>
<section class="content">
    <h3 class="title_t1">강의상세정보리스트</h3>
    <form name="frm" id="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden"  id="sPage" value="<%=sPage%>">
        <input type="hidden" name="lecture_id" id="lecture_id" value="">
        <input type="hidden" id="office_id" value="">
        <div class="form-group row"><!--검색-->
           <!--<div class="checkbox_t1">
                <label id="sel_academy"></label>
                <label id="sel_member"></label>
                <label><input type="radio" name="school_type" value="elem_list" checked><span>초등학교</span></label>
                <label><input type="radio" name="school_type" value="midd_list" ><span>중학교</span></label>
                <label><input type="radio" name="school_type" value="high_list" ><span>고등학교</span></label>
                <label id="student_grade"></label>
                <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
            </div>
        </div>
        <div class="tb_t1"><!--리스트-->
       <!-- <table>
            <colgroup>
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
                <th>관명</th>
                <th>강의과목</th>
                <th>담당선생님</th>
                <th>시작일</th>
                <th>종료일</th>
                <th>현재정원명</th>
                <th>강의정원명</th>
                <th>상세/수정</th>
                <th>달력보기</th>
                <th>강의신청</th>
                <th>출첵</th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
            <!--input type="button" value="삭제" onclick="Delete();">-->
        <!--</table>
        <div class="form-group row"></div>

    </div>
    </div>
    </form>
</section>
</body>
</html>