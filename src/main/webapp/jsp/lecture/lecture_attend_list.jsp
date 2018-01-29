<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">

    function init() {
        myClassSelectbox("sel_myClass");
    }

</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
</div>
</section>
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
</form>

    <section class="content">
        <h3 class="title_t1">출결 관리</h3>
        <div class="form-outer-group">
            <div class="form-group row">
                <select id="sel_myClass" class="form-control">
                    <option value="">▶강의선택</option>
                </select>
                <%--<select class="form-control">--%>
                    <%--<option value="">중급 1반</option>--%>
                    <%--<option value="">중급 2반</option>--%>
                    <%--<option value="">중급 3반</option>--%>
                <%--</select>--%>
            </div>
            <div class="form-group row">
                <input type="text" class="form-control" placeholder="학생 이름을 입력하세요.">
            </div>
            <div class="form-group row">
                <div class="input-group date common">
                    <input type="text" id="endDate" class="form-control date-picker" placeholder="2018-01-22">
                <div class="input-group date" style="width:250px">
                    <input type="text" id="endDate" class="form-control date-picker" placeholder="검색일">
                    <span class="input-group-addon" id="datepicker_img2">
                    <span class="fa fa-calendar"></span>
                </span>
                </div>
            </div>
            <div class="form-group row">
                <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
            </div>
        </div>

        <div class="tb_t1 attend_tb1">
            <table>
                <tbody>
                    <tr style="text-align: center;">
                        <td colspan="6">
                            [전체 : <span>5</span>]&nbsp;
                            [등원 : <span>0</span>]&nbsp;
                            [지각 : <span>0</span>]&nbsp;
                            [조퇴 : <span>0</span>]&nbsp;
                            [결석 : <span>0</span>]
                        </td>
                    </tr>
                </tbody>
                <tbody>
                    <tr>
                        <th><input type="checkbox" class="form-control" name="" value=""></th>
                        <th>No.</th>
                        <th>이름</th>
                        <th>등원시간</th>
                        <th>하원시간</th>
                        <th>메모</th>
                    </tr>
                </tbody>
                <tbody>
                    <tr>
                        <td><input type="checkbox" class="form-control" name="" value=""></td>
                        <td>5</td>
                        <td>이성우</td>
                        <td><input type="text" class="form-control"></td>
                        <td><input type="text" class="form-control"></td>
                        <td><input type="text" class="form-control"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="form-control" name="" value=""></td>
                        <td>4</td>
                        <td>김남호</td>
                        <td><input type="text" class="form-control"></td>
                        <td><input type="text" class="form-control"></td>
                        <td><input type="text" class="form-control"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="form-control" name="" value=""></td>
                        <td>3</td>
                        <td>박성결</td>
                        <td><input type="text" class="form-control"></td>
                        <td><input type="text" class="form-control"></td>
                        <td><input type="text" class="form-control"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="form-control" name="" value=""></td>
                        <td>2</td>
                        <td>이기훈</td>
                        <td><input type="text" class="form-control"></td>
                        <td><input type="text" class="form-control"></td>
                        <td><input type="text" class="form-control"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="form-control" name="" value=""></td>
                        <td>1</td>
                        <td>엄소라</td>
                        <td><input type="text" class="form-control"></td>
                        <td><input type="text" class="form-control"></td>
                        <td><input type="text" class="form-control"></td>
                    </tr>
                </tbody>
            </table>
            <button class="btn_pack blue s2">저장</button>
            <div style="float: right; margin-top:5px;">
                <button class="btn_pack black">등원</button>
                <button class="btn_pack black">지각</button>
                <button class="btn_pack black">조퇴</button>
                <button class="btn_pack black">결석</button>
                <button class="btn_pack black">보강</button>
                <button class="btn_pack black">하원</button>
            </div>
        </div>
    </section><!--content-->



<%@include file="/common/jsp/footer.jsp" %>
</body>
<script>
    $(".sidebar-menu > li").eq(2).addClass("active");
    $(".sidebar-menu > li:nth-child(3) > ul > li:nth-child(1) > a").addClass("on");
</script>
