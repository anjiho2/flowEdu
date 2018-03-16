<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 6;
    int depth2 = 7;
%>
<%@include file="/common/jsp/top.jsp" %>

<div id="wrap" style="background-color: #f4f7f9;">
    <div class="into_gate">
        <div>
            <a class="in" href="/flowEdu/template.do?page_gbn=dashboard">
                <h4 class="fa fa-mortar-board"></h4>
                <h3>대시보드</h3>
            </a>
        </div>
        <div>
            <a class="in" href="/flowEdu/dashboard.do?page_gbn=dashboard_list">
                <h4 class="fa fa-bank"></h4>
                <h3>학원관리</h3>
            </a>
        </div>
        <div>
            <a class="in">
                <h4 class="fa fa-microchip"></h4>
                <h3>검색</h3>
            </a>
        </div>
    </div>
</div>
<%@include file="/common/jsp/footer.jsp" %>