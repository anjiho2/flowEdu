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
</div>
</section>
<form name="frm" id="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
</form>

    <section class="content">
        <div class="title_top">학습관리</div>
        <h3 class="title_t1">과제 등록</h3>
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
                                <option value="">사용</option>
                                <option value="">사용하지않음</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>과제 제목</th>
                        <td colspan="3">
                            <input type="text" class="form-control">
                        </td>
                    </tr>
                    <tr>
                        <th>과제 내용</th>
                        <td colspan="3">
                            <textarea class="form-control" rows="5"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td colspan="3">
                            <label class="custom-file">
                                <input type="file" class="custom-file-input">
                                <span class="custom-file-control"></span>
                            </label>
                            <span>첨부파일은 hwp, doc, docx, pdf 파일 등록만 가능하며 500kbyte로 용량을 제한합니다.</span>
                        </td>
                    </tr>
                </tbody>
            </table>
            <button class="btn_pack blue s2">저장</button>
            <button class="btn_pack blue s2">목록</button>
        </div>
    </section>




<%@include file="/common/jsp/footer.jsp" %>
</body>
<script>
    $(".sidebar-menu > li").eq(2).addClass("active");
    $(".sidebar-menu > li:nth-child(3) > ul > li:nth-child(2) > a").addClass("on");
</script>
