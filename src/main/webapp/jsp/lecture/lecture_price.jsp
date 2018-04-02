<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 6;
    int depth2 = 3;

    int siderMenuDepth1 = 4;
    int siderMenuDepth2 = 0;
    int siderMenuDepth3 = 0;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<style>
    input[type="text"]:disabled{background-color:white;}
</style>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
    var check = new isCheck();
    function init() {
        /*수강료*/
        lecture_priceList();
        /*수강반*/
        academyListSelectbox("sel_academy","");
        lecture_roomList();
    }

    function save_price() {
        var lecturePrice = getInputTextValue("lecturePrice");
        if(check.input("lecturePrice","수강료를 입력해 주세요.") == false) return;
        lectureService.saveLecturePrice(lecturePrice, function () {
            alert("저장되었습니다.");
            location.reload();
        });
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
    function modify_price(val) {
        var lecturePriceId =  "price_"+val;
        var priceButton = "modify_"+val;
        var modify_price = uncomma(getInputTextValue(lecturePriceId));
        lectureService.modifyLecutrePrice( val, modify_price, function () {
             alert("가격이 수정되었습니다.");
             location.reload();
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
                        dwr.util.addRows("dataListRoom", [0], cellData, {escapeHtml:false});
                    }
                }
            }

        });
    }

    function change_price(val) {
        var lecturePriceId =  "change_"+val;
        var priceButton = "modify_"+val;
        gfn_display(priceButton, false);
        gfn_display(lecturePriceId, true);
        $("#price_"+val).removeAttr("disabled");
        $("#price_"+val).css("border","1px solid rgba(0,0,0,.15)");
    }

    function lecture_priceList() {
        lectureService.getLecturePriceList( function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        //var money = cmpList.lecturePrice.toLocaleString(); //금액 콤마 표시함수
                        var inputHTML = "<input type='text' class='form-control' id='price_"+cmpList.lecturePriceId+"' value='"+ addThousandSeparatorCommas(cmpList.lecturePrice)  +"' style='border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;' disabled>";
                        var modifyHTML = "<button class='btn_pack white ' type='button' id='modify_"+cmpList.lecturePriceId+"' onclick='change_price(" + cmpList.lecturePriceId + ");'/>변경</button><button class='btn_pack white' type='button'   id='change_"+cmpList.lecturePriceId+"' onclick='modify_price(" + cmpList.lecturePriceId + ");' style='display:none;'/>수정</button>";

                        var cellData = [
                            //function(data) {return checkHTML;},
                            function(data) {return inputHTML;},
                            function(data) {return modifyHTML;}
                        ];
                        dwr.util.addRows("dataListPrice", [0], cellData, {escapeHtml:false});
                    }
                }
            }

        });
    }
    function academy_sel_change(val) { //수강반 셀렉트박스onchange
        $("#dataListRoom").html("");
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
                        dwr.util.addRows("dataListRoom", [0], cellData, {escapeHtml: false});
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
<form name="frm" id="frm" method="get">
<section class="content divide">
        <!--수강료-->
        <div class="left">
            <div class="tile_box">
                <h3 class="title_t1">수강료 등록</h3>
                <input type="hidden" name="page_gbn" id="page_gbn">
                <div class="form-group row" style="width:82%;margin:40px auto;">
                        <input type="text" class="form-control" id="lecturePrice" style="width:200px;" placeholder="수강료">&nbsp;&nbsp;&nbsp;&nbsp;
                        <button class="btn_pack blue s2" type="button"  onclick="save_price();">등록</button>
                </div>
                <div class="tb_t1" style="width:82%;margin:40px auto;">
                    <table>
                        <colgroup>
                            <col width="*" />
                            <col width="*" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th>수강료</th>
                            <th>수정/변경</th>
                        </tr>
                        </thead>
                        <tbody id="dataListPrice"></tbody>
                    </table>
                </div>
            </div>
        </div>
        <!--수강료끝-->
        <!--강의반-->
        <div class="right">
            <div class="tile_box">
                 <h3 class="title_t1">강의반 등록</h3>
                    <div class="form-group row" style="width:82%;margin:40px auto;"><!--등록-->
                            <label id="sel_academy"></label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <label><input type="text" class="form-control" id="lectureName" placeholder="강의실명"></label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <button class="btn_pack blue s2" type="button"  onclick="save_room();">등록</button>
                    </div>
                 <!--   <div class="form-group row" style="width:200px;">
                        <div><span id="sel_academyList"></span></div>
                    </div>-->
                    <div class="tb_t1" style="width:82%;margin:40px auto;">
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
                            <tbody id="dataListRoom"></tbody>
                        </table>
                    </div>
            </div>
        </div>
    <!--강의반끝-->
</section>
</form>
</body>

