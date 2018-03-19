<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int siderMenuDepth1 = 5;
    int siderMenuDepth2 = 6;
    int siderMenuDepth3 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/academyService.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
    function init() {
        memberTypeSelectbox("sel_memberType", "");  //유형
        jobPositionSelectbox("sel_jobPosition", "");    //직책
        searchAcademySelectbox("sel_academy",""); //소속
    }

    function save_member() { // 운영자.선생님정보등록
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
        gfn_display("loadingbar", true);

        memberService.isMember(member_allphone, function (bl) {
            if(bl==true){
                gfn_display("loadingbar", false);
                alert("이미 가입된 전화번호가 있습니다.");
                return false;
            }else{
                //저장
                if(confirm(comment.isSave)){
                memberService.saveFlowEduMember(sel_academy, member_teamName, sel_jobPosition, member_allphone, member_phone3, member_name, startDate, member_address,
                                                member_email, sexualAssultDay, educationRegDay, sel_memberType, member_address_detail, zip_code,function () {
                        gfn_display("loadingbar", false);
                        goPage("member","list_member");
                    });
                }
            }
        });
    }

    function go_list() {
        if(isChange) {
            if (confirm(comment.is_change_confirm)) {
                goPage("member","list_member");
            }
        } else {
            goPage("member","list_member");
        }
    }

    var isChange = false;
    $(document).ready(function () {
        $("input, select, textarea").change(function () {
            isChange = true;
        });

        /*우편번호 레이아웃 숨기기*/
        $(document).mousedown(function(e){
            $('#layer').each(function(){
                if( $(this).css('display') == 'block' ){
                    var l_position = $(this).offset();
                    l_position.right = parseInt(l_position.left) + ($(this).width());
                    l_position.bottom = parseInt(l_position.top) + parseInt($(this).height());
                    if( ( l_position.left <= e.pageX && e.pageX <= l_position.right )
                        && ( l_position.top <= e.pageY && e.pageY <= l_position.bottom ) ){
                        //alert( 'popup in click' );
                    }
                    else{
                        //alert( 'popup out click' );
                        $(this).hide("fast");
                    }
                }
            });
        });
        /*우편번호 레이아웃 숨기기*/
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
                        <select id="sel_academy" class="form-control">
                            <option value="">선택</option>
                        </select>
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
                            <input type="number" size="3" class="form-control" maxlength="3" max="999" id="member_phone1" onkeyup="js_tab_order(this,'member_phone2',3)">&nbsp;-&nbsp;
                            <input type="number" size="4" class="form-control" maxlength="4" max="9999" id="member_phone2" onkeyup="js_tab_order(this,'member_phone3',4)">&nbsp;-&nbsp;
                            <input type="number" size="4" class="form-control" maxlength="4" max="9999" id="member_phone3" onkeyup="js_tab_order(this,'member_email',4)">
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
                        <select class="form-control">
                            <option>재직</option>
                            <option>퇴사</option>
                        </select>
                    </td>
                    <td colspan="2"></td>
                </tr>
            </table>
            <button class="btn_pack s2 blue" onclick="save_member();">저장</button>
            <button class="btn_pack s2 blue" onclick="go_list();">목록</button>
        </div>
</section>
<div id="layer" style="display:none;border:1px solid;position:fixed;width:500px;height:500px;left:50%;margin-left:-250px;top:50%;margin-top:-250px;overflow:hidden;z-index: 999">
    <img src="http://i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1;display:none;" onclick="closeDaumPostcode()">
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
</script>
</body>

