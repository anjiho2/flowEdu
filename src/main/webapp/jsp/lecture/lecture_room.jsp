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
        location.reload();
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
<!--
<style type="text/css">

    #test td:link,td:visited
    {
        display:block;
        width:120px;
        font-weight:bold;
        color:#FFFFFF;
        background-color:#da1111;
        text-align:center;
        padding:4px;
        text-decoration:none;
        text-transform:uppercase;
    }
    #test td:hover,td:active
    {
        background-color:#273824;
    }
</style>



<div style="list-style:none;">
    <table id="test" width="950px;" height="35px;" cellpadding="0" cellspacing="0" border="0" align="center" style="background-color:#da1111;text-align:center;">
        <tr>
            <td width="140" align="center"><a>기종별검색</a></td>
            <td width="135" align="center"><a>신상품</a></td>
            <td width="135" align="center"><a>신기종입고</a></td>
            <td width="135" align="center"><a>초특가 SALE</a></td>
            <td width="135" align="center"><a>장바구니</a></td>
            <td width="135" align="center"><a>주문 / 배송조회</a></td>
            <td width="135" align="center"><a>★ 즐겨찾기</a></td>
        </tr>
    </table>
    <!--<ul id="test" style="list-style:none;">
        <li><a href="http://www.phoneseason.com/board/view?id=notice&seq=122"><span>기종별검색</span></a></li>
        <li><a href="http://www.phoneseason.com/goods/catalog?code=0027"><span>신상품</span></a></li>
        <li><a href="http://www.phoneseason.com/goods/search?sort=newly&search_text=%EC%8B%A0%EA%B8%B0%EC%A2%85&old_search_text=%EC%8B%A0%EA%B8%B0%EC%A2%85"><span>신기종입고</span></a></li>
        <li><a href="http://www.phoneseason.com/goods/catalog?code=0029"><span>초특가 SALE</span></a></li>
        <li><a href="http://www.phoneseason.com/order/cart"><span>장바구니</span></a></li>
        <li><a href="http://www.phoneseason.com/mypage/order_catalog"><span>주문 / 배송조회</span></a></li>
        <li><a href="#"><span>★ 즐겨찾기</span></a></li>
    </ul>-->
</body>
</html>
