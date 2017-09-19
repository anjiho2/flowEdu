<%@	taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	String contextPath = request.getContextPath();
	contextPath = contextPath.endsWith("/") ? contextPath.substring(0, contextPath.length() - 1) : contextPath;
	request.setAttribute("webRoot", contextPath);

	//FlowEduMemberDto memberDto = (FlowEduMemberDto)session.getAttribute("member_info");
	Long memberId = 0L;
	String memberName = "";
	if (session.getAttribute("member_info") != null) {
		FlowEduMemberDto flowEduMemberDto = (FlowEduMemberDto) session.getAttribute("member_info");
		memberName = flowEduMemberDto.getMemberName();
		memberId = flowEduMemberDto.getFlowMemberId();
	}
%>