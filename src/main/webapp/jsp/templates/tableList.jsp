<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 6;
    int depth2 = 3;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
    <div class="container">
        <%@include file="/common/jsp/titleArea.jsp" %>
    </div>
</section>
        <section class="content">
            <h3 class="title_t1">Table List</h3>
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
<%@include file="/common/jsp/footer.jsp" %>