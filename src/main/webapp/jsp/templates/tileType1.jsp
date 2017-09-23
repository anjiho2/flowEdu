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
        <section class="content">
            <h3 class="title_t1">Tile Type1</h3>
            <div class="tile_t1">
                <ul>
                    <% for(int i = 0 ; i < 8 ;i++){%>
                    <li>
                        <div class="in">
                            <div class="img"><img src="//storage.googleapis.com/cr-resource/image/b2eb2743f14acd4fa08428dada9d9fa7/flowedusooaa/650/155c93735d87384127ed3e13f2c8b926.JPG" alt=""></div>
                            <div class="txt">
                                <h4>타이틀입니다</h4>
                                <p>컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 </p>
                                <button class="detail">view detail</button>
                            </div>
                        </div>
                    </li>
                    <% } %>
                </ul>
            </div>

            <h3 class="title_t1">Variation1 - Text Only</h3>
            <div class="tile_t1">
                <ul>
                    <% for(int i = 0 ; i < 8 ;i++){%>
                    <li>
                        <div class="in">
                            <div class="txt">
                                <h4>타이틀입니다</h4>
                                <p>컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 </p>
                                <button class="detail">view detail</button>
                            </div>
                        </div>
                    </li>
                    <% } %>
                </ul>
            </div>

            <h3 class="title_t1">Variation2 - Image Only & Include Search Hover</h3>
            <div class="tile_t1">
                <ul>
                    <% for(int i = 0 ; i < 8 ;i++){%>
                    <li>
                        <a class="in" href="">
                            <div class="img">
                                <img src="//storage.googleapis.com/cr-resource/image/b2eb2743f14acd4fa08428dada9d9fa7/flowedusooaa/650/155c93735d87384127ed3e13f2c8b926.JPG" alt="">
                                <div class="cover"><span class="fa fa-search"></span></div>
                            </div>
                        </a>
                    </li>
                    <% } %>
                </ul>
            </div>

            <h3 class="title_t1">Variation3 - Checkbox</h3>
            <div class="tile_t1">
                <ul>
                    <% for(int i = 0 ; i < 8 ;i++){%>
                    <li>
                        <label class="in">
                            <input type="checkbox">
                            <span class="input_cover"><span class="fa fa-check"></span></span>
                            <div class="txt">
                                <h4>타이틀입니다</h4>
                                <p>컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 </p>
                            </div>
                        </label>
                    </li>
                    <% } %>
                </ul>
            </div>


            <h3 class="title_t1">Variation4 - Radio Button</h3>
            <div class="tile_t1">
                <ul>
                    <% for(int i = 0 ; i < 8 ;i++){%>
                    <li>
                        <label class="in">
                            <input type="radio" name="sample_radio">
                            <span class="input_cover"><span></span></span>
                            <div class="txt">
                                <h4>타이틀입니다</h4>
                                <p>컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 컨텐츠 내용입니다 </p>
                            </div>
                        </label>
                    </li>
                    <% } %>
                </ul>
            </div>

            <script>
                imgAlign('.tile_t1 .img img'); //이미지를 꽉채우도록 정렬하는 함수.
            </script>
        </section>
    </div>
<%@include file="/common/jsp/footer.jsp" %>
</body>