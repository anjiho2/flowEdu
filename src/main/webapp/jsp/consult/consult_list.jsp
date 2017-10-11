<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 3;
    int depth2 = 2;
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/consultService.js'></script>
<script>

</script>
<body>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/consult_top_menu.jsp" %>
    <%--<%@include file="/common/jsp/depth_menu.jsp" %>--%>
</div>
</section>
<form name="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden"  id="sPage" value="<%=sPage%>">
</form>
<section class="content divide">
    <div class="left">

    </div>
    <div class="right">
        <div class="form-group row">
            <div class="checkbox_t1">
                <label><input type="radio" name="school_type" value="elem_list" checked><span>초등학교</span></label>
                <label><input type="radio" name="school_type" value="midd_list" ><span>중학교</span></label>
                <label><input type="radio" name="school_type" value="high_list" ><span>고등학교</span></label>
                <label><input type="text" class="form-control"  id="student_name" placeholder="학생이름입력" onkeypress="javascript:if(event.keyCode == 13){fn_search('new'); return false;}" ></label>
                <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
            </div>
        </div>
        <div class="tb_t1">
            <table>
                <colsgroup>
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="110">
                </colsgroup>
                <tr>
                    <th>핸드폰 번호</th>
                    <th>상담 종류</th>
                    <th></th>
                    <th>학부모(모)전화번호</th>
                    <th>학교</th>
                    <th>학년</th>
                    <th>상세</th>
                </tr>
                <tbody id="dataList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
            <div class="form-group row"></div>
            <%@ include file="/common/inc/com_pageNavi.inc" %>
        </div>
    </div>
</section>
</div>
<%@include file="/common/jsp/footer.jsp" %>
</body>
