<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    int depth1 = 5;
    int depth2 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='/flowEdu/dwr/interface/memberService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type="text/javascript">
function init() {
    memberTypeSelectbox("sel_memberType", "");  //유형
    jobPositionSelectbox("sel_jobPosition", "");    //직책
    searchAcademySelectbox("sel_academy",""); //소속
    teamListSelectbox("sel_teamList", "");  //소속팀

    fn_search("new");
}

function fn_search(val) {//운영자,선생님 리스트불러오기
    var paging = new Paging();
    var sPage = $("#sPage").val();

    if(val == "new") sPage = "1";
    dwr.util.removeAllRows("dataList");

    memberService.getFlowEduMemberListCount( function(cnt) {
        paging.count(sPage, cnt, '10', '10', comment.blank_list);
            memberService.getFlowEduMemberList(sPage, '10', function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                          var cmpList = selList[i];
                if (cmpList != undefined) {
                    var modifyHTML = "<button class='btn_pack white' type='button' id='modify' onclick='member_modify(" + cmpList.flowMemberId + ");'/>수정</button>";
                    var cellData = [
                        //   function(data) {return checkHTML;},
                        function(data) {return convert_memberType(cmpList.memberType);},
                        function(data) {return cmpList.jobPositionName;},
                        function(data) {return cmpList.memberName;},
                        function(data) {return cmpList.phoneNumber;},
                        //function(data) {return cmpList.memberBirthday;},
                        //function(data) {return ellipsis(cmpList.memberAddress, 5);},
                        function(data) {return cmpList.memberEmail;},
                        function(data) {return cmpList.officeName;},
                        function(data) {return cmpList.teamName;},
                        // function(data) {return cmpList.sexualAssultConfirmDate;},
                        //function(data) {return cmpList.educationRegDate;},
                        function(data) {return modifyHTML;}
                    ];
                    dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                }
              }
            }
        });
    });
}

function member_modify(member_id) { //수정페이지 이동
    innerValue("member_id", member_id);
    goPage('member', 'modify_member');
}
</script>

<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%--<%@include file="/common/jsp/member_top_menu.jsp" %>--%>
    <div class="title-top">운영관리</div>
</div>
</section>
<section class="content">
    <h3 class="title_t1">운영자관리</h3>
    <form name="frm" id="frm" method="get">
    <input type="hidden" name="member_id" id="member_id">
    <input type="hidden" name="page_gbn" id="page_gbn">
    <input type="hidden" name="sPage" id="sPage" value="<%=sPage%>">

        <div class="tb_t1">
            <table>
                <tr>
                    <th>유형</th>
                    <td>
                        <select id="sel_memberType" class="form-control">
                            <option value="">전체</option>
                        </select>
                    </td>
                    <th>직책</th>
                    <td>
                        <select id="sel_jobPosition" class="form-control">
                            <option value="">전체</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>소속</th>
                    <td>
                        <select id="sel_academy" class="form-control">
                            <option value="">전체</option>
                        </select>
                    </td>
                    <th>소속팀</th>
                    <td>
                        <select id="sel_teamList" class="form-control">
                            <option value="">전체</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>등록정보</th>
                    <td colspan="3">
                        <div class="form-group row marginX">
                            <select class="form-control" style="width: 13rem;margin-right:10px;">
                                <option value="name">이름</option>
                                <option value="phone">핸드폰번호</option>
                            </select>
                            <input type="text" class="form-control">
                        </div>
                    </td>
                </tr>
            </table>
            <button class="btn_pack blue">검색</button>
        </div>

        <div class="tb_t1" style="margin-top:2.5rem;">
            <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>유형</th>
                        <th>직책</th>
                        <th>이름</th>
                        <th>소속</th>
                        <th>소속팀</th>
                        <th>핸드폰번호</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>6</td>
                        <td>AMS관리자</td>
                        <td>팀장</td>
                        <td><a href="#" class="font_color blue">이형우</a></td>
                        <td>플로우교육</td>
                        <td>시스템운영팀</td>
                        <td>010-5555-2222</td>
                        <td>재직</td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>강사</td>
                        <td>원장</td>
                        <td><a href="#" class="font_color blue">엄소라</a></td>
                        <td>수학의아침 초등관</td>
                        <td>-</td>
                        <td>010-7575-8484</td>
                        <td>재직</td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>CS</td>
                        <td>원장</td>
                        <td><a href="#" class="font_color blue">박수현</a></td>
                        <td>다빈치코드</td>
                        <td>CS실</td>
                        <td>010-5975-8224</td>
                        <td>퇴사</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>AMS관리자</td>
                        <td>팀원</td>
                        <td><a href="#" class="font_color blue">오태원</a></td>
                        <td>플로우교육</td>
                        <td>시스템운영팀</td>
                        <td>010-9995-6666</td>
                        <td>재직</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>강사</td>
                        <td>팀장</td>
                        <td><a href="#" class="font_color blue">문채임</a></td>
                        <td>사이언스카이 중등관</td>
                        <td>-</td>
                        <td>010-9999-2961</td>
                        <td>퇴사</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>강사</td>
                        <td>팀원</td>
                        <td><a href="#" class="font_color blue">김형도</a></td>
                        <td>수학의아침 초등관</td>
                        <td>-</td>
                        <td>010-9444-6154</td>
                        <td>재직</td>
                    </tr>
                </tbody>
            </table>
            <button class="btn_pack blue s2" onclick="javascript:goPage('member', 'save_member')">등록</button>
        </div>
    <%--<div class="tb_t1">--%>
        <%--<table>--%>
            <%--<colgroup>--%>
                <%--<col width="*" />--%>
                <%--<col width="*" />--%>
                <%--<col width="*" />--%>
                <%--<col width="*" />--%>
                <%--<col width="*" />--%>
                <%--<col width="*" />--%>
                <%--<col width="*" />--%>
                <%--<col width="*" />--%>
                <%--<col width="*" />--%>
                <%--<col width="*" />--%>
                <%--<col width="*" />--%>
                <%--<col width="110" />--%>
            <%--</colgroup>--%>
            <%--<thead>--%>
            <%--<tr>--%>
                <%--<th>직원타입</th>--%>
                <%--<th>직책</th>--%>
                <%--<th>직원명</th>--%>
                <%--<th>직원핸드폰번호</th>--%>
               <%--<!-- <th>생년월일</th>-->--%>
               <%--<!-- <th>주소</th>-->--%>
                <%--<th>이메일</th>--%>
                <%--<th>소속부서</th>--%>
                <%--<th>소속팀</th>--%>
               <%--<!-- <th>성범죄경력조회 확인일자</th>--%>
                <%--<th>교육청 강사등록일자</th>-->--%>
                <%--<th>수정</th>--%>
            <%--</tr>--%>
            <%--</thead>--%>
            <%--<tbody id="dataList"></tbody>--%>
            <%--<tr>--%>
                <%--<td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>--%>
            <%--</tr>--%>
        <%--</table>--%>
    <%--<%@ include file="/common/inc/com_pageNavi.inc" %>--%>
    <%--</div>--%>
    </form>
</section>
</body>
</html>
<script>
    $(".sidebar-menu > li").eq(5).addClass("active");
    $(".sidebar-menu > li:nth-child(6) > ul > li:nth-child(1) > a").addClass("on");
</script>