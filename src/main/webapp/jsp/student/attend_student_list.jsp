<%@ page import="com.flowedu.util.Util" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 3;

    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int siderMenuDepth1 = 1;
    int siderMenuDepth2 = 2;
    int siderMenuDepth3 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/lectureService.js'></script>
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

            lectureService.getLectureAttendListByStudentId(sPage, 10, studentId, startDate, endDate, offceId, function (selList) {
                if (selList.length == 0) return;
                dwr.util.removeAllRows("dataList");
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
    </section>
    <section class="content detail">
        <form name="frm" method="get">
            <input type="hidden" id="page_gbn" name="page_gbn">
            <input type="hidden" id="student_id" name="student_id" value="<%=student_id%>">
            <input type="hidden" id="sPage" name="sPage" value="<%=sPage%>">
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
                        </td>
                    </tr>
                    <tr>
                        <th>상태</th>
                        <td>
                            <div class="search-box">
                                <select id="" class="form-control">
                                    <option value="">전체</option>
                                    <option value="">출석</option>
                                    <option value="">결석</option>
                                    <option value="">지각</option>
                                    <option value="">조퇴</option>
                                </select>
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
                        <col width="10%" />
                        <col width="25%" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="25%" />
                    </colsgroup>
                    <tr class="t_head">
                        <th>등원일</th>
                        <th>강의명</th>
                        <th>담당선생님</th>
                        <th>출석상태</th>
                        <th>등원시간</th>
                        <th>하원시간</th>
                        <th>비고</th>
                    </tr>
                    <tbody id="dataList">
                        <tr>
                            <td>2017-12-06</td>
                            <td>수학의 아침5</td>
                            <td>염희정</td>
                            <td>출석</td>
                            <td>16:30</td>
                            <td>17:20</td>
                            <td><button class="btn_pack state" onclick="attend_comment_popup();">상태변경</button></td>
                        </tr>
                    </tbody>
                    <tr>
                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                    </tr>
                </table>
                <div class="form-group row"></div>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
            </div>
        </div>
    </section>


    <!-- 출석상태 수정 레이어 시작 -->
    <div class="layer_popup_template apt_request_layer" id="attend_comment_layer" style="display: none;width:500px">
        <input type="hidden" id="lecture_attend_id">
        <div class="layer-title">
            <h3>출석상태 변경 사유를 입력해 주세요.</h3>
        </div>
        <div class="layer-body">
            <div class="cont">
                <form name="pop_frm" class="form_st1">
                    <div>
                        <select class="form-control">
                            <option value="">출석</option>
                            <option value="">지각</option>
                            <option value="">결석</option>
                            <option value="">조퇴</option>
                            <option value="">보강</option>
                        </select>
                    </div><br>
                    <div>
                        <textarea class="form-control" id="comment" rows="5" maxlength="50" placeholder="최대 50자까지만 입력가능합니다." onkeyup="gfn_chkStrLen(this.value, 50);"></textarea>
                    </div>
                </form>
            </div>
            <div class="bot_btns_t1">
                <button class="btn_pack blue" type="button" onclick="changeAttendStatus();">저장</button>
                <button class="btn_pack btn-close">취소</button>
            </div>
        </div>

        <button class="fa fa-close btn-close popup-close"></button>
    </div>
    <!-- 출석상태 수정 레이어 끝 -->
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>