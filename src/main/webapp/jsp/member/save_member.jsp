<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">


    /* function openDaumPostcode() {
     new daum.Postcode({
     oncomplete: function(data) {
     // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분. 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
         document.getElementById("addr1").value = data.postcode1;
         document.getElementById("addr2").value = data.postcode2;
         document.getElementById("member_address").value = data.address;
         document.getElementById("member_address2").focus();
     }
     }).open();
     }
*/

     // 우편번호 찾기 화면을 넣을 element
     var element = document.getElementById('layer');

     function closeDaumPostcode() {
         // iframe을 넣은 element를 안보이게 한다.
         element.style.display = 'none';
     }

     function openDaumPostcode() {
         new daum.Postcode({
             oncomplete: function(data) {
                 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분. 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                 document.getElementById("addr1").value = data.postcode1;
                 document.getElementById("addr2").value = data.postcode2;
                 document.getElementById("member_address").value = data.address;
                 document.getElementById("member_address2").focus();
                 // iframe을 넣은 element를 안보이게 한다.
                 element.style.display = 'none';
             },
             width : '100%',
             height : '100%'
         }).embed(element);

         // iframe을 넣은 element를 보이게 한다.
         element.style.display = 'block';
     }

    function init() {
        memberTypeSelectbox("sel_memberType", "");//직원타입
        //jobPositionSelectbox("l_jobPosition","");//직책리스트
        jobPositionSelectbox("sel_jobPosition", "");
        academyListSelectbox("sel_academy","");//학원리스트
        flowEduTeamListSelectbox("l_FlowEduTeam","");//소속팀리스트
    }

    function save_member() { // 운영자.선생님정보등록
        var check = new isCheck();
        var sel_memberType = getSelectboxValue("sel_memberType");

        if(sel_memberType == ''){
            alert(comment.input_member_type);
            return false;
        }
        if(check.input("member_name", comment.input_member_name)       == false) return;
        if(check.input("startDate", comment.input_member_startDate)    == false) return;
        if(check.input("member_address", comment.input_member_address) == false) return;
        if(check.input("sel_jobPosition", comment.input_member_posiotion)    == false) return;
        if(check.input("sel_academyList", comment.input_member_academy)    == false) return;
        if(check.input("sel_FlowEduTeamList", comment.input_member_team)    == false) return;
        if(check.input("member_email", comment.input_member_email)     == false) return;
        if(check.input("startSearchDate", comment.input_member_startSearchDate)   == false) return;

        var member_email   = getInputTextValue("member_email");
        if(member_email){ //이메일 유효성 체크
            var is_email = fn_isemail(member_email);
            if (is_email == true) return false;
        }

        var member_name          = getInputTextValue("member_name");//직원명
        var member_phone1        = getInputTextValue("member_phone1");
        var member_phone2        = getInputTextValue("member_phone2");
        var member_phone3        = getInputTextValue("member_phone3");
        var member_allphone      = member_phone1+member_phone2+member_phone3;//핸드폰번호
        var startDate            = getInputTextValue("startDate");//생년월일
        var member_address       = getInputTextValue("member_address");//주소
        var member_email         = getInputTextValue("member_email");//이메일
        var startSearchDate      = getInputTextValue("startSearchDate");//성범죄경력조회확인일자
        var startSearchDate2     = getInputTextValue("startSearchDate2");//교육청강사등록일자
        var sel_academy          = getSelectboxValue("sel_academyList");
        var l_FlowEduTeam        = getSelectboxValue("l_FlowEduTeam");
        var sel_jobPosition      = getSelectboxValue("sel_jobPosition");
        var memtype = $("#sel_memberType option:selected").text();
        var memtypeval = getSelectboxValue("sel_memberType");

        if(memtypeval == "TEACHER" || memtypeval == "TEACHER_MANAGE"){
            if(check.input("startSearchDate2", comment.input_member_startSearchDate2)  == false) return;
        }else{
            startSearchDate2 = null;
        }

        gfn_display("loadingbar", true);

        memberService.isMember(member_allphone, function (bl) {
            if(bl==true){
                gfn_display("loadingbar", false);
                alert("이미 가입된 전화번호가 있습니다.");
                return false;
            }else{
                //저장
                memberService.saveFlowEduMember(sel_academy,l_FlowEduTeam,sel_jobPosition,member_allphone,member_phone3,member_name,
                    startDate,member_address,member_email,startSearchDate,startSearchDate2,sel_memberType,function () {
                        alert(memtype + " 정보가 등록 되었습니다.");
                        gfn_display("loadingbar", false);
                        goPage("member","list_member");
                    });
            }
        });
    }
    
    $(function () {
       $('#sel_memberType').change(function () {
           var memtypeval = getSelectboxValue("sel_memberType");
           if(memtypeval == 'TEACHER' ||memtypeval == 'TEACHER_MANAGE'){
               $(".hiddenDate2").show();
           }else{
               $(".hiddenDate2").hide();
           }
       });
    });

</script>
<style><%--성범죄확인일자/교육청강사등록일자로인한 style예외처리--%>
.form-group.row>label {-webkit-box-flex: 0;-ms-flex: 0 0 140px;flex: 0 0 187px;}
</style>
<body onload="init();">
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/member_top_menu.jsp" %>--%>
    <div class="title-top">운영관리</div>
</div>
</section>
<section class="content">
    <h3 class="title_t1">운영자관리</h3>
    <form name="frm" method="get">
        <input type="hidden" name="member_id" id="member_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">

        <div class="tb_t1">
            <table>
                <tr>
                    <th>유형<b>*</b></th>
                    <td>
                        <select class="form-control">
                            <option>선택</option>
                            <option>AMS관리자</option>
                            <option>강사</option>
                            <option>CS</option>
                        </select>
                    </td>
                    <th>직책<b>*</b></th>
                    <td>
                        <select class="form-control">
                            <option>선택</option>
                            <option>원장</option>
                            <option>부원장</option>
                            <option>팀장</option>
                            <option>실장</option>
                            <option>팀원</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>소속<b>*</b></th>
                    <td>
                        <select class="form-control">
                            <option>선택</option>
                            <option>수학의아침</option>
                            <option>사이언스카이</option>
                            <option>다빈치코드</option>
                            <option>TEdI</option>
                            <option>플로우교육</option>
                        </select>
                    </td>
                    <th>소속팀</th>
                    <td><input type="text" class="form-control"></td>
                </tr>
                <tr>
                    <th>이름<b>*</b></th>
                    <td><input type="text" class="form-control"></td>
                    <th>핸드폰번호<b>*</b></th>
                    <td>
                        <div class="form-group row marginX">
                            <div class="inputs">
                                <input type="number" size="3" class="form-control" maxlength="3" max="999">&nbsp;-&nbsp;
                                <input type="number" size="4" class="form-control" maxlength="4" max="9999">&nbsp;-&nbsp;
                                <input type="number" size="4" class="form-control" maxlength="4" max="9999">
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td><input type="text" class="form-control"></td>
                    <th>생년월일</th>
                    <td>
                        <div class="input-group date common">
                            <input type="text" id="startDate" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>주소<b>*</b></th>
                    <td colspan="3">
                        <div class="form-group row">
                            <input type="text" class="form-control" style="width: 10rem;" placeholder="우편번호">&nbsp;
                            <button class="btn_pack">우편번호 검색</button>
                        </div>
                        <div class="form-group row marginX">
                            <input type="text" class="form-control">
                            <input type="text" class="form-control">
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>성범죄조회 확인일</th>
                    <td>
                        <div class="input-group date common">
                            <input type="text" id="endDate" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </td>
                    <th>교육청 강사등록일</th>
                    <td>
                        <div class="input-group date common">
                            <input type="text" id="Date" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>상태</th>
                    <td>
                        <select class="form-control">
                            <option>재직</option>
                            <option>퇴사</option>
                        </select>
                    </td>
                    <td colspan="2"></td>
                </tr>
            </table>
            <button class="btn_pack s2 blue">저장</button>
            <button class="btn_pack s2 blue">목록</button>
        </div>
        <%--<div class="form-group row">--%>
            <%--<label>직원타입<b>*</b></label>--%>
            <%--<div>--%>
                <%--&lt;%&ndash;<span id="l_memberType"></span>&ndash;%&gt;--%>
                <%--<select id="sel_memberType" class="form-control">--%>
                    <%--<option value="">▶선택</option>--%>
                <%--</select>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>직원명<b>*</b></label>--%>
            <%--<div><input type="text" class="form-control" id="member_name" style="width:150px;"></div>--%>
        <%--</div>--%>
        <%--<div class="form-outer-group">--%>
            <%--<div class="form-group row">--%>
                <%--<label>생년월일<b>*</b></label>--%>
                <%--<div><input type="text" id="startDate" class="form-control date-picker" style="width:200px;"></div>--%>
            <%--</div>--%>
            <%--<div class="form-group row">--%>
                <%--<label>핸드폰번호</label>--%>
                <%--<div class="inputs">--%>
                    <%--<input type="number" id="member_phone1" size="4" class="form-control" maxlength="3"  onkeyup="js_tab_order(this,'member_phone2',3)">&nbsp;-&nbsp;--%>
                    <%--<input type="number" id="member_phone2" size="5" class="form-control" maxlength="4"  onkeyup="js_tab_order(this,'member_phone3',4)">&nbsp;-&nbsp;--%>
                    <%--<input type="number" id="member_phone3" size="5" class="form-control" maxlength="4"  >--%>

                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>주소<b>*</b></label>--%>
            <%--<input type="button" value="우편번호" onclick="openDaumPostcode();">--%>
            <%--<div><input type="text" class="form-control" id="addr1" style=""></div>--%>
            <%--<div><input type="text" class="form-control" id="addr2" style=""></div>--%>
            <%--<div><input type="text" class="form-control" id="member_address" style="width:422px;"></div>--%>
            <%--<div><input type="text" class="form-control" id="member_address2" style="width:300px;"></div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>이메일</label>--%>
            <%--<div><input type="email" class="form-control datepicker" id="member_email" style="width:422px;"></div>--%>
        <%--</div>--%>
        <%--<div class="form-outer-group">--%>
            <%--<div class="form-group row">--%>
                <%--<label>직책<b>*</b></label>--%>
                <%--&lt;%&ndash;<div><span id="l_jobPosition"></span></div>&ndash;%&gt;--%>
                <%--<div>--%>
                    <%--<select id="sel_jobPosition" class="form-control">--%>
                        <%--<option value=''>▶선택</option>--%>
                    <%--</select>--%>
                    <%--&lt;%&ndash;<span id="l_jobPosition"></span>&ndash;%&gt;--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="form-group row">--%>
                <%--<label>소속부서(학원)<b>*</b></label>--%>
                <%--<div><span id="sel_academy"></span></div>--%>
            <%--</div>--%>
            <%--<div class="form-group row">--%>
                <%--<label>소속팀<b>*</b></label>--%>
                <%--<div><span id="l_FlowEduTeam"></span></div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="form-outer-group">--%>
            <%--<div class="form-group row">--%>
                <%--<label>성범죄경력조회 확인일자<b>*</b></label>--%>
                <%--<div><input type="text" id="startSearchDate" class="form-control date-picker" style="width:200px;"></div>--%>
            <%--</div>--%>
            <%--<div class="form-group row hiddenDate2">--%>
                <%--<label>교육청 강사등록일자<b>*</b></label>--%>
                <%--<div><input type="text" id="startSearchDate2" class="form-control date-picker" style="width:200px;"></div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="bot_btns">--%>
            <%--<button class="btn_pack blue s2" type="button"  onclick="save_member();">저장</button>--%>
        <%--</div>--%>
    </form>
</section>
<div id="layer" style="display:none;border:5px solid;position:fixed;width:500px;height:500px;left:50%;margin-left:-250px;top:50%;margin-top:-250px;overflow:hidden">
    <img src="http://i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px" onclick="closeDaumPostcode()">
</div>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>
<script>
    $(".sidebar-menu > li").eq(5).addClass("active");
    $(".sidebar-menu > li:nth-child(6) > ul > li:nth-child(1) > a").addClass("on");
</script>
<!--
<h1>운영자/선생님정보 LIST</h1>
<div id="memberList">
<table class="table_list" border="1">
<colgroup>
<!-- <col width="2%" />
<col width="*" />
<col width="*" />
<col width="*" />
<col width="*" />
<col width="*" />
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
<th>직원선택</th>
<th>직원명</th>
<th>직원핸드폰번호</th>
<th>생년월일</th>
<th>주소</th>
<th>이메일</th>
<th>직책</th>
<th>소속부서</th>
<th>소속팀</th>
<th>성범죄경력조회 확인일자</th>
<th>교육청 강사등록일자</th>
<th>수정</th>
</tr>
</thead>
<tbody id="dataList"></tbody>
<tr>
<td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
</tr>
</table>-->

