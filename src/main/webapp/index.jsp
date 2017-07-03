<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/jsp/top.jsp" %>

<script type="text/javascript" src="<%=webRoot%>/dwr/interface/loginService.js"></script>
<script type="text/javascript">
    function excelUpload() {
        var check = new isCheck();
        var data = new FormData();
        $.each($('#excel_file')[0].files, function(i, file) {
            data.append("excel_file", file);
        });
        var excelFile = fn_clearFilePath($("#excel_file").val());
		alert(excelFile);
        if (check.value(excelFile, comment.select_excel_file) == false) return;

        if (confirm(comment.isInsert)) {
            if (excelFile != null) {
                $.ajax ({
                    url: "<%=webRoot%>/excelReader/monthSale.do",
                    method : "POST",
                    dataType : "JSON",
                    data: data,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(data) {
                        alert(comment.success_process);
                    }
                });
            }
        }
    }
</script>
<body id="login">
<form name="frm" method="post">
<input type="hidden" name="param1" />
<input type="hidden" name="param2" />
<input type="hidden" name="page_gbn" id="page_gbn">
플로우 교육 개발
</form>

<%-- <%@ include file="/common/jsp/top_menu.jsp"%> --%>
</body>
</html>
