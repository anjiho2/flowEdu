<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 6;
    int depth2 = 4;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<body>
    <div class="container">
        <%@include file="/common/jsp/titleArea.jsp" %>
        <%@include file="/common/jsp/depth_menu.jsp" %>
    </div>
    </section>
    <!--여기까지-->
    <div style="display: flex">
    <div class="leftslide">
        <ul>
            <li>test</li>
            <li>test</li>
            <li>test</li>
            <li>test</li>
            <li>test</li>
            <li>test</li>
            <li>test</li>
            <li>test</li>
            <li>test</li>
        </ul>
    </div>
       <section class="content" style="flex: 1 1 auto;border:solid 1px red;margin-top:0px;">
           ff
       </section>
    </div>

    <!--여기까지-->
    </div>
<%@include file="/common/jsp/footer.jsp" %>
</body>

<style>
    .leftslide{height:100%; flex:0 0 250px; border:solid 1px;}
</style>

<script>
    $(function(){
        $('');

    });
</script>