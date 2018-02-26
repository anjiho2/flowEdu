<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long member_id = Long.parseLong(request.getParameter("member_id"));
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
    function init() {
        getMemberinfo();//운영자정보가져오기
     /*   memberTypeSelectbox("sel_memberType", "");  //유형
        jobPositionSelectbox("sel_jobPosition", "");    //직책
        searchAcademySelectbox("sel_academy",""); //소속*/
    }

    function modify_save() { // 운영자.선생님정보 수정
        var check = new isCheck();

        var sel_memberType = getSelectboxValue("sel_memberType");
        if(sel_memberType == ''){
            alert(comment.input_member_type);
            return false;
        }
        var sel_jobPosition = getSelectboxValue("sel_jobPosition");
        if(sel_jobPosition == ''){
            alert(comment.input_member_posiotion);
            return false;
        }
        var sel_academy = getSelectboxValue("sel_academy");
        if(sel_academy == ''){
            alert(comment.input_member_academy);
            return false;
        }
        var member_name = getInputTextValue("member_name");
        if(member_name == ''){
            alert(comment.search_input_id_name);
            return false;
        }

        var member_phone1        = getInputTextValue("member_phone1");
        var member_phone2        = getInputTextValue("member_phone2");
        var member_phone3        = getInputTextValue("member_phone3");
        if(member_phone1 == '' || member_phone2 == '' || member_phone3 == ''){
            alert(comment.input_member_phone1);
            return false;
        }
        var zip_code             = getInputTextValue("zip_code");//우편번호
        var member_address       = getInputTextValue("member_address");//주소
        var member_address_detail  = getInputTextValue("member_address_detail");//상세주소
        if(member_address == ''){
            alert(comment.input_member_address);
            return false;

        }
        var member_email   = getInputTextValue("member_email");
        if(member_email){ //이메일 유효성 체크
            var is_email = fn_isemail(member_email);
            if (is_email == true) return false;
        }

        var member_teamName      = getInputTextValue("member_teamName");//소속팀
        var member_allphone      = member_phone1+member_phone2+member_phone3;//핸드폰번호
        var startDate            = getInputTextValue("startDate");//생년월일
        var member_email         = getInputTextValue("member_email");//이메일
        var sexualAssultDay      = getInputTextValue("sexualAssultDay");//성범죄경력조회확인일자
        var educationRegDay      = getInputTextValue("educationRegDay");//교육청강사등록일자
        var status               = getSelectboxValue("status");
        var member_id            = getInputTextValue("member_id");
        var statusYn;
        if(status == 1) statusYn = true;
        else statusYn = false;
        gfn_display("loadingbar", true);
        alert(sel_academy);
        //수정
        if(confirm(comment.isUpdate)) {
            memberService.modifyFlowEduMember(member_id, sel_academy, member_teamName, sel_jobPosition, member_allphone, member_phone3, member_name, startDate, member_address,
                member_email, sexualAssultDay, educationRegDay, sel_memberType, member_address_detail, zip_code, statusYn, function () {
                    gfn_display("loadingbar", false);
                    goPage("member", "list_member");
                });
        }
    }

    function getMemberinfo() { // 운영자정보가져오기
        var member_id = <%=member_id%>;
        memberService.getFlowEduMember(member_id,function (selList) {
            for(var i= 0; i < selList.length; i++){
                console.log(selList);
                var cmpList = selList[i];
                if(cmpList != undefined){
                    memberTypeSelectbox("sel_memberType", cmpList.memberType);//유형
                    jobPositionSelectbox("sel_jobPosition", cmpList.jobPositionId);//직책
                    //searchAcademySelectbox("sel_academy", cmpList.officeId);//소속
                    academyModifySelectbox("l_academy", cmpList.officeId);
                    innerValue("member_teamName", cmpList.teamName);
                    innerValue("member_name",cmpList.memberName);
                    fnSetPhoneNo("member_phone1", "member_phone2", "member_phone3", cmpList.phoneNumber);
                    innerValue("member_email", cmpList.memberEmail);
                    innerValue("startDate",cmpList.memberBirthday);
                    innerValue("member_address", cmpList.memberAddress);
                    innerValue("zip_code",cmpList.zipCode);
                    innerValue("member_address_detail",cmpList.memberAddressDetail);
                    innerValue("sexualAssultDay",cmpList.sexualAssultConfirmDate);
                    innerValue("educationRegDay",cmpList.educationRegDate);
                }
            }
        });
    }

    var isChange = false;
    $(document).ready(function () {
        $("input, select, textarea").change(function () {
            isChange = true;
        });
    });

    function go_list() {
        if(isChange) {
            if (confirm(comment.is_change_confirm)) {
                goPage("member","list_member");
            }
        } else {
            goPage("member","list_member");
        }
    }

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
        <input type="hidden" name="member_id" id="member_id" value="<%=member_id%>">
        <input type="hidden" name="page_gbn" id="page_gbn">
    </form>
    <div class="tb_t1">
        <table>
            <tr>
                <th>유형<b>*</b></th>
                <td>
                    <select id="sel_memberType" class="form-control">
                        <option value="">선택</option>
                    </select>
                </td>
                <th>직책<b>*</b></th>
                <td>
                    <select id="sel_jobPosition" class="form-control">
                        <option value="">선택</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>소속<b>*</b></th>
                <td>
                    <span id="l_academy"></span>
                    <%--<select id="sel_academy" class="form-control">--%>
                        <%--<option value="">선택</option>--%>
                    <%--</select>--%>
                </td>
                <th>소속팀</th>
                <td><input type="text" class="form-control" id="member_teamName"></td>
            </tr>
            <tr>
                <th>이름<b>*</b></th>
                <td><input type="text" class="form-control" id="member_name"></td>
                <th>핸드폰번호<b>*</b></th>
                <td>
                    <div class="form-group row marginX">
                        <div class="inputs">
                            <input type="number" size="3" class="form-control" maxlength="3" max="999" id="member_phone1">&nbsp;-&nbsp;
                            <input type="number" size="4" class="form-control" maxlength="4" max="9999" id="member_phone2">&nbsp;-&nbsp;
                            <input type="number" size="4" class="form-control" maxlength="4" max="9999" id="member_phone3">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><input type="text" class="form-control" id="member_email"></td>
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
                        <input type="text" id="zip_code" class="form-control" style="width: 10rem;" placeholder="우편번호" onclick="openDaumPostcode();">&nbsp;
                        <button class="btn_pack" onclick="openDaumPostcode();">우편번호 검색</button>
                    </div>
                    <div class="form-group row marginX">
                        <input type="text" id="member_address" class="form-control">
                        <input type="text" id="member_address_detail" class="form-control">
                    </div>
                </td>
            </tr>
            <tr>
                <th>성범죄조회 확인일</th>
                <td>
                    <div class="input-group date common">
                        <input type="text" id="sexualAssultDay" class="form-control date-picker">
                        <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                    </div>
                </td>
                <th>교육청 강사등록일</th>
                <td>
                    <div class="input-group date common">
                        <input type="text" id="educationRegDay" class="form-control date-picker">
                        <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th>상태</th>
                <td>
                    <select class="form-control" id="status">
                        <option value="1">재직</option>
                        <option value="0">퇴사</option>
                    </select>
                </td>
                <td colspan="2"></td>
            </tr>
        </table>
        <button class="btn_pack s2 blue" onclick="modify_save();">수정</button>
        <button class="btn_pack s2 blue" onclick="go_list();">목록</button>
    </div>
</section>
<div id="layer" style="display:none;border:5px solid;position:fixed;width:500px;height:500px;left:50%;margin-left:-250px;top:50%;margin-top:-250px;overflow:hidden;z-index: 999">
    <img src="http://i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="closeDaumPostcode()">
</div>
<%@include file="/common/jsp/footer.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
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
                document.getElementById("zip_code").value = (data.postcode1 + data.postcode2);
                //document.getElementById("zip2").value = data.postcode2;
                document.getElementById("member_address").value = data.address;
                document.getElementById("member_address_detail").focus();
                // iframe을 넣은 element를 안보이게 한다.
                element.style.display = 'none';
                //$("#layer").css('display', 'none');
            },
            width : '100%',
            height : '100%'
        }).embed(element);
        // iframe을 넣은 element를 보이게 한다.
        element.style.display = 'block';
    }

    $(".sidebar-menu > li").eq(5).addClass("active");
    $(".sidebar-menu > li:nth-child(6) > ul > li:nth-child(1) > a").addClass("on");
</script>
</body>

