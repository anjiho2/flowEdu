<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type="text/javascript">
    function save_academy() { //학원정보 저장
        var check = new isCheck();

        if(check.input("academy_name", comment.input_academy_name) == false) return;
        if(check.input("academy_directorname", comment.input_academy_directorname) == false) return;
        if(check.input("academy_phone1", comment.input_academy_phone1) == false) return;
        if(check.input("academy_phone2", comment.input_academy_phone2) == false) return;
        if(check.input("academy_phone3", comment.input_academy_phone3) == false) return;
        if(check.input("academy_address", comment.input_academy_address) == false) return;
        if(check.input("academy_fax", comment.input_academy_fax) == false) return;

        var academy_name            = getInputTextValue("academy_name");
        var academy_directorname    = getInputTextValue("academy_directorname");
        var academy_phone1          = getInputTextValue("academy_phone1");
        var academy_phone2          = getInputTextValue("academy_phone2");
        var academy_phone3          = getInputTextValue("academy_phone3");
        var academy_allphone        = academy_phone1+academy_phone2+academy_phone3;
        var academy_address         = getInputTextValue("academy_address");
        var academy_fax             = getInputTextValue("academy_fax");

        academyService.saveAcademy(academy_name,academy_directorname,academy_address,academy_allphone,academy_fax,function () {
            alert("학원정보가 등록 되었습니다.");
            location.reload();
        });
    }

   function academy_modify(officeid) { //수정페이지 이동
        innerValue("office_id", officeid);
        goPage('academy', 'modify_academy');
}

    function academyList() { //학원정보리스트 가져오기
        academyService.getAcademyList(0, function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        //var checkHTML = "<input type='checkbox' name='chk' id='chk' value='" + cmpList.officeId + "'/>";
                        var modifyHTML = "<input type='button' name='modify' id='modify' value='수정' onclick='academy_modify(" + cmpList.officeId + ");'/>";

                        var cellData = [
                           // function(data) {return checkHTML;},
                            function(data) {return cmpList.officeName;},
                            function(data) {return cmpList.officeDirectorName;},
                            function(data) {return cmpList.officeTelNumber;},
                            function(data) {return cmpList.officeAddress;},
                            function(data) {return cmpList.officeFaxNumber;},
                            function(data) {return getDateTimeSplitComma(cmpList.createDate);},
                            function(data) {return modifyHTML;}
                        ];

                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                    }
                }
            }
        });
    }

    /*function Delete() { //학원정보 삭제
        confirm("삭제 하시겠습니까?");
       $("input[name=chk]:checked").each(function() {
            var officeid = $(this).val();

            if (officeid == "") {
                alert(comment.blank_check);
                return;
            }
            academyService.deleteAcademy(officeid, function() {});
        });
       alert(comment.success_delete);
       location.reload();
    }*/


</script>
<body onload="academyList();academyList2();">
<form name="frm" method="get">
    <input type="hidden" name="office_id" id="office_id">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <h1>학원정보입력page</h1>
    <table>
        <tr>
            <th>관명</th>
            <td>
                <input type="text" id="academy_name">
            </td>
        </tr>
        <tr>
            <th>원장이름</th>
            <td>
                <input type="text" id="academy_directorname">
            </td>
        </tr>
        <tr>
            <th>관 전화번호</th>
            <td>
                <input type="text" size="2" id="academy_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.academy_phone2,3)">
                -
                <input type="text" size="5" id="academy_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.academy_phone3,4)">
                -
                <input type="text" size="5" id="academy_phone3" maxlength="4">
            </td>
        </tr>
        <tr>
            <th>주소</th>
            <td>
                <input type="text" id="academy_address">
            </td>
        </tr>
        <tr>
            <th>팩스번호</th>
            <td>
                <input type="text" id="academy_fax">
            </td>
        </tr>
    </table>
    <input type="button" value="등록" onclick="save_academy();">


<h1>학원정보list</h1>
<div id="academyList">
    <table class="table_list" border="1">
        <colgroup>
            <!--<col width="2%" />-->
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
            <!--<th>
                <input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');">
            </th>-->
            <th>관명</th>
            <th>원장명</th>
            <th>관전화번호</th>
            <th>주소</th>
            <th>팩스번호</th>
            <th>생성일</th>
            <th>수정</th>
        </tr>
        </thead>
        <tbody id="dataList"></tbody>
        <!--<input type="button" value="삭제" onclick="Delete();">-->
    </table>
</div>
</form>
</body>
</html>
