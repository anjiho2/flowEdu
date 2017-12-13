<%@ page import="com.flowedu.util.Util" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 3;
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    String student_name = StringUtil.convertParmeterStr(request.getParameter("student_name"), "UTF-8");
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script>
    function init() {
        academyListSelectbox("l_academyList", "");
        innerValue("endDate", today());
        innerValue("startDate", getYear() + "-" + getMonth() + "-01" );
        attendTypeSelectbox("l_attendType", "");
        fn_search("new");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var studentId = getInputTextValue("student_id");
        var startDate = getInputTextValue("startDate");
        var endDate = getInputTextValue("endDate");
        var offceId = getSelectboxValue("sel_academyList");

        if (val == "new") sPage = "1";
        if (offceId == "") offceId = 0;

        gfn_emptyView("H", "");

        lectureService.getLectureAttendListByStudentIdCount(studentId, startDate, endDate, offceId, function(cnt) {
            paging.count(sPage, cnt, 10, 10, comment.not_attend_log);

            dwr.util.removeAllRows("dataList");

            lectureService.getLectureAttendListByStudentId(sPage, 10, studentId, startDate, endDate, offceId, function (selList) {
                if (selList.length == 0) return;
                //var changeBtn = "<button type='button' class='btn_pack blue' id='"+  +"' onclick='attend_comment_popup();'>상태변경</button>";
                dwr.util.addRows("dataList", selList, [
                    function(data) {return data.attendDate},
                    function(data) {return data.lectureName},
                    function(data) {return convert_attend(data.attendType)},
                    function(data) {return data.attendStartTime == null ? "-" : data.attendStartTime},
                    function(data) {return data.attendEndTime == null ? "-" : data.attendEndTime},
                    function(data) {return data.attendModifyComment == null ? "<button type='button' class='btn_pack blue' id='"+ data.lectureAttendId +"' onclick='attend_comment_popup(this.id);'>상태변경</button>" : data.attendModifyComment}
                ], {escapeHtml:false});
            });
        });
    }

    //상태변경 팝업
    function attend_comment_popup(lectureAttendId) {
        initPopup($("#attend_comment_layer"));
        innerValue("lecture_attend_id", lectureAttendId);
    }
    //수정버튼
    function changeAttendStatus() {
        var check = new isCheck();
        var lectureAttendId = getInputTextValue("lecture_attend_id");
        var attendType = getSelectboxValue("sel_attendType");
        var modifyComment = getInputTextValue("comment");

        if (check.selectbox("sel_attendType", "출석종류를 선택하세요.") == false) return;
        if (check.input("comment", "사유를 입력하세요.") == false) return;

        if (confirm(comment.isUpdate)) {
            lectureService.modifyAttendComment(lectureAttendId, attendType, modifyComment);
            alert(comment.success_update);
            isReloadPage(true);
        }
    }

</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/student_depth_menu.jsp" %>
</div>
</section>
<form name="frm" method="get">
    <input type="hidden" id="page_gbn" name="page_gbn">
    <input type="hidden" id="student_id" name="student_id" value="<%=student_id%>">
    <input type="hidden" id="student_name" name="student_name" value="<%=student_name%>">
    <input type="hidden" id="sPage" name="sPage" value="<%=sPage%>">
</form>
<section class="content">
    <div class="form-outer-group">
        <div class="form-group row">
            <h4 class="title_t1"><%=student_name%>학생의 출결현황 입니다.</h4>
        </div>
        <div class="form-group row">
            <span id="l_academyList"></span>
        </div>
        <div class="form-group row">
            <div class="input-group date" style="width:200px">
                <input type="text" id="startDate" class="form-control date-picker" placeholder="시작일">
                <span class="input-group-addon">
                    <span class="fa fa-calendar"></span>
                </span>
            </div>
        </div>
        <div class="form-group row">
            <div class="input-group date" style="width:200px">
                <input type="text" id="endDate" class="form-control date-picker" placeholder="종료일">
                <span class="input-group-addon">
                    <span class="fa fa-calendar"></span>
                </span>
            </div>
        </div>
        <div class="form-group row">
            <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
        </div>
    </div>
    <div class="tb_t1">
        <table>
            <colsgroup>
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
            </colsgroup>
            <tr>
                <th>등원일</th>
                <th>강의명</th>
                <th>출석상태</th>
                <th>등원시간</th>
                <th>하원시간</th>
                <th>비고</th>
            </tr>
            <tbody id="dataList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
        <div class="form-group row"></div>
        <%@ include file="/common/inc/com_pageNavi.inc" %>
    </div>
</section>
<!-- 출석상태 수정 레이어 시작 -->
<div class="layer_popup_template apt_request_layer" id="attend_comment_layer" style="display: none;">
    <input type="hidden" id="lecture_attend_id">
    <div class="layer-title">
        <h3>출석상태 수정사유를 입력해 주세요.</h3>
        <button class="fa fa-close btn-close"></button>
    </div>
    <div class="layer-body">
        <form name="pop_frm" class="form_st1">
            <div>
                <span id="l_attendType"></span>
            </div><br>
            <div>
                <textarea class="form-control" id="comment" rows="5" maxlength="50" placeholder="최대 50자까지만 입력가능합니다." onkeyup="gfn_chkStrLen(this.value, 50);"></textarea>
            </div>
        </form>
        <div class="bot_btns_t1">
            <button class="btn_pack blue" type="button" onclick="changeAttendStatus();">저장</button>
            <button class="btn_pack btn-close">취소</button>
        </div>
    </div>
</div>
<!-- 출석상태 수정 레이어 끝 -->
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>