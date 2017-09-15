<%@page import="com.flowedu.config.VersionConfigHolder"%>
<%@ page import="com.flowedu.dto.FlowEduMemberDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/jsp/common.jsp" %>
<%
	String webRoot = request.getContextPath();
	String serverName = request.getServerName();
	String memberName = "";
	Long memberId  = 0L;
	//VersionConfigHolder holder = new VersionConfigHolder();
	String version = VersionConfigHolder.gerVersion();

	if (session.getAttribute("member_info") != null) {
		FlowEduMemberDto flowEduMemberDto = (FlowEduMemberDto) session.getAttribute("member_info");
		 memberName = flowEduMemberDto.getMemberName();
		 memberId = flowEduMemberDto.getFlowMemberId();

	}
%>
<!DOCTYPE html>
<!--  jquery plugin -->
<script type='text/javascript' src="<%=webRoot%>/common/js/jquery-1.11.3.min.js"></script>
<%--
<link rel="stylesheet" href="<%=webRoot%>/Bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=webRoot%>/Bootstrap/css/bootstrap-theme.min.css">
-->
<!-- bootstrap 스크립트 -->
<%--<script src="<%=webRoot%>/Bootstrap/js/bootstrap.min.js"></script>--%>


<!-- 공통 유틸 스크립트 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<link rel="stylesheet" href="calendar/css/fullcalendar.css">

<script type='text/javascript' src="<%=webRoot%>/calendar/lib/moment.min.js"/>
<script type='text/javascript' src="<%=webRoot%>/calendar/lib/locale-all.js"/>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- dwr 필수 스트립트 -->
<script type='text/javascript' src="<%=webRoot%>/dwr/engine.js"></script>
<script type='text/javascript' src="<%=webRoot%>/dwr/util.js"></script>

<script src='//cdn.rawgit.com/fgelinas/timepicker/master/jquery.ui.timepicker.js'></script>
<script type='text/javascript' src="<%=webRoot%>/js/datepicker.js"></script>
<script type='text/javascript' src="<%=webRoot%>/js/jquery.mtz.monthpicker.js"></script>
<script type='text/javascript' src="<%=webRoot%>/js/blank-check.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/js/page.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/js/selectbox.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/common/js/comment.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/common/js/common.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/js/few-weeks.js"></script>
<script type='text/javascript' src="<%=webRoot%>/js/paging-count-check.js"></script>
<script type='text/javascript' src="<%=webRoot%>/js/radio.js?ver=<%=version%>"></script>

<!-- 페이징 관련 필수 스트립트 -->
<script type='text/javascript' src="<%=webRoot%>/common/js/com_page.js"></script>

<script type='text/javascript' src="<%=webRoot%>/calendar/js/fullcalendar.js"></script>

<%--<script type='text/javascript' src="<%=webRoot%>/calendar/js/fullcalendar.min.js"/>--%>


<script type='text/javascript' src="<%=webRoot%>/common/js/alert.js?ver=<%=version%>"></script><!-- jquery alert -->
<script type='text/javascript' src="<%=webRoot%>/common/js/jquery.confirm.js?ver=<%=version%>"></script>	<!-- jquery alert -->

<link rel="stylesheet" type="text/css" href="<%=webRoot%>/common/css/jquery.confirm.css"><!-- jquery alert css -->

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<script src="<%=webRoot%>/calendar/lang/ko.js"/>
<!-- 공통으로 쓰는 값 모여있는 스크립트 -->
<script src="<%=webRoot%>/js/value.js?ver=<%=version%>"></script>
<!-- 페이지 이동 스크립트 -->
<script src="<%=webRoot%>/js/page.js?ver=<%=version%>"></script>
<!-- 공통으로 쓰는 값 모여있는 스크립트 -->
<script src="<%=webRoot%>/js/convert_value.js?ver=<%=version%>"></script>

<meta charset="utf-8">
<title>플로우 교육</title>
</head>
