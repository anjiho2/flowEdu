<%@ page import="com.flowedu.util.Util" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 2;

    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int siderMenuDepth1 = 1;
    int siderMenuDepth2 = 2;
    int siderMenuDepth3 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/studentService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/lectureService.js'></script>
<script>

function init() {
    fn_search("new");
    innerValue("endDate", today());
    innerValue("startDate", getYear() + "-" + getMonthCount(-3) + "-" + getDayCount(-1));
}

function fn_search(val) {
    var student_id = getInputTextValue("studentId");
    var paging = new Paging();
    var sPage = $("#sPage").val();
    var startDate = getInputTextValue("startDate");
    var endDate = getInputTextValue("endDate");

    if (startDate == "") startDate = getYear() + "-" + getMonthCount(-3) + "-" + getDayCount(-1);
    if (endDate == "") endDate = today();
    if(val == "new") sPage = "1";

    gfn_emptyView("H", "");

    lectureService.getLectureStudentRelByStudentIdCount(student_id, startDate, endDate, function(cnt) {
        paging.count(sPage, cnt, '10', '5', comment.blank_lecture_list);
        //학생의 수강이력 가져오기
        lectureService.getLectureStudentRelById(student_id, startDate, endDate, function (selList) {
            if (selList.length > 0) {
                dwr.util.removeAllRows("dataList");
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    var cellData = [
                        function(data) {return cmpList.officeName;},
                        function(data) {return cmpList.lectureName;},
                        function(data) {return cmpList.chargeMemberName;},
                        function(data) {return cmpList.lectureStartDate;},
                        function(data) {return cmpList.lectureEndDate;},
                        function(data) {return convert_lecture_status(cmpList.lectureStatus);},

                    ];
                    dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                }
            }
        });
    });

}

function lecture_apply() {
    goPage("lecture","lecture_list");
}


$(document).ready(function() {
    $('input[type=radio][name=date_kind]').change(function() {
        var dateKind = this.value;
        var oldDate = getDayAgo(dateKind);
        var now = today();
        if (dateKind == 0) {
            oldDate = now;
        }
        innerValue("startDate", oldDate);
        innerValue("endDate", now);
    });
});

</script>
<body onload="">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/student_depth_menu.jsp" %>
</div>
</section>
<section class="content detail">
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="studentId" name="student_id" value="<%=student_id%>">
        <input type="hidden"  id="sPage" value="<%=sPage%>">
    </form>
        <div class="cont-wrap">
            <div class="tb_t1 colTable searchInfo">
                <table>
                    <colsgroup>
                        <col width="10%">
                        <col width="90%">
                    </colsgroup>
                    <tr>
                        <th>기간선택</th>
                        <td>
                            <div class="date-select">
                                <div class="input-group date common">
                                    <input type="text" id="startDate" class="form-control date-picker" placeholder="시작일">
                                    <span class="input-group-addon" id="datepicker_img">
                                        <span class="fa fa-calendar"></span>
                                    </span>
                                </div>
                            </div>
                            <div class="date-select">
                                <div class="input-group date common">
                                    <input type="text" id="endDate" class="form-control date-picker" placeholder="종료일">
                                    <span class="input-group-addon" id="datepicker_img2">
                                        <span class="fa fa-calendar"></span>
                                    </span>
                                </div>
                            </div>

                            <div class="checkbox_t1 black date-select">
                                <label>
                                    <input type="radio" name="date_kind" value="120">
                                    <span>120일</span>
                                </label>
                                <label>
                                    <input type="radio" name="date_kind" value="150">
                                    <span>150일</span>
                                </label>
                                <label>
                                    <input type="radio" name="date_kind" value="180">
                                    <span>180일</span>
                                </label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>검색정보</th>
                        <td>
                            <div class="form-group">
                                <div class="search-box clear">
                                    <select id="" class="form-control">
                                        <option value="">선택</option>
                                        <option value="">강의명</option>
                                        <option value="">담당 선생님</option>
                                    </select>
                                    <div class="search-input-box">
                                        <label><input type="text" class="form-control"  id="" placeholder="강의명 입력" onkeypress="" ></label>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>

                <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
            </div>

            <div class="tb_t1">
                <table>
                    <colsgroup>
                        <col width="35%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="10%" />
                        <col width="10%" />
                    </colsgroup>
                    <tr class="t_head">
                        <th>강의명</th>
                        <th>담당선생님</th>
                        <th>강의시작일</th>
                        <th>강의종료일</th>
                        <th>강의상태</th>
                        <th>수강상태</th>
                    </tr>
                    <tbody id="dataList">
                        <tr>
                            <td>영재학교 준비반</td>
                            <td>최고위</td>
                            <td>2018-01-02</td>
                            <td>2018-01-31</td>
                            <td>준비중</td>
                            <td><button class="btn_pack cancle" type="button" onclick="lecture_apply_popup();">취소</button></td>
                        </tr>
                        <tr>
                            <td>초등수학5</td>
                            <td>박진철</td>
                            <td>2017-11-01</td>
                            <td>2017-11-30</td>
                            <td>준비중</td>
                            <td>퇴원</td>
                        </tr>
                    </tbody>
                    <tr>
                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                    </tr>
                </table>
                <button class="btn_pack blue" onclick="">저장</button>
                <button class="btn_pack blue lecture_apply" onclick="lecture_apply_popup();">강의신청</button>

                <div class="form-group row"></div>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
            </div>
        </div>


</section>

<!-- 강의신청 레이어 시작-->
<div class="layer_popup_template apt_request_layer" id="lecture_apply_layer" style="display: none;width: 450px;">
    <div class="layer-title">
        <h3>강의검색</h3>
    </div>
    <div class="layer-body">
        <div class="cont">
        </div>

    <button id="close_btn" type="button" class="fa fa-close btn-close popup-close"></button>
</div>
<!-- 강의신청 팝업 레이어 끝 -->
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>
