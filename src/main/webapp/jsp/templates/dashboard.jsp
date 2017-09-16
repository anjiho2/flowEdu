<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<body>
<div id="wrap">
    <header id="header">
        <h1><img src="" alt=""></h1>
        <button class="toggle_aside"></button>
        <nav id="lnb">
            <a href=""><span class="fa fa-home"></span>HOME</a>
            <a href=""><span class="fa fa-user"></span>학생관리</a>
            <a href=""><span class="fa fa-university"></span>학원정보</a>
            <a href=""><span class="fa fa-address-card"></span>운영자/선생님정보</a>
            <a href=""><span class="fa fa-pencil"></span>강의관리</a>
            <a href=""><span class="fa fa-power-off"></span>LOGOUT</a>
        </nav>
    </header>
    <div class="container">
        <section class="top_area">
            <div class="gnb">
                <div class="total_search"><button class="fa fa-search"></button></div>
                <div class="my_box">
                    <button>선생님 안녕하세요. <span class="fa fa-chevron-down"></span></button>
                    <ul class="my_menu">
                        <li><a href="">메뉴1</a></li>
                        <li><a href="">메뉴2</a></li>
                        <li><a href="">메뉴3</a></li>
                    </ul>
                </div>
            </div>
            <div class="out_box">
                <h2>타이틀2</h2>
                <nav class="depth2">
                    <a href="" class="on">MENU1</a>
                    <a href="">MENU2</a>
                    <a href="">MENU3</a>
                    <a href="">MENU4</a>
                </nav>
            </div>
        </section>
        <section class="content">
            <h3 class="title_t1">타이틀</h3>
            <div class="tb_t1">
                <table>
                    <colsgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col width="110">
                    </colsgroup>
                    <tr>
                        <th>그룹 / 관</th>
                        <th>원장명</th>
                        <th>주소</th>
                        <th>관전화번호</th>
                        <th>팩스번호</th>
                        <th>생성일</th>
                        <th class="center">수정</th>
                    </tr>
                    <% for(int i = 0 ; i < 10 ; i++) { %>
                    <tr>
                        <td>
                            <span class="mini">플로우 교육</span>
                            <div class="title">수학의아침 초등관1</div>
                        </td>
                        <td>김철수 원장</td>
                        <td>경기도 성남시 분당구 수내동 무슨건물 3층</td>
                        <td><a href="tel:02-2334-4455" class="link">02-2334-4455</a></td>
                        <td>055-1234-1234</td>
                        <td>2017-09-05</td>
                        <td><button class="btn_pack white" ><span class="fa fa-edit"></span> Edit</button></td>
                    </tr>
                    <% } %>
                </table>
            </div>
        </section>
    </div>
</div>
</body>
</html>