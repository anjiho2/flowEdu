<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 6;
    int depth2 = 6;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
    <div class="container">
        <%@include file="/common/jsp/titleArea.jsp" %>
        <%@include file="/common/jsp/depth_menu.jsp" %>
            </div>
        </section>
        <section class="content divide">
            <div class="left">
                <div class="tile_box">
                    <h3 class="title_t1">원은정 학생 정보</h3>
                    <ul class="list_t1">
                        <li>
                            <strong>학생이름</strong>
                            <div><p>원은정 <span class="fa fa-female"></span></p></div>
                        </li>
                        <li>
                            <strong>생일</strong>
                            <div><p>2017-09-27</p></div>
                        </li>
                        <li>
                            <strong>핸드폰번호</strong>
                            <div><p>010-1234-1234</p></div>
                        </li>
                        <li>
                            <strong>이메일</strong>
                            <div><p>ab@gmail.com</p></div>
                        </li>
                        <li>
                            <strong>메모</strong>
                            <div><p>안녕하세요 메모입니다. 안녕하세요 메모입니다. 안녕하세요 메모입니다.안녕하세요 메모입니다.안녕하세요 메모입니다.</p></div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="right">
                <div class="tile_box">
                    <h3 class="title_t1">최근 상담</h3>
                    <ul class="list_t2 checkbox_t2">
                        <%for(int i = 0 ; i < 4 ; i++){%>
                        <li>
                            <label><input type="checkbox"><span class="fa fa-check"></span></label>
                            <div>
                                <h4><span><i class="tag">일반</i>홍길동 실장</span> <em>2017-09-24 18:49:41</em></h4>
                                <p>학생이 학원버스를 놓쳐서 학부모님에게 연락이 왔습니다. 기사분께 연락드려서 확인해야 합니다.</p>
                                <button class="confirm">처리하기</button>
                            </div>
                            <div class="manage">
                                <button>수정</button>
                                <button>삭제</button>
                            </div>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
        </section>
    </div>
<%@include file="/common/jsp/footer.jsp" %>