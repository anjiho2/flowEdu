<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sch_type = Util.isNullValue(request.getParameter("school_type"),"");
    String school_name = "";
    if (sch_type.equals("elem_list")) {
        school_name = "초등학교";
    } else if (sch_type.equals("midd_list")) {
        school_name = "중학교";
    } else {
        school_name = "고등학교";
    }
%>

<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script>
    function school_name_html() { //부모창에 input값넣기
        var school_name = getInnerHtmlValue("a_school_name");
        document.getElementById("schoolname").value = school_name;
        self.close();
    }

    function school_search() {//학교검색
        var region =  getSelectboxValue("inputregion");
        var searchSchoolName = getInputTextValue("schoo_name");
       if(region==""){
           alert("지역을 선택해 주세요.");
           return false;
       }else if(searchSchoolName == ""){
           alert("학교명을 입력해 주세요.");
           return false;
       }
        studentService.getApiSchoolName('<%=sch_type%>', region, searchSchoolName, function (schoolName) {
            gfn_display("search_result_div", true);
            if(schoolName == null){
                alert("학교검색없음");
                return;
            }
            innerHTML("a_school_name", schoolName ? remove_double_quotation(schoolName) : "학교검색없음");
        });
    }

    $("#popup2").on('click', function(){
        initPopup($("#test_layer2"), {
            onStart : function(t){alert('시작')}, //팝업 시작할때 실행되는 함수, 인자는 layer엘리먼트
            onClose : function(t){alert('닫힘 완료')}, //팝업 닫히고 나서 실행되는 팝업, 인자는 layer엘리먼트

        });
    });

</script>

<body>
<div class="layer_popup_template apt_request_layer" id="test_layer2" style="display: none;">
    <div class="layer-title">
        <h3>학교검색</h3>
        <button class="fa fa-close btn-close"></button>
    </div>
    <form name="frm" method="get">
    <div class="layer-body">
        <div class="cont">
            <form class="form_st1" name="frm" method="get">
                <div class="form-group row">
                    <label>학교구분</label> [ <span><%=school_name%></span> ]
                </div>
                <div class="form-group row">
                    <label>지역</label>
                    <select title="선택" name="inputregion" id="inputregion" class="form-control" style="width: 120px;">
                        <option value="">전체</option>
                        <option value="100260">서울특별시</option>
                        <option value="100267">부산광역시</option>
                        <option value="100269">인천광역시</option>
                        <option value="100272">대구광역시</option>
                        <option value="100275">광주광역시</option>
                        <option value="100271">대전광역시</option>
                        <option value="100273">울산광역시</option>
                        <option value="100704">세종특별자치시</option>
                        <option value="100276" selected>경기도</option>
                        <option value="100278">강원도</option>
                        <option value="100281">충청남도</option>
                        <option value="100280">충청북도</option>
                        <option value="100285">경상북도</option>
                        <option value="100291">경상남도</option>
                        <option value="100282">전라북도</option>
                        <option value="100283">전라남도</option>
                        <option value="100292">제주특별자치도</option>
                        <option value="100771">해외거주</option>
                    </select>
                </div>
                <div class="form-group row">
                    <label>학교이름</label>
                    <div><input type="text" id="schoo_name" class="form-control" style="width: 140px;" onkeypress="javascript:if(event.keyCode == 13){school_search(); return false;}"></div>
                </div>
                <div class="form-group row" style="display: none;" id="search_result_div">
                    <label>검색결과</label>
                    <a href="javascript:void(0);" onclick="school_name_html();" id="a_school_name"></a>
                </div>

                <!--
                <div class="form-group"><div><input type="text" class="form-control" id="" placeholder="이름"></div></div>
                <div class="form-group"><div><input type="email" class="form-control" id="" placeholder="이메일"></div></div>
                <div class="form-group"><div><input type="email" class="form-control" id="" placeholder="이메일"></div></div>
                <div class="form-group"><div><input type="email" class="form-control" id="" placeholder="이메일"></div></div>
                <div class="form-group"><div><input type="email" class="form-control" id="" placeholder="이메일"></div></div>
                <div class="form-group"><div><input type="email" class="form-control" id="" placeholder="이메일"></div></div>
                <div class="form-group"><div><input type="email" class="form-control" id="" placeholder="이메일"></div></div>
                -->
            </form>
        </div>
        <div class="bot_btns_t1">
            <button class="btn_pack btn-close" type="button"  onclick="">취소</button>
            <button class="btn_pack blue" type="button" onclick="school_search();">검색</button>
        </div>
    </div>
</div>


<%--<div class="container">--%>
    <%--&lt;%&ndash;<%@include file="/common/jsp/depth_menu.jsp" %>&ndash;%&gt;--%>
<%--</div>--%>
<%--</section>--%>
<%--<section class="content">--%>
    <%--<h3 class="title_t1">학교 검색</h3>--%>
    <%--<form name="frm" method="get">--%>
        <%--<div class="form-group row">--%>
            <%--<label>학교구분</label>--%>
            <%--<div> [ <span id="l_school_name"></span> ]</div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>지역</label>--%>
            <%--<div>--%>
                <%--<select title="선택" name="inputregion" id="inputregion" class="form-control" style="width: 120px;">--%>
                    <%--<option value="">전체</option>--%>
                    <%--<option value="100260">서울특별시</option>--%>
                    <%--<option value="100267">부산광역시</option>--%>
                    <%--<option value="100269">인천광역시</option>--%>
                    <%--<option value="100272">대구광역시</option>--%>
                    <%--<option value="100275">광주광역시</option>--%>
                    <%--<option value="100271">대전광역시</option>--%>
                    <%--<option value="100273">울산광역시</option>--%>
                    <%--<option value="100704">세종특별자치시</option>--%>
                    <%--<option value="100276" selected>경기도</option>--%>
                    <%--<option value="100278">강원도</option>--%>
                    <%--<option value="100281">충청남도</option>--%>
                    <%--<option value="100280">충청북도</option>--%>
                    <%--<option value="100285">경상북도</option>--%>
                    <%--<option value="100291">경상남도</option>--%>
                    <%--<option value="100282">전라북도</option>--%>
                    <%--<option value="100283">전라남도</option>--%>
                    <%--<option value="100292">제주특별자치도</option>--%>
                    <%--<option value="100771">해외거주</option>--%>
                <%--</select>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>학교이름</label>--%>
            <%--<div><input type="text" id="schoo_name" class="form-control" style="width: 140px;" onkeypress="javascript:if(event.keyCode == 13){school_search(); return false;}"></div>--%>
        <%--</div>--%>
        <%--<div class="bot_btns">--%>
            <%--<button class="btn_pack blue s2" type="button"  onclick="school_search();">검색</button>--%>
        <%--</div>--%>
        <%--<div class="form-group row"></div>--%>
        <%--<div class="form-group row">--%>
            <%--<label>검색결과</label>--%>
            <%--<a href="javascript:void(0);" onclick="school_name_html();" id="a_school_name"></a>--%>
        <%--</div>--%>
    <%--</form>--%>
<%--</section>--%>
<%--</div>--%>
<%--<%@include file="/common/jsp/footer.jsp" %>--%>
<%--</body>--%>