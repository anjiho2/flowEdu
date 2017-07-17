<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue("sPage", "1");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/jsp/top.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/loginService.js'></script>

<script type="text/javascript">
    var paging = new Paging();

    function init() {
        dwr.util.useLoadingMessage(comment.load_data);

        fn_search("new");
    }

    function fn_search(val) {
        var sPage = getInputTextValue("sPage");
        var pagingCnt = "5";

        if (val == "new") {
            sPage = "1";
        }
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");

        loginService.userListSize(function(cnt) {
            paging.count2(sPage, cnt, "5", pagingCnt, comment.blank_list);

            loginService.selectUserList(sPage, pagingCnt, function(selList) {
                if (selList.length > 0) {
                    for (var i=0; i<selList.length; i++) {
                        var cmpList = selList[i];
                        var cellData = [
                            function(data) {return cmpList.userName},
                            function(data) {return cmpList.receiver},
                            function(data) {return getDateTimeSplitComma(cmpList.createDate)},
                            function(data) {return cmpList.itemName},
                            function(data) {return gfn_isData(cmpList.openYn, 0, "수령전", "수령완료")},
                            function(data) {return gfn_isData(cmpList.openDate, null, "", getDateTimeSplitComma(cmpList.openDate))}
                        ]
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml:false});
                    }
                } else {
                    //사용자 프로필 리스트가 없을떄
                    gfn_printPageNum_new2('0', '5', '5', '1');
                    gfn_emptyView('V', comment.blank_search_result);
                }
            });
        });
    }
</script>
<body id="login" onload="init();">
<form name="frm" method="post">
<input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">
<input type="hidden" name="param1" />
<input type="hidden" name="param2" />
<input type="hidden" name="page_gbn" id="page_gbn">
    플로우 교육 개발

    <table class="table table-striped table-bordered table-hover">
        <colgroup>
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
        </colgroup>
        <thead>
        <tr>
            <th>보낸사람 전화번호</th>
            <th>받은사람 전화번호</th>
            <th>보낸 일시</th>
            <th>아이템명</th>
            <th>선물상태</th>
            <th>수령일시</th>
        </tr>
        </thead>
        <tbody id="dataList"></tbody>
        <tr>
            <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
        </tr>
    </table>
    <%@ include file="/common/inc/com_pageNavi2.inc" %>

</form>

<span id="name"></span>
<%-- <%@ include file="/common/jsp/top_menu.jsp"%> --%>
</body>
</html>
