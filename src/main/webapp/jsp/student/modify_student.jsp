<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    FlowEduMemberDto flowEduMemberDto = (FlowEduMemberDto)session.getAttribute("member_info");
    Long memberId = flowEduMemberDto.getFlowMemberId();
%>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script>
    function init() {
        schoolSelectbox("student_grade","", "");
        studentMemoTypeRadio("l_memoType", "REG", "");
        studentList();
        //fn_search("new");
        student_memo_list();
    }

    function studentList() {
        var student_id        = getInputTextValue("student_id");
        studentService.getStudentInfo(student_id, function (selList) {
                    var file_url = 'C:/dev/download/'+selList.studentPhotoUrl+"/"+selList.studentPhotoFile;
                    $("#modify_preView").attr("src", file_url);
                    if(file_url != null) {
                        gfn_display("preview", true);
                    }

                    innerValue("student_name", selList.studentName);
                    innerValue("startDate", selList.studentBirthday);
                    $('input:radio[name=student_gender]:input[value=' + selList.studentGender + ']').attr("checked", true);
                    $('input:radio[name=school_type]:input[value=' + selList.schoolType + ']').attr("checked", true);
                    innerValue("sel_school", selList.studentGrade);
                    fnSetPhoneNo(student_phone1, student_phone2, student_phone3, selList.studentPhoneNumber);
                    fnSetPhoneNo(student_tel1,   student_tel2,   student_tel3,   selList.homeTelNumber);
                    fnSetPhoneNo(mother_phone1,  mother_phone2,  mother_phone3,  selList.motherPhoneNumber);
                    fnSetPhoneNo(father_phone1,  father_phone2,  father_phone3,  selList.fatherPhoneNumber);
                    innerValue("student_email", selList.studentEmail);
                    innerValue("student_grade", selList.memberAddress);
                    innerValue("schoolname", selList.schoolName);
                    innerValue("student_memo", selList.studentMemo);
                    innerValue("mother_name", selList.motherName);
                    innerValue("father_name", selList.fatherName);
        });
    }

    //수정
    function modify_student() {
        var check = new isCheck();
        var student_id   = getInputTextValue("student_id");
        var data = new FormData();

      /*  if(check.input("student_name", comment.input_member_name)   == false) return;
        if($(":input:radio[name=student_name]:checked").val()==null) return;
        if(check.input("startDate", comment.input_member_startDate)   == false) return;
        if(check.input("student_grade", comment.input_student_grade)   == false) return;
        if(check.input("mother_name", comment.input_mother_name)   == false) return;
        if(check.input("mother_phone1", comment.input_mother_tel1)   == false) return;
        if(check.input("mother_phone2", comment.input_mother_tel2)   == false) return;
        if(check.input("mother_phone3", comment.input_mother_tel3)   == false) return;*/

        $.each($('#attachFile')[0].files, function(i, file) {
            data.append('file-' + i, file);
        });
        var attachFile = fn_clearFilePath($('#attachFile').val());
        if (attachFile != "") { //학생사진 업로드시
            $.ajax({
                url: "<%=webRoot%>/file/upload.do",
                method : "post",
                dataType: "JSON",
                data: data,
                cache: false,
                processData: false,
                contentType: false,
                success: function(data) {
                    var fileName = data.result.file_name;
                    var fileUrl = data.result.file_url;

                    var mother_phone3   = getInputTextValue("mother_phone3");
                    var student_name    = getInputTextValue("student_name");
                    var gender          = get_radio_value("student_gender");
                    var startDate       = getInputTextValue("startDate");
                    var student_phonenum = get_allphonenum("student_phone1","student_phone2","student_phone3");
                    var student_telnum  = get_allphonenum("student_tel1","student_tel2","student_tel3");
                    var student_email   = getInputTextValue("student_email");
                    var student_grade   = getInputTextValue("sel_school");
                    var schoolname      = getInputTextValue("schoolname");
                    var student_memo    = getInputTextValue("student_memo");
                    var mother_name     = getInputTextValue("mother_name");
                    var father_name     = getInputTextValue("father_name");
                    var mother_phonenum = get_allphonenum("mother_phone1","mother_phone2","mother_phone3");
                    var father_phonenum = get_allphonenum("father_phone1","father_phone2","father_phone3");
                    var school_type =  $(":input:radio[name=school_type]:checked").val();

                    var data = {
                        studentId:student_id,
                        studentPhotoFile:fileName, //파일명
                        studentPhotoUrl:fileUrl, //경로
                        studentName:student_name,
                        studentPassword:mother_phone3,
                        studentGender:gender,
                        studentBirthday:startDate,
                        studentPhoneNumber:student_phonenum,
                        homeTelNumber:student_telnum,
                        studentEmail:student_email,
                        studentGrade:student_grade,
                        schoolType:school_type,
                        schoolName:schoolname,
                        studentMemo:student_memo,
                        motherName:mother_name,
                        motherPhoneNumber:mother_phonenum,
                        fatherName:father_name,
                        fatherPhoneNumber:father_phonenum,
                    };
                    studentService.modifyStudentInfo(data,function () {
                        alert("학생정보가 수정 되었습니다.");
                        location.reload();
                    });
                }
            });
        } else { //학생사진 없을때
            var mother_phone3    = getInputTextValue("mother_phone3");
            var student_name    = getInputTextValue("student_name");
            var gender          = get_radio_value("student_gender");
            var startDate       = getInputTextValue("startDate");
            var student_phonenum= get_allphonenum("student_phone1","student_phone2","student_phone3");
            var student_telnum  = get_allphonenum("student_tel1","student_tel2","student_tel3");
            var student_email   = getInputTextValue("student_email");
            var student_grade   = getInputTextValue("sel_school");
            var schoolname      = getInputTextValue("schoolname");
            var student_memo    = getInputTextValue("student_memo");
            var mother_name     = getInputTextValue("mother_name");
            var father_name     = getInputTextValue("father_name");
            var mother_phonenum = get_allphonenum("mother_phone1","mother_phone2","mother_phone3");
            var father_phonenum = get_allphonenum("father_phone1","father_phone2","father_phone3");
            var school_type =  $(":input:radio[name=school_type]:checked").val();

            var data = {
                studentPhotoFile:"", //파일명
                studentPhotoUrl:"", //경로
                studentId:student_id,
                studentName:student_name,
                studentPassword:mother_phone3,
                studentGender:gender,
                studentBirthday:startDate,
                studentPhoneNumber:student_phonenum,
                homeTelNumber:student_telnum,
                studentEmail:student_email,
                studentGrade:student_grade,
                schoolType:school_type,
                schoolName:schoolname,
                studentMemo:student_memo,
                motherName:mother_name,
                motherPhoneNumber:mother_phonenum,
                fatherName:father_name,
                fatherPhoneNumber:father_phonenum,
            };
            studentService.modifyStudentInfo(data,function () {
                alert("학생정보가 수정 되었습니다.");
                location.reload();
            });
        }
    }

    function studentMemo() {//상담저장
        var student_id  = getInputTextValue("student_id");
        var consultMemo = getInputTextValue("consultMemo");
        var memoType = get_radio_value("memo_type");
        studentService.saveStudentMemo(student_id, consultMemo, memoType, function () {
            alert("상담저장완료");
            location.reload();
        });
    }
    /*
    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        var student_id = getInputTextValue("student_id");

        if(val == "new") sPage = "1";
        dwr.util.removeAllRows("consultList");

        studentService.getStudentMemoListCount(student_id, function(cnt) {
            paging.count(sPage, cnt, '10', '5', comment.blank_list);
            studentService.getStudentMemoList(sPage, '5', student_id, function (selList) { //상담리스트
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var contentHTML = "<a href='javascript:void(0);' id="+cmpList.studentMemoId+">"+ellipsis(cmpList.memoContent, 10)+"</a>";
                            var proccessHTML = "<input type='button' value='처리하기' id="+cmpList.studentMemoId+" onclick='changeProccessYn(this.id);'>";
                            var cellData = [
                                function(data) {return cmpList.memoContent},
                                function(data) {return cmpList.memberName;},
                                function(data) {return convert_memo_type(cmpList.memoType);},
                                function(data) {return getDateTimeSplitComma(cmpList.createDate);},
                                function(data) {return cmpList.processYn == false ? proccessHTML : "처리완료";}
                            ];
                            dwr.util.addRows("consultList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }

            });
        });
    }
    */
    //상담리스트 가져오기(최근 3건만)
    function student_memo_list() {
        var student_id = getInputTextValue("student_id");
        studentService.getStudentMemoLastThree(student_id, function (memoList) {
            if (memoList.length < 0) return;
            dwr.util.addRows("consultList", memoList, [
                function(data) {return data.memoContent},
                function(data) {return data.memberName;},
                function(data) {return convert_memo_type(data.memoType);},
                function(data) {return getDateTimeSplitComma(data.createDate);},
                function(data) {return data.processYn == false ? "<input type='button' value='처리하기' id="+data.studentMemoId+" onclick='changeProccessYn(this.id);'>" : "처리완료";}
            ], {escapeHtml:false} );
        });
    }

    function school_radio(school_grade) {
        schoolSelectbox("student_grade","", school_grade);
    }

    function school_search_popup() { //학교검색
        var school_type =  $(":input:radio[name=school_type]:checked").val();

        if(school_type == null){
            alert("학교구분을 선택해 주세요.");
            return false;
        }
        var param = "?school_type="+school_type;
        gfn_winPop(750,200,"jsp/popup/school_search_popup.jsp",param);
    }

    // 처리하기 버튼
    function changeProccessYn(studentMemoId) {
        if (confirm("처리하시겠습니까?")) {
            studentService.modifyMemoProcessYn(studentMemoId, true);
            isReloadPage(true)
        }
    }
</script>
<body onload="init();">
<form name="frm" id="frm" method="get">
    <input type="hidden" id="school" name="school" value="">
    <input type="hidden" id="fileName" name="fileName" value="">
    <input type="hidden" id="fileUrl" name="fileUrl" value="">
    <input type="hidden" id="student_id" name="student_id" value="<%=student_id%>">
    <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <h1>학생정보입력 수정page</h1>
    <table>

        <tr>
            <th>학생사진</th>
            <td>
                <input type="file" id="attachFile" name="attachFile" onchange="preViewImage(this, 'modify_preView', 'preview');">
            </td>
        </tr>
        <tr id="preview" style="display: none;">
            <td>
                <img id="modify_preView" src="" width="80px" height="80px">
            </td>
        </tr>
        <tr>
            <th>학생이름*</th>
            <td>
                <input type="text" id="student_name" name="student_name">
            </td>
        </tr>
        <tr>
            <th>성별*</th>
            <td>
                <input type="radio" name="student_gender" value="MALE">남
                <input type="radio" name="student_gender" value="FEMALE">여
            </td>
        </tr>
        <tr>
            <th>학생생일*</th>
            <td>
                <input type="text" id="startDate" name="startDate" >
            </td>
        </tr>
        <tr>
            <th>핸드폰번호</th>
            <td>
                <input type="text" size="2" name="student_phone1" id="student_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.student_phone2,3)">
                -
                <input type="text" size="5" name="student_phone2" id="student_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.student_phone3,4)">
                -
                <input type="text" size="5" name="student_phone3" id="student_phone3" maxlength="4">
            </td>
        </tr>
        <tr>
            <th>집전화</th>
            <td>
                <input type="text" size="2" name="student_tel1" id="student_tel1" maxlength="3" onkeyup="js_tab_order(this,frm.student_tel2,3)">
                -
                <input type="text" size="5" name="student_tel2" id="student_tel2" maxlength="4" onkeyup="js_tab_order(this,frm.student_tel3,4)">
                -
                <input type="text" size="5" name="student_tel3"  id="student_tel3" maxlength="4">
            </td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>
                <input type="text" id="student_email" name="student_email">
            </td>
        </tr>
        <tr>
            <th>학교구분</th>
            <td>
                <input type="radio" name="school_type" value="elem_list" onclick="school_radio(this.value);">초등학교
                <input type="radio" name="school_type" value="midd_list" onclick="school_radio(this.value);">중학교
                <input type="radio" name="school_type" value="high_list" onclick="school_radio(this.value);">고등학교
            </td>
        </tr>
        <tr>
            <th>학년*</th>
            <td>
                <span id="student_grade"></span>
            </td>
        </tr>
        <tr>
            <th>학교이름</th>
            <td>
                <input type="text" id="schoolname" name="schoolname" onclick="school_search_popup();">
            </td>
        </tr>
        <tr>
            <th>메모</th>
            <td>
                <textarea id="student_memo" cols="20" rows="3"/></textarea>
            </td>
        </tr>
        <tr>
            <th>학부모(모)이름*</th>
            <td>
                <input type="text" id="mother_name" name="mother_name">
            </td>
        </tr>
        <tr>
            <th>학부모(모)전화번호*</th>
            <td>
                <input type="text" size="2" id="mother_phone1" name="mother_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.mother_phone2,3)">
                -
                <input type="text" size="5" id="mother_phone2" name="mother_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.mother_phone3,4)">
                -
                <input type="text" size="5" id="mother_phone3" name="mother_phone3" maxlength="4">
            </td>
        </tr>

        <tr>
            <th>학부모(부)이름</th>
            <td>
                <input type="text" id="father_name" name="father_name">
            </td>
        </tr>
        <tr>
            <th>학부모(부)전화번호</th>
            <td>
                <input type="text" size="2" id="father_phone1" name="father_phone1" maxlength="3" onkeyup="js_tab_order(this,frm.father_phone2,3)">
                -
                <input type="text" size="5" id="father_phone2" name="father_phone2" maxlength="4" onkeyup="js_tab_order(this,frm.father_phone3,4)">
                -
                <input type="text" size="5" id="father_phone3" name="father_phone3" maxlength="4">
            </td>
        </tr>


    </table>
    <tbody id="dataList"></tbody>
    <input type="button" value="수정" onclick="modify_student();"><br>


    <br><br>
    <span id="l_memoType"></span>
    <div>
        <textarea id="consultMemo" cols="50" rows="5" placeholder="상담내용을 입력하세요"></textarea>
        <input type="button" value="상담저장" onclick="studentMemo();">
    </div>

    <br>
    <div style="float:left;">
        <h1>상담list</h1>
        <table class="table_list" border="1">
            <colgroup>
                <!-- <col width="2%" />-->
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
            </colgroup>
            <thead>
            <tr>
                <!--<th>
                    <input type="checkbox" id="chkAll" onclick="javascript:checkall('chkAll');">
                </th>-->
                <th>상담내용</th>
                <th>상담자</th>
                <th>상담구분</th>
                <th>상담날짜</th>
                <th>처리여부</th>
            </tr>
            </thead>
            <tbody id="consultList"></tbody>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
            <!--<input type="button" value="삭제" onclick="Delete();">-->
        </table>
    </div>

</form>

</body>