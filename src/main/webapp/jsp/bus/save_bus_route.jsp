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
    <h4 class="title_t1"><span>강수원</span> 선생님의 노선 정보입니다.</h4>
    <form name="frm" method="get">
        <input type="hidden" name="member_id" id="member_id">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    </form>
    <div class="tb_t1">
        <table>
            <tr class="table_width">
                <th>노선명<b>*</b></th>
                <td colspan="2">
                    <div class="form-group row marginX">
                        <input type="text" class="form-control" placeholder="시점">&nbsp;
                        <input type="text" class="form-control" placeholder="종점">
                    </div>
                </td>
                <td></td>
            </tr>
            <tr>
                <th>구분<b>*</b></th>
                <td>
                    <select class="form-control">
                        <option>선택</option>
                        <option>학기중</option>
                        <option>방학중</option>
                        <option>기타</option>
                    </select>
                </td>
                <th>상태<b>*</b></th>
                <td>
                    <select class="form-control">
                        <option>선택</option>
                        <option>사용</option>
                        <option>사용하지않음</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>등원<b>*</b></th>
                <td colspan="3">
                    <table>
                        <thead>
                            <tr>
                                <th><input type="checkbox"></th>
                                <th style="width: 12rem;">정차위치</th>
                                <th>1T</th>
                                <th>2T</th>
                                <th>3T</th>
                                <th>4T</th>
                                <th>5T</th>
                                <th>6T</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="checkbox"></td>
                                <td><input type="text" class="form-control"></td>
                                <td><input type="text" class="form-control"></td>
                                <td><input type="text" class="form-control"></td>
                                <td><input type="text" class="form-control"></td>
                                <td><input type="text" class="form-control"></td>
                                <td><input type="text" class="form-control"></td>
                                <td>
                                    <div class="form-group row marginX draghandle">
                                        <input type="text" class="form-control">
                                        <span class="fa fa-bars"></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><input type="checkbox"></td>
                                <td><input type="text" class="form-control"></td>
                                <td><input type="text" class="form-control"></td>
                                <td><input type="text" class="form-control"></td>
                                <td><input type="text" class="form-control"></td>
                                <td><input type="text" class="form-control"></td>
                                <td><input type="text" class="form-control"></td>
                                <td>
                                    <div class="form-group row marginX draghandle">
                                        <input type="text" class="form-control">
                                        <span class="fa fa-bars"></span>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div>
                        <button class="btn_pack blue">삭제</button>
                        <button class="btn_pack blue float-right">추가</button>
                    </div>
                </td>
            </tr>
            <tr>
                <th>하원<b>*</b></th>
                <td colspan="3">
                    <table>
                        <thead>
                        <tr>
                            <th style="width: 12rem;">정차위치</th>
                            <th>1T</th>
                            <th>2T</th>
                            <th>3T</th>
                            <th>4T</th>
                            <th>5T</th>
                            <th>6T</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><input type="text" class="form-control"></td>
                            <td><input type="text" class="form-control"></td>
                            <td><input type="text" class="form-control"></td>
                            <td><input type="text" class="form-control"></td>
                            <td><input type="text" class="form-control"></td>
                            <td><input type="text" class="form-control"></td>
                            <td><input type="text" class="form-control"></td>
                        </tr>
                        </tbody>
                    </table>
                    <div>
                        <button class="btn_pack blue">삭제</button>
                        <button class="btn_pack blue float-right">추가</button>
                    </div>
                </td>
            </tr>
            <tr>
                <th>적용 기간<b>*</b></th>
                <td colspan="2">
                    <div class="form-group row marginX">
                        <div class="input-group date common">
                            <input type="text" id="endDate" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>&nbsp;
                        <div class="input-group date common">
                            <input type="text" id="educationRegDay" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </div>
                </td>
                <td></td>
            </tr>
            <tr>
                <th>메모</th>
                <td colspan="3">
                    <textarea rows="3" class="form-control"></textarea>
                </td>
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

