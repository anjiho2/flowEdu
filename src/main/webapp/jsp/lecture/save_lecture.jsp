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
        if(val == undefined) {
            val = "ELEMENT";
            schoolTypeSelectbox("l_schoolType", val);
            schoolSelectbox("student_grade", "", val);
            searchAcademySelectbox("sel_academy",""); //소속
            academyGroupSelectbox("sel_group", "");//그룹
            lectureStatusSelectbox("sel_lectureState", "WAIT");
            lectureSubjectSelectbox("sel_lectureSubject", "");
            lectureLevelSelectbox("sel_lectureLevel", "");//레벨
            lecturePriceSelectbox("sel_lecturePrice", "");
            classLimitNumberSelectbox("sel_classLimit", "");
        }else{
            schoolTypeSelectbox("l_schoolType", val);
            schoolSelectbox("student_grade", "", val);
        }
    }


    function lecture_save() {
        var check = new isCheck();

        var academy_group =  getSelectboxValue("sel_group", "");//그룹
        var academy    =  getSelectboxValue("sel_academy", "");//학원
        var lecture_name    =  getInputTextValue("lecture_name", "");//강의명
        var subject    =  getSelectboxValue("sel_lectureSubject", "");//과목
        var teacher1   = getInputTextValue("teacher1");
        var teacher2   = getInputTextValue("teacher2");
        var schoolType = convert_school_value(getSelectboxValue("sel_schoolType", ""));//학교구분
        var schoolNum  =  getSelectboxValue("sel_school", "");//학년구분
        var level = getSelectboxValue("sel_lectureLevel", ""); //레벨
        var lecturePrice = getSelectboxValue("sel_lecturePrice", "");//수강료
        var classLimit   = getSelectboxValue("sel_classLimit", "");//정원
        var lectureState = getSelectboxValue("sel_lectureState", "");//강의상태
        var startDate = getInputTextValue("startDate", "");//시작일
        var endDate   = getInputTextValue("endDate", "");//종료일

        if(check.selectbox("sel_memberType", comment.input_academy_group)   == false) return;
        if(check.selectbox("sel_academy", comment.input_academy_name)   == false) return;
        if(check.input("lecture_name", comment.input_lecture_class)   == false) return;
        if(check.selectbox("sel_lectureSubject", comment.input_lecture_subject)   == false) return;
        if(check.input("teacher1", comment.input_teacher_name)   == false) return;
        if(check.selectbox("sel_schoolType", comment.input_schoolType)   == false) return;
        if(check.selectbox("sel_school", comment.input_school)   == false) return;
        if(check.selectbox("sel_lecturePrice", comment.input_lecture_price)   == false) return;
        if(check.selectbox("sel_classLimit", comment.input_class_limit)   == false) return;
        if(check.selectbox("sel_lectureState", comment.select_status)   == false) return;
        if(check.input("startDate", comment.input_lecture_start_time)   == false) return;
        if(check.input("endDate", comment.input_lecture_end_time)   == false) return;


        var data = {
            academyGroupId: academy_group,//그룹
            officeId: academy,//학원
            lectureName: lecture_name,//강의명
            lectureSubject:subject,//과목
            manageMemberId : "1",         //선생님1
            chargeMemberId : "2",              //선생님2
            schoolType: schoolType,//학교구분
            lectureGrade: schoolNum,//학년구분
            lectureLevel: level,//레벨
            lecturePriceId : lecturePrice,//수강료
            lectureLimitStudent: classLimit,//정원
            lectureStatus: lectureState,//강의상태
            lectureStartDate : startDate,
            lectureEndDate : endDate,
            lectureOperationType : "MONTH",
        };
        console.log(data);
        //lectureEndDate,academyGroupId,lectureStartDate
        lectureService.saveLectureInfo(data, function () {
            alert("저장");
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
                goPage('lecture', 'lecture_list');
            }
        } else {
            goPage('lecture', 'lecture_list');
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
                        <select id="sel_group" class="form-control" style="width: 20rem;">
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
                        <input type="text" class="form-control" id="lecture_name" placeholder="강의명을 입력하세요.">
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
                        <input type="text" class="form-control" id="teacher1" placeholder="선생님1 이름을 입력하세요.">
                    </td>
                    <th>선생님2 </th>
                    <td>
                        <input type="text" class="form-control" id="teacher2" placeholder="선생님2 이름을 입력하세요.">
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
                        <select id="sel_lecturePrice" class="form-control" style="width: 20rem;">
                            <option value="">전체</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>정원<b>*</b></th>
                    <td>
                        <select id="sel_classLimit" class="form-control" style="width: 20rem;">
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
                            <input type="text" id="startDate" class="form-control date-picker" placeholder="시작일">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </td>
                    <th>종료일<b>*</b></th>
                    <td>
                        <div class="input-group date common">
                            <input type="text" id="endDate" class="form-control date-picker" placeholder="종료일">
                            <span class="input-group-addon">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        <button class="btn_pack blue s2" onclick="lecture_save();">저장</button>
        <button class="btn_pack blue s2" onclick="go_list();">목록</button>
    </div>
</section>
<%@include file="/common/jsp/footer.jsp" %>
</body>
</html>
