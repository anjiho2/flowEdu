<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
function init() {
    academyListSelectbox("sel_academy","");
    academyListSelectbox2("sel_academyList","");
    lecture_roomList();
}
function save_room() {
    var lectureName = getInputTextValue("lectureName");
    var academyId = getSelectboxValue("sel_academyList");
    lectureService.saveLectureRoom(academyId,lectureName, function () {
        alert("저장되었습니다.");
        isReloadPage(true)
    });
}

function lecture_roomList() {
   lectureService.getLectureRoomList( function (selList) {
        console.log(selList);
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
            console.log(selList);
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
<form name="frm" id="frm" method="get">
    <table>
        <tr>
            <th>관선택 : </th>
             <td><span id="sel_academy"></span></td>
        </tr>
        <tr>
            <th>강의실명 : </th>
            <td><input type="text" id="lectureName"></td>
        </tr>
        <td><input type="button" onclick="save_room();" value="저장"></td>
    </table>
    <h1>강의room LIST</h1>
    <div>
        <span id="sel_academyList"></span>
        <table border="1">
            <colgroup>
                <col width="40%" />
                <col width="40%" />
                <col width="20%" />
            </colgroup>
            <thead>
            <tr>
                <!--
                <th><input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');"></th>-->
                <th>관명</th>
                <th>강의실명</th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
        </table>
        <input type="button" value="삭제" onclick="Delete();">
    </div>
</form>
</body>
</html>
