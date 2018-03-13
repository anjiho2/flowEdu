<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int siderMenuDepth1 = 4;
    int siderMenuDepth2 = 3;
    int siderMenuDepth3 = 3;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script type="text/javascript">
    function init(val) {
        myClassSelectbox("sel_myClass");
        schoolTypeSelectbox("l_schoolType", val);
        schoolSelectbox("student_grade","", val);
        searchAcademySelectbox("sel_academy",""); //소속
        academyGroupSelectbox("sel_memberType", "");//그룹
        lectureStatusSelectbox("sel_lectureState", "");
        lectureSubjectSelectbox("sel_lectureSubject", "");
        lectureLevelSelectbox("sel_lectureLevel", "");//레벨
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
                goPage('lecture', 'lecture_list')
            }
        } else {
            goPage('lecture', 'lecture_list')
        }
    }
</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <div class="title-top">강의관리</div>
</div>
</section>
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
</form>
<section class="content">
    <h3 class="title_t1">강의정보등록</h3>
        <div class="tb_t1">
            <table>
                <tbody>
                <tr>
                    <th>그룹<b>*</b></th>
                    <td>
                        <select id="sel_memberType" class="form-control" style="width: 20rem;">
                            <option value="">전체</option>
                        </select>
                    </td>
                    <th>학원<b>*</b></th>
                    <td>
                        <select id="sel_academy" class="form-control">
                            <option value="">전체</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>강의명<b>*</b></th>
                    <td>
                        <div class="form-group row">
                            <select id="sel_myClass" class="form-control">
                                <option value="">▶강의선택</option>
                            </select>
                        </div>
                    </td>
                    <th>과목<b>*</b></th>
                    <td>
                        <select id="sel_lectureSubject" class="form-control" style="width: 20rem;">
                            <option value="">▶과목선택</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>선생님1<b>*</b></th>
                    <td>
                        <select class="form-control" style="width: 20rem;">
                            <option value="">전체</option>
                        </select>
                    </td>
                    <th>선생님2 </th>
                    <td>
                        <input type="text" class="form-control" placeholder="선생님 이름을 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <th>학교구분<b>*</b></th>
                    <td>
                        <span id="l_schoolType"></span>
                    </td>
                    <th>학년구분<b>*</b></th>
                    <td>
                        <span id="student_grade"></span>
                    </td>
                </tr>
                <tr>
                    <th>레벨</th>
                    <td>
                        <select id="sel_lectureLevel" class="form-control" style="width: 20rem;">
                            <option value="">구분없음</option>
                        </select>
                    </td>
                    <th>수강료<b>*</b></th>
                    <td>
                        <select class="form-control" style="width: 20rem;">
                            <option value="">전체</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>정원<b>*</b></th>
                    <td>
                        <select class="form-control" style="width: 20rem;">
                            <option value="">전체</option>
                        </select>
                    </td>
                    <th>강의상태<b>*</b></th>
                    <td>
                        <select id="sel_lectureState" class="form-control" style="width: 20rem;">
                            <option value="">전체</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>시작일<b>*</b></th>
                    <td>
                        <div class="input-group date common">
                            <input type="text" id="startDate" class="form-control date-picker">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </td>
                    <th>종료일<b>*</b></th>
                    <td>
                        <div class="input-group date common">
                            <input type="text" id="sexualAssultDay" class="form-control date-picker">
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
