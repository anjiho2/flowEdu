<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int siderMenuDepth1 = 4;
    int siderMenuDepth2 = 2;
    int siderMenuDepth3 = 3;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
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
    <h3 class="title_t1">과제 등록</h3>
    <div class="tb_t1">
        <table>
            <tbody>
            <tr>
                <th>그룹 *</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
                <th>학원 *</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>강의명 *</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
                <th>과목 *</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>선생님1 *</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
                <th>선생님2 </th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>학교구분 *</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
                <th>학년구분 *</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>레벨</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
                <th>수강료 *</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>정원 *</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
                <th>강의상태 *</th>
                <td>
                    <select class="form-control" style="width: 20rem;">
                        <option value="">전체</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>시작일 *</th>
                <td>
                    <div class="input-group date common">
                        <input type="text" id="startDate" class="form-control date-picker">
                        <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                    </div>
                </td>
                <th>종료일 *</th>
                <td>
                    <div class="input-group date common">
                        <input type="text" id="startDate" class="form-control date-picker">
                        <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                    </div>
                </td>
            </tr>

            </tbody>
        </table>
        <button class="btn_pack blue s2" onclick="assignment_save();">저장</button>
        <button class="btn_pack blue s2" onclick="go_list();">목록</button>
    </div>
</section>
<%@include file="/common/jsp/footer.jsp" %>
</body>
</html>
