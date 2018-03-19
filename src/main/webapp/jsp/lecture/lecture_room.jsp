<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 5;
    int depth2 = 4;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
function init() {
    academyListSelectbox("sel_academy","");
    lecture_roomList();
}
function save_room() {
    var lectureName = getInputTextValue("lectureName");
    var academyId = getSelectboxValue("sel_academyList");
    var check = new isCheck();
    if(check.selectbox("sel_academyList","관을 선택해 주세요.") == false) return;
    if(check.input("lectureName","강의실명을 입력해 주세요.") == false) return;
    lectureService.saveLectureRoom(academyId,lectureName, function () {
        alert("저장되었습니다.");
        isReloadPage(true)
    });
}

function lecture_roomList() {
   lectureService.getLectureRoomList( function (selList) {
        if (selList.length > 0) {
            for (var i = 0; i < selList.length; i++) {
                var cmpList = selList[i];
                if (cmpList != undefined) {
                    var cellData = [
                        //function(data) {return checkHTML;},
                        function(data) {return cmpList.officeName;},
                        function(data) {return cmpList.lectureRoomName;}
                    ];
                    dwr.util.addRows("dataList", [0], cellData, {escapeHtml:false});
                }
            }
        }

    });
}

function academy_sel_change(val) {
        $("#dataList").html("");
        lectureService.getLectureRoomList(val, function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var cellData = [
                            //function(data) {return checkHTML;},
                            function (data) {
                                return cmpList.officeName;
                            },
                            function (data) {
                                return cmpList.lectureRoomName;
                            }
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
    <h3 class="title_t1">강의룸</h3>
    <form name="frm" id="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <div class="form-group row"><!--등록-->
            <div class="checkbox_t1">
                <label id="sel_academy"></label>
                <label><input type="text" class="form-control" id="lectureName" placeholder="강의실명"></label>
                <button class="btn_pack blue s2" type="button"  onclick="save_room();">등록</button>
            </div>
        </div>
        <div class="form-group row" style="width:200px;">
            <div><span id="sel_academyList"></span></div>
        </div>
        <div class="tb_t1">
            <table>
                <colgroup>
                    <col width="40%" />
                    <col width="40%" />
                    <col width="20%" />
                </colgroup>
                <thead>
                <tr>
                    <th>관명</th>
                    <th>강의실명</th>
                </tr>
                </thead>
                <tbody id="dataList"></tbody>
            </table>
        </div>
    </form>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>

