<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
function init() {
    academyListSelectbox("sel_academy","");
    lecture_roomList();
}
function save_room() {

    var lectureName = getInputTextValue("lectureName");
    var academyId = getSelectboxValue("sel_academyList");

    lectureService.saveLectureRoom(academyId,lectureName, function () {
        alert("저장되었습니다.");
        location.reload();
    });
}

function lecture_roomList() {
   /* lectureService.getLecturePriceList( function (selList) {
        console.log(selList);
        if (selList.length > 0) {
            for (var i = 0; i < selList.length; i++) {
                var cmpList = selList[i];
                if (cmpList != undefined) {
                    // var checkHTML = "<input type='checkbox' name='chk' id='chk' value='" + cmpList.lecturePriceId + "'/>";
                    var inputHTML = "<input type='text' id='price_"+cmpList.lecturePriceId+"' value='"+cmpList.lecturePrice+"' style='border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;' disabled>";
                    var modifyHTML = "<input type='button' id='modify_"+cmpList.lecturePriceId+"' value='변경' onclick='change_price(" + cmpList.lecturePriceId + ");'/><input type='button'   id='change_"+cmpList.lecturePriceId+"' value='수정' onclick='modify_price(" + cmpList.lecturePriceId + ");' style='display:none;'/>";

                    var cellData = [
                        //function(data) {return checkHTML;},
                        function(data) {return inputHTML;},
                        function(data) {return modifyHTML;}
                    ];
                    dwr.util.addRows("dataList", [0], cellData, {escapeHtml:false});
                }
            }
        }

    });*/
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
                <th>수정/변경</th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
        </table>
        <input type="button" value="삭제" onclick="Delete();">
    </div>

</form>
</body>
</html>
