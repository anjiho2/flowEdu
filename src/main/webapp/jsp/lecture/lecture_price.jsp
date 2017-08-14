<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>

<style>
    input[type="text"]:disabled{background-color:white;}
</style>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
    function init() {
        lecture_priceList();
    }

    function save_price() {
        var lecturePrice = getInputTextValue("lecturePrice");
        lectureService.saveLecturePrice(lecturePrice, function () {
            alert("저장되었습니다.");
            location.reload();
        });
    }

    function modify_price(val) {

        var lecturePriceId =  "price_"+val;
        var priceButton = "modify_"+val;
        var modify_price = getInputTextValue(lecturePriceId);

        lectureService.modifyLecutrePrice( val, modify_price, function () {
             alert("가격이 수정되었습니다.");
             location.reload();
         });
    }

    function change_price(val) {
        var lecturePriceId =  "change_"+val;
        var priceButton = "modify_"+val;

        gfn_display(priceButton, false);
        gfn_display(lecturePriceId, true);
        $("#price_"+val).removeAttr("disabled");
        $("#price_"+val).css("border","solid 1px black");
    }

    function lecture_priceList() {
        lectureService.getLecturePriceList( function (selList) {
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

        });
    }
    /*
    function Delete() { //강의가격삭제
        $("input[name=chk]:checked").each(function() {
            var lecture_price_id = $(this).val();

            if (lecture_price_id == "") {
                alert(comment.blank_check);
                return;
            }
            lectureService.deleteAcademy(officeid, function() {});
        });
        alert(comment.success_delete);
        location.reload();
    }
    */
</script>
<body onload="init();">
<form name="frm" id="frm" method="get">
<table>
    <tr>
        <th>가격 : </th>
        <td>
            &nbsp;
            <input type="text" id="lecturePrice">
        </td>
        <td><input type="button" onclick="save_price();" value="저장"></td>
    </tr>
</table>
    <h1>강의가격 LIST</h1>
    <div id="lecture_priceList" >
        <table border="1">
            <colgroup>
                <col width="2%" />
                <col width="48%" />
                <col width="50%" />
            </colgroup>
            <thead>
            <tr>
             <!--
             <th><input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');"></th>-->
                <th>가격</th>
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
