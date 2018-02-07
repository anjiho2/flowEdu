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
<body onload="init();">
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/bus_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <form name="frm" method="get">
        <input type="hidden" name="member_id" id="member_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    </form>

    <div class="tb_t1">
        <table>
            <tr>
                <th>소속<b>*</b></th>
                <td>
                    <select class="form-control">
                        <option>선택</option>
                        <option>플로우교육</option>
                        <option>수학의아침</option>
                        <option>사이언스카이</option>
                    </select>
                </td>
                <th>직책<b>*</b></th>
                <td>
                    <select class="form-control">
                        <option>선택</option>
                        <option>팀장</option>
                        <option>팀원</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>이름<b>*</b></th>
                <td><input type="text" class="form-control"></td>
                <th>핸드폰번호<b>*</b></th>
                <td>
                    <div class="form-group row marginX">
                        <input type="number" size="3" class="form-control" maxlength="3" max="999">&nbsp;-&nbsp;
                        <input type="number" size="4" class="form-control" maxlength="4" max="9999">&nbsp;-&nbsp;
                        <input type="number" size="4" class="form-control" maxlength="4" max="9999">
                    </div>
                </td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td>
                    <div class="input-group date common">
                        <input type="text" id="startDate" class="form-control date-picker">
                        <span class="input-group-addon">
                            <span class="fa fa-calendar"></span>
                        </span>
                    </div>
                </td>
                <th>등록일<b>*</b></th>
                <td>
                    <div class="form-group row marginX">
                        <div class="input-group date common">
                            <input type="text" id="sexualAssultDay" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                        <div>&nbsp;[<span></span>년차]</div>
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
                <th>차량번호<b>*</b></th>
                <td><input type="text" class="form-control"></td>
                <th>승차정원<b>*</b></th>
                <td><input type="text" class="form-control"></td>
            </tr>
            <tr>
                <th>안전필증<b>*</b></th>
                <td>
                    <div class="input-group date common">
                        <input type="text" id="endDate" class="form-control date-picker">
                        <span class="input-group-addon">
                            <span class="fa fa-calendar"></span>
                        </span>
                    </div>
                </td>
                <th>상태<b>*</b></th>
                <td>
                    <select class="form-control">
                        <option>선택</option>
                        <option>재직</option>
                        <option>퇴사</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>성범죄조회 확인일자<b>*</b></th>
                <td>
                    <div class="input-group date common">
                        <input type="text" id="educationRegDay" class="form-control date-picker">
                        <span class="input-group-addon">
                            <span class="fa fa-calendar"></span>
                        </span>
                    </div>
                </td>
                <td colspan="2"></td>
            </tr>
        </table>
        <button class="btn_pack s2 blue">저장</button>
        <button class="btn_pack s2 blue">목록</button>
    </div>

</section>
<%@include file="/common/jsp/footer.jsp" %>

<script>
    $(".sidebar-menu > li").eq(5).addClass("active");
    $(".sidebar-menu > li:nth-child(6) > ul > li:nth-child(2) > a").addClass("on");
</script>

</body>

