<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long lecture_id = Long.parseLong(request.getParameter("lecture_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");

    int depth1 = 4;
    int depth2 = 3;

    int siderMenuDepth1 = 4;
    int siderMenuDepth2 = 5;
    int siderMenuDepth3 = 3;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>

<script>
    $(function () {
        $("#student_add").on('click', function () { //아이디찾기 팝업
            initPopup($("#StudentFindLayer"));
        });
    });
    function init() {
        schoolTypeSelectbox("l_schoolType", "");
    }

    var isChange = false;
    $(document).ready(function () {
        $("input, select, textarea").change(function () {
            isChange = true;
        });
    });

    function go_list() {
        if(isChange) {
            if (confirm(comment.is_change_confirm)) {
                goPage('lecture', 'lecture_list')
            }
        } else {
            goPage('lecture', 'lecture_list')
        }
    }
</script>

<body onload="init();">
<div id="loadingbar" class="loadingbar" style="display:none;">
    <img src="img/loading.gif">
</div>
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/lecture_top_menu.jsp" %>
</div>
</section>
<section class="content">
    <form name="frm" method="get">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" name="lecture_id" id="lecture_id" value="<%=lecture_id%>">
    </form>

    <div class="tb_t1">
        <table>
            <thead>
            <tr>
                <th>강의명</th>
                <td>
                    <span>수학의아침</span>
                </td>
                <th>선생님</th>
                <td>
                    <span>원소정</span>
                </td>
            </tr>
            <tr>
                <th>강의실</th>
                <td>
                    <span>201호</span>
                </td>
                <th>수강료</th>
                <td>
                    <span>50,000</span>
                </td>
            </tr>
            <tr>
                <th>정원</th>
                <td>
                    <span>50</span>
                </td>
                <th>현재인원</th>
                <td>
                    <span>30</span>
                </td>
            </tr>
        </table>
    </div>
</section>
<section class="content">
    <h3 class="title_t1">기존 수강중인 학생</h3>
    <div class="tb_t1">
        <table>
            <thead>
            <tr>
                <th>이름</th>
                <th>학교</th>
                <th>변경</th>
            </tr>
            </thead>
            <tbody id="dataList"></tbody>
            <tr>
                <td>홍길동</td>
                <td>문막초등학교</td>
                <td>x</td>
            </tr>
            <tr>
                <td>홍길동</td>
                <td>문막초등학교</td>
                <td>x</td>
            </tr>
            <tr>
                <td>홍길동</td>
                <td>문막초등학교</td>
                <td>x</td>
            </tr>
            <tr>
                <td>홍길동</td>
                <td>문막초등학교</td>
                <td>x</td>
            </tr>
            <tr>
                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
            </tr>
        </table>
        <div class="tb_t1">
            <table>
                <td style="text-align:center;">현재인원 0명 / 18명 추가 가능</td>
                <td style="width:30px;"><button style="float:right;"  id="student_add" class="btn_pack blue s2" >추가</button></td>
            </table>
        </div>
        <button class="btn_pack blue s2" >저장</button>
        <button class="btn_pack blue s2" onclick="go_list();">목록</button>
    </div>
</section>

<!--학생추가 레이어 시작-->
<div class="layer_popup_template apt_request_layer" id="StudentFindLayer" style="display: none;">
    <div class="layer-title" style="border-bottom: 0px ;">
        <button id="close_btn_pw" type="button" class="fa fa-close btn-close"></button>
    </div>
    <section class="content">
       <!-- <form name="frm" method="get">
            <input type="hidden"  id="sPage" value="<%=sPage%>">
        </form>-->
        <div class="tb_t1">
            <table>
                <thead>
                <tr>
                    <th>학교선택</th>
                    <td>
                      <span id="l_schoolType"></span>
                    </td>
                </tr>
                <tr>
                    <th>검색정보</th>
                    <td colspan="2">
                        <div class="form-group row marginX">
                                 <select class="form-control" style="width: 15rem;">
                                    <option value="">이름</option>
                                    <option value="">전화번호</option>
                                    <option value="">학부모(모)</option>
                                </select>
                            <input type="text" class="form-control">
                        </div>
                    </td>
                </tr>
            </table>
            <div class="bot_btns_t1">
                <button class="btn_pack blue" type="button">저장</button>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="tb_t1">
            <table>
                <thead>
                <tr>
                    <th>선택</th>
                    <th>No.</th>
                    <th>수강관</th>
                    <th>전화번호</th>
                    <th>학교명</th>
                    <th>학년</th>
                    <th>학부모(모) 이름</th>
                    <th>학부모(모) 전화번호</th>
                </tr>
                </thead>
                <tbody></tbody>
                <tr>
                    <td><input type="checkbox" class="form-control" id="chkAll" onclick="javascript:checkall('chkAll');"></td>
                    <td>1</td>
                    <td>워는정</td>
                    <td>사이언스카이</td>
                    <td>010-7313-0599</td>
                    <td>문막초등학교</td>
                    <td>홍길동</td>
                    <td>010-5053-1224</td>
                </tr>
                <tr>
                    <td><input type="checkbox" class="form-control" id="chkAll" onclick="javascript:checkall('chkAll');"></td>
                    <td>1</td>
                    <td>워는정</td>
                    <td>사이언스카이</td>
                    <td>010-7313-0599</td>
                    <td>문막초등학교</td>
                    <td>홍길동</td>
                    <td>010-5053-1224</td>
                </tr>
            </table>
            <div class="bot_btns_t1" style="text-align: center;">
                <button class="btn_pack blue" type="button">선택</button>
                <button class="btn_pack btn-close" type="button">취소</button>
            </div>
            <!--<input type="button" class="btn_pack blue s2" value="선택" >
            <input type="button" class="btn_pack blue s2" value="취소">-->
            <%@ include file="/common/inc/com_pageNavi.inc" %>
        </div>
    </section>
</div>
<!--학생 추가 레이어 끝-->
<%@include file="/common/jsp/footer.jsp" %>
</body>

