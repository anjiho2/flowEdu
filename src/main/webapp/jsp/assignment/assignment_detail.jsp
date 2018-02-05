<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long assignment_id = Long.parseLong(request.getParameter("assignment_id"));
    int depth1 = 5;
    int depth2 = 2;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
    function init() {
        assignmentDetail();
    }

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

    function modify_assignment() {//과제수정하기
        var check = new isCheck();

        var data = new FormData();
        $.each($('#attachFile')[0].files, function(i, file) {
            data.append('file-' + i, file);
        });
        var attachFile = fn_clearFilePath($('#attachFile').val());
        var sel_myclass = getSelectboxValue('sel_myClass');
        data.append("lecture_id", sel_myclass);

        $.ajax({
            url: "<%=webRoot%>/file/assignment_upload.do",
            method : "post",
            dataType: "JSON",
            data: data,
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
                console.log(data);
                var errorCode = data.result.error_code;
                if (errorCode == "903") {
                    alert(comment.file_name_not_allow_korean);
                    return;
                } else if (errorCode == "904") {
                    alert(comment.file_extension_not_allow);
                    return;
                } else if (errorCode == "905") {
                    alert(comment.file_size_not_allow_300kb);
                    return;
                }

                var sel_yn =  getSelectboxValue('assignment_yn');
                var title = getInputTextValue('assignment_title');
                var content = getInputTextValue('assignment_content');
                var assignment_id = getInputTextValue("assignment_id");

                if(sel_myclass == ''){
                    alert(comment.input_myclass_type);
                    return;
                }
                if(sel_yn == '') {
                    alert(comment.input_assignment_type);
                    return;
                }
                if(check.input("assignment_title", comment.input_title)   == false) return;
                if(check.input("assignment_content", comment.input_content)   == false) return;
                if(sel_yn == 1) sel_yn = true;
                else sel_yn = false;

                if(confirm(comment.isUpdate)){
                    lectureService.saveAssignmentInfo(assignment_id, sel_myclass, sel_yn, title, content, data.result.file_name,function () {
                        alert('과제수정 완료 되었습니다');
                        goPage('lecture','assignment_list');
                    });
                }
            }
        });
    }

    function assignmentDetail() {//과제정보가져오기
        var assignmet_id = <%=assignment_id%>;

        lectureService.getAssignmentInfoList(assignmet_id , 0, false, '', '', '',function (selList) {
            for(var i= 0; i < selList.length; i++){
                var cmpList = selList[i];
                var yn_sel;
                if(cmpList != undefined){
                    myClassSelectbox('sel_myClass', cmpList.lectureId);
                    innerValue("assignment_title", cmpList.assignmentSubject);
                    innerValue("assignment_content", cmpList.assignmentContent);
                    if(cmpList.useYn == true) yn_sel = 1;
                    else yn_sel = 0;
                    $("#assignment_yn").val(yn_sel);
                    innerValue("attachFile", cmpList.assignmentFileName);
                }
            }
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
                goPage('lecture', 'assignment_list');
            }
        } else {
            goPage('lecture', 'assignment_list');
        }
    }

</script>
<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <div class="title-top">학습관리</div>
</div>
</section>
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="assignment_id" id="assignment_id" value="<%=assignment_id%>">
</form>

    <section class="content">
        <h3 class="title_t1">과제 상세</h3>
        <div class="tb_t1">
            <table>
                <tbody>
                    <tr>
                        <th>반</th>
                        <td>
                            <select id="sel_myClass" class="form-control">
                                <option value="">▶강의선택</option>
                            </select>
                        </td>
                        <th>사용여부</th>
                        <td>
                            <select class="form-control"  id="assignment_yn">
                                <option value="1">사용</option>
                                <option value="0">사용하지않음</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>과제 제목</th>
                        <td colspan="3">
                            <input type="text" class="form-control" id="assignment_title">
                        </td>
                    </tr>
                    <tr>
                        <th>과제 내용</th>
                        <td colspan="3">
                            <textarea class="form-control" rows="5"  id="assignment_content"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td colspan="3">
                            <label class="custom-file">
                                <input type="file" id="attachFile" class="custom-file-input" required>
                                <span class="custom-file-control"></span>
                            </label>
                            <span>첨부파일은 hwp, doc, docx, pdf 파일 등록만 가능하며 500kbyte로 용량을 제한합니다.</span>
                        </td>
                    </tr>
                </tbody>
            </table>
            <button class="btn_pack blue s2" onclick="modify_assignment();">저장</button>
            <button class="btn_pack blue s2" onclick="go_list();">목록</button>
        </div>
    </section>




<%@include file="/common/jsp/footer.jsp" %>
</body>
<script>
    $(".sidebar-menu > li").eq(2).addClass("active");
    $(".sidebar-menu > li:nth-child(3) > ul > li:nth-child(2) > a").addClass("on");
</script>
