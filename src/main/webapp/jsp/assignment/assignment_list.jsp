<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
function init() {
    myClassSelectbox("sel_myClass");
    gfn_emptyView("V", comment.assignment_class_type);
}

function  assignment_page(assignment_id) {
    innerValue("assignment_id", assignment_id);
    goPage('lecture', 'assignment_detail');
}

function fn_search(val) {
    dwr.util.removeAllRows("dataList");


    var sel_myclass = getSelectboxValue('sel_myClass');
    var sel_yn =  getSelectboxValue('assignment_yn');
    var startDate = getInputTextValue('startDate');
    var endDate = getInputTextValue('endDate');
    var homework_date =  $('input:radio[name=homework_date]:checked').val();
    var registe_info = getSelectboxValue('registe_info');
    var registe_content = getInputTextValue('registe_content');

    if(sel_myclass == ''){
        alert(comment.input_myclass_type);
        return;
    }

    if(sel_yn == 1) sel_yn = true;
    else sel_yn = false;

    dwr.util.removeAllRows("dataList");
    gfn_emptyView("H", "");

    lectureService.getAssignmentInfoList(0, sel_myclass, sel_yn, startDate, endDate, registe_content,function (selList) {
        if(selList.length > 0){
            var ynHTML;
            for(var i=0;i<selList.length;i++) {
                var cmpList = selList[i]

                if(cmpList.useYn == "true") ynHTML = '사용';
                else ynHTML = '미사용';


                if (cmpList != undefined) {
                    var assignment_subject = "<a href='javascript:void(0);' style='color:blue;' onclick='assignment_page(" + cmpList.assignmentIdx + ")'>" + cmpList.assignmentSubject + "</a>";
                    var cellData = [
                        function (data) {return i + 1;},
                        function (data) {return assignment_subject;},
                        function (data) {return cmpList.memberName;},
                        function (data) {return split_minute_getDay(cmpList.createDate);},
                        function (data) {return ynHTML;},
                    ];
                    dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                }
            }
        }else{
            gfn_emptyView("V", comment.blank_list2);
        }

    });
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
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <div class="title-top">학습관리</div>
</div>
</section>
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" id="assignment_id" name="assignment_id">
</form>
    <section class="content">
        <h3 class="title_t1">과제 관리</h3>
        <div class="tb_t1">
            <table>
                <tbody>
                    <tr>
                        <th>반</th>
                        <td>
                            <select id="sel_myClass" class="form-control">
                                <option value="">▶강의선택</option>
                            </select>
                        </td>
                        <th>사용여부</th>
                        <td>
                            <select class="form-control" id="assignment_yn">
                                <option value="1">사용</option>
                                <option value="0">사용하지않음</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>과제 등록일</th>
                        <td colspan="3">
                            <div class="form-group row marginX">
                                <div class="input-group date common" style="margin-right:10px;">
                                </div>
                                <input type="text" id="startDate" class="form-control date-picker">
                                <span class="input-group-addon">
                                        <span class="fa fa-calendar"></span>
                                    </span>
                                <div class="input-group date common" style="margin-right:10px;">
                                    <input type="text" id="endDate" class="form-control date-picker">
                                    <span class="input-group-addon">
                                        <span class="fa fa-calendar"></span>
                                    </span>
                                </div>
                                <div class="checkbox_t1 black">
                                    <label>
                                        <input type="radio" name="date_kind" value="0">
                                        <span>오늘</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="date_kind" value="7">
                                        <span>7일</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="date_kind" value="30" >
                                        <span>30일</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="date_kind" value="60" >
                                        <span>60일</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="date_kind" value="90" >
                                        <span>90일</span>
                                    </label>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>등록 정보</th>
                        <td colspan="3">
                            <div class="form-group row marginX">
                                <select class="form-control select-space" id="registe_info">
                                    <option value="">이름</option>
                                    <option value="">과제명</option>
                                </select>
                                <input type="text" class="form-control" id="registe_content">
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <button class="btn_pack blue" onclick="fn_search('new');">검색</button>
        </div>

        <div class="tb_t1 top-space">
            <table>
                <tbody>
                    <tr>
                        <th>No.</th>
                        <th>과제명</th>
                        <th>등록자</th>
                        <th>등록일</th>
                        <th>사용여부</th>
                    </tr>
                </tbody>
                <tbody id="dataList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
            <button class="btn_pack s2 blue" onclick="javascript:goPage('lecture', 'assignment_info')">등록</button>
        </div>
    </section>
<%@include file="/common/jsp/footer.jsp" %>
</body>
<script>
    $(".sidebar-menu > li").eq(2).addClass("active");
    $(".sidebar-menu > li:nth-child(3) > ul > li:nth-child(2) > a").addClass("on");
</script>
