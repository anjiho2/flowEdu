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


</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <div class="title-top">학습관리</div>
</div>
</section>
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
</form>

    <section class="content">
        <h3 class="title_t1">과제 관리</h3>
        <div class="tb_t1">
            <table>
                <tbody>
                    <tr>
                        <th>반</th>
                        <td>
                            <select class="form-control">
                                <option value="">반선택</option>
                                <option value="">1반</option>
                                <option value="">2반</option>
                            </select>
                        </td>
                        <th>사용여부</th>
                        <td>
                            <select class="form-control">
                                <option value="">전체</option>
                                <option value="">사용</option>
                                <option value="">사용하지않음</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>과제 등록일</th>
                        <td colspan="3">
                            <div class="form-group row marginX">
                                <div class="input-group date common" style="margin-right:10px;">
                                    <input type="text" id="startDate" class="form-control date-picker">
                                    <span class="input-group-addon">
                                        <span class="fa fa-calendar"></span>
                                    </span>
                                </div>
                                <div class="input-group date common" style="margin-right:10px;">
                                    <input type="text" id="endDate" class="form-control date-picker">
                                    <span class="input-group-addon">
                                        <span class="fa fa-calendar"></span>
                                    </span>
                                </div>
                                <div class="checkbox_t1 black">
                                    <label>
                                        <input type="radio" name="homework_date" value="" checked>
                                        <span>오늘</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="homework_date" value="">
                                        <span>7일</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="homework_date" value="">
                                        <span>30일</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="homework_date" value="">
                                        <span>60일</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="homework_date" value="">
                                        <span>90일</span>
                                    </label>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>등록 정보</th>
                        <td colspan="3">
                            <div class="form-group row marginX">
                                <select class="form-control" style="width: 13rem;margin-right:10px;">
                                    <option value="">이름</option>
                                    <option value="">학교</option>
                                    <option value="">학년</option>
                                </select>
                                <input type="text" class="form-control">
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <button class="btn_pack blue">검색</button>
        </div>

        <div class="tb_t1" style="margin-top: 2.5rem;">
            <table>
                <tbody>
                    <tr>
                        <th>No.</th>
                        <th>과제명</th>
                        <th>등록자</th>
                        <th>등록일</th>
                        <th>사용여부</th>
                    </tr>
                </tbody>
                <tbody>
                    <tr>
                        <td>3</td>
                        <td><a href="javascript:goPage('lecture', 'assignment_detail')" class="font_color blue">중3 선행수업 과제</a></td>
                        <td>현미경</td>
                        <td>2018-01-15</td>
                        <td>사용</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td><a href="javascript:goPage('lecture', 'assignment_detail')" class="font_color blue">2017-11-02 수학 보강 과제</a></td>
                        <td>오미자</td>
                        <td>2017-11-02</td>
                        <td>미사용</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td><a href="javascript:goPage('lecture', 'assignment_detail')" class="font_color blue">중간고사 문제풀이 과제</a></td>
                        <td>현상금</td>
                        <td>2017-09-25</td>
                        <td>사용</td>
                    </tr>
                </tbody>
            </table>
            <button class="btn_pack s2 blue" onclick="javascript:goPage('lecture', 'assignment_info')">등록</button>
        </div>
    </section>




<%@include file="/common/jsp/footer.jsp" %>
</body>
<script>
    $(".sidebar-menu > li").eq(2).addClass("active");
    $(".sidebar-menu > li:nth-child(3) > ul > li:nth-child(2) > a").addClass("on");
</script>
