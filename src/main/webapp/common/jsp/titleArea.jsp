<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script>
    $(function(){
        $("#my_menu_btn").mouseover(function(){
            var menu = $(this).next('.my_menu');
            $(".my_menu").show();
        });

        $(".my_menu").mouseleave(function(){
            var menu = $(this).next('.my_menu');
            $(".my_menu").hide();
        });
    });
</script>
