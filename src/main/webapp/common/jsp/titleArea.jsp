<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String memberName = "";
    Long memberId  = 0L;

    if (session.getAttribute("member_info") != null) {
    FlowEduMemberDto flowEduMemberDto = (FlowEduMemberDto) session.getAttribute("member_info");
    memberName = flowEduMemberDto.getMemberName();
    memberId = flowEduMemberDto.getFlowMemberId();
}
%>
<section class="top_area">
    <div class="gnb">
        <div class="total_search">
            <%--<button class="fa fa-search"></button>--%>
        </div>
        <div class="my_box">
            <%--<a href="javascript:void(0);" onclick="goPage('member','login_member_modify')"></a>--%>
            <button id="my_menu_btn"><%=memberName%>님 안녕하세요. <span class="fa fa-chevron-down"></span></button>
            <ul class="my_menu" style="display: none;">
                <li><a href="javascript:void(0);" onclick="goPage('member','login_member_modify')">비밀번호 변경</a></li>
                <!--
                <li><a href="">메뉴2</a></li>
                <li><a href="">메뉴3</a></li>
                -->
            </ul>
        </div>
    </div>

    <div class="out_box">
        <%--<h2>Front Templates</h2>--%>
        <%--<nav class="depth2">--%>
            <%--<a href="/flowEdu/template.do?page_gbn=dashboard" <%=depth2 == 1 ? "class=\"on\"" : ""%>>DashBoard</a>--%>
            <%--<a href="/flowEdu/template.do?page_gbn=formType1" <%=depth2 == 2 ? "class=\"on\"" : ""%>>Forms</a>--%>
            <%--<a href="/flowEdu/template.do?page_gbn=tableList" <%=depth2 == 3 ? "class=\"on\"" : ""%>>Table List</a>--%>
        <%--</nav>--%>
<script>
    $(document).ready(function(){
        $("#my_menu_btn").click(function(){
            if ($(".my_menu").css("display") == "none") {
                $(".my_menu").show();
            } else {
                $(".my_menu").hide();
            }
        });
    });
</script>



            <%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
            <%--<section class="top_area">--%>
                <%--<div class="gnb">--%>
                    <%--<div class="total_search"><button class="fa fa-search"></button></div>--%>
                    <%--<div class="my_box">--%>
                        <%--<button>선생님 안녕하세요. <span class="fa fa-chevron-down"></span></button>--%>
                        <%--<ul class="my_menu">--%>
                            <%--<li><a href="">메뉴1</a></li>--%>
                            <%--<li><a href="">메뉴2</a></li>--%>
                            <%--<li><a href="">메뉴3</a></li>--%>
                        <%--</ul>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="out_box">--%>
                    <%--<h2>Front Templates</h2>--%>
                    <%--<nav class="depth2">--%>
                        <%--<a href="/flowEdu/template.do?page_gbn=dashboard" <%=depth2 == 1 ? "class=\"on\"" : ""%>>DashBoard</a>--%>
                        <%--<a href="/flowEdu/template.do?page_gbn=formType1" <%=depth2 == 2 ? "class=\"on\"" : ""%>>Forms</a>--%>
                        <%--<a href="/flowEdu/template.do?page_gbn=tableList" <%=depth2 == 3 ? "class=\"on\"" : ""%>>Table List</a>--%>
                    <%--</nav>--%>
                <%--</div>--%>
            <%--</section>--%>