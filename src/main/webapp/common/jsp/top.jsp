<%@page import="com.flowedu.config.VersionConfigHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/jsp/common.jsp" %>
<%
	String webRoot = request.getContextPath();
	String serverName = request.getServerName();
	
	VersionConfigHolder holder = new VersionConfigHolder();
%>

<!--  jquery plugin -->
<script type='text/javascript' src="<%=webRoot%>/common/js/jquery-1.11.3.min.js"></script>

<link rel="stylesheet" href="<%=webRoot%>/Bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=webRoot%>/Bootstrap/css/bootstrap-theme.min.css">
<!-- bootstrap 스크립트 -->
<script src="<%=webRoot%>/Bootstrap/js/bootstrap.min.js"></script>

<%--
<link rel="shortcut icon" href="<%=webRoot%>/common/images/icon/favicon.ico" type="image/x-icon">
<link rel="icon" href="<%=webRoot%>/common/images/icon/favicon.ico" type="image/x-icon">
-->
<!-- 공통 유틸 스크립트 -->
<script type='text/javascript' src="<%=webRoot%>/common/js/common.js?ver=  "></script>
<script type='text/javascript' src="<%=webRoot%>/common/js/comment.js?ver=  "></script>
<script type='text/javascript' src="<%=webRoot%>/js/blank-check.js?ver=  "></script>
<script type='text/javascript' src="<%=webRoot%>/js/page.js?ver=  "></script>
<script type='text/javascript' src="<%=webRoot%>/js/selectbox.js?ver=  "></script>
<%-- <script type='text/javascript' src="<%=webRoot%>/js/datepicker.js"></script> --%>
<script type='text/javascript' src="<%=webRoot%>/js/few-weeks.js"></script>
<!-- 페이징 관련 필수 스트립트 -->
<script type='text/javascript' src="<%=webRoot%>/common/js/com_page.js"></script>
<!-- dwr 필수 스트립트 -->
<script type='text/javascript' src="<%=webRoot%>/dwr/engine.js"></script>
<script type='text/javascript' src="<%=webRoot%>/dwr/util.js"></script>
 
<script type='text/javascript' src="<%=webRoot%>/common/js/alert.js?ver=  "></script><!-- jquery alert -->
<script type='text/javascript' src="<%=webRoot%>/common/js/jquery.confirm.js?ver=  "></script>	<!-- jquery alert -->

<link rel="stylesheet" type="text/css" href="<%=webRoot%>/common/css/jquery.confirm.css"><!-- jquery alert css -->


<!-- 공통으로 쓰는 값 모여있는 스크립트 -->
<script src="<%=webRoot%>/js/value.js?ver=  "></script>
<!-- 페이지 이동 스크립트 -->
<script src="<%=webRoot%>/js/page.js?ver=  "></script>

<meta charset="utf-8">
<title>플로우 교육</title>
</head>