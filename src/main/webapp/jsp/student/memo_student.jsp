<%@ page import="com.flowedu.util.Util" %>
<%@ page import="com.flowedu.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 2;
    int depth2 = 4;

    int siderMenuDepth1 = 1;
    int siderMenuDepth2 = 2;
    int siderMenuDepth3 = 1;

    Long student_id = Long.parseLong(request.getParameter("student_id"));
    String sPage = Util.isNullValue(request.getParameter("sPage"), "1");
    //String student_name = StringUtil.convertParmeterStr(request.getParameter("student_name"), "UTF-8");
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/studentService.js'></script>
<script>

    function init() {
        studentmemoTypeSelectbox("sel_memo_type","");//상담검색시
        //studentMemoTypeRadio("l_memoType", "REG", "");//상담입력시
        studentmemoTypeSelectbox2("sel_memo_type2","");//상담검색시
        fn_search("new");
    }

    function studentMemo(){//상담저장
        var check = new isCheck();
        var student_id  = getInputTextValue("student_id");
        var consultMemo = getInputTextValue("consultMemo");
        var memoType = getSelectboxValue("sel_memoType2");
        var consultTitle = getInputTextValue("consultTitle");

        if (check.selectbox("sel_memoType2", comment.select_consult_type) == false) return;
        if (check.input("consultTitle", "상담제목을 입력하세요.") == false) return;
        if (check.input("consultMemo", "상담내용을 입력하세요.") == false) return;


        studentService.saveStudentMemo(student_id, consultMemo, memoType, consultTitle, function () {
            alert("저장 하시겠습니까?");
            isReloadPage(true);
        });
    }

    //학생의 모든상담리스트
    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        var searchdate = getInputTextValue("startDate");
        var memoType = getInputTextValue("sel_memoType");
        var member_name = getInputTextValue("member_name");
        var memo_content = getInputTextValue("memo_content");
        var process_status = getSelectboxValue("sel_process_status");
        if(searchdate == undefined || memoType == undefined ||  member_name == undefined || memo_content == undefined){
            searchdate = "";
            memoType = "";
            member_name = "";
            memo_content = "";
        }
        if(val == "new") sPage = "1";
        gfn_emptyView("H", "");
        studentService.getStudentMemoListCount( <%=student_id%>, searchdate, memoType, member_name, memo_content, process_status, function(cnt) {
            paging.count(sPage, cnt, 10, 10, comment.not_consult_log);
            studentService.getStudentMemoList(sPage, 10, <%=student_id%>, searchdate, memoType, member_name, memo_content, process_status, function (selList) {
                if (selList.length > 0) {
                    dwr.util.removeAllRows("dataList");
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList == undefined) {
                        } else
                            var memoHTML = "<a href='javascript:void(0);' class='font_color blue'  onclick='go_reply("+ '"' + 'student' + '"' + ","+ '"' + 'detail_memo_student' + '"' + ","+ '"' + cmpList.studentMemoId + '"' + ");' />"+ ellipsis(cmpList.memoTitle, 20) +"</a>";
                            var cellData = [
                                //cmpList.memoContent;
                                function (data) {return memoHTML;},
                                function (data) {return cmpList.memberName;},
                                function (data) {return convert_memo_type(cmpList.memoType);},
                                function (data) {return getDateTimeSplitComma(cmpList.createDate);},
                                function (data) {return cmpList.processYn == false ?  "대기" : "처리완료";
                                }
                                //"<input type='button' value='처리하기' id=" + cmpList.studentMemoId + " onclick='changeProccessYn(this.id);'>"
                                //"<button class='btn_pack white' type='button' id="+cmpList.studentMemoId+" onclick='changeProccessYn(this.id);'>처리하기</button>"

                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                });
            });
        }

    // 처리하기 버튼
    function changeProccessYn(studentMemoId) {
        if (confirm("처리하시겠습니까?")) {
            studentService.modifyMemoProcessYn(studentMemoId, true);
            isReloadPage(true)
        }
    }

    //댓글 페이지 이동
    function go_reply(mapping_value, page_value, memo_id) {
        with(document.frm) {
            if (mapping_value != "" && page_value != "") {
                page_gbn.value = page_value;
                student_memo_id.value = memo_id;
            }
            action = getContextPath()+"/"+mapping_value+".do";
            submit();
        }
    }
</script>

<body onload="init();">
<div class="container">
    <%@include file="/common/jsp/titleArea.jsp" %>
    <%@include file="/common/jsp/student_depth_menu.jsp" %>
</div>
</section>
<section class="content detail">
    <form name="frm" method="get" class="form_st1">
        <input type="hidden" name="page_gbn" id="page_gbn">
        <input type="hidden" id="student_id" name="student_id" value="<%=student_id%>">
        <%--<input type="hidden" name="student_name" value="<%=UserSession.memberName()%>">--%>
        <input type="hidden"  id="sPage" value="<%=sPage%>">
        <input type="hidden" name="student_memo_id" id="student_memo_id">
    </form>
    <div class="cont-wrap">
        <div class="tb_t1 colTable searchInfo">
            <table>
                <colsgroup>
                    <col width="10%">
                    <col width="45%">
                    <col width="45%">
                </colsgroup>
                <tr>
                    <th>기간선택</th>
                    <td colspan="2">
                        <div class="date-select">
                            <div class="input-group date common">
                                <input type="text" id="startDate" class="form-control date-picker" placeholder="시작일">
                                <span class="input-group-addon" id="datepicker_img">
                                    <span class="fa fa-calendar"></span>
                                </span>
                            </div>
                        </div>
                        <div class="date-select">
                            <div class="input-group date common">
                                <input type="text" id="endDate" class="form-control date-picker" placeholder="종료일">
                                <span class="input-group-addon" id="datepicker_img2">
                                    <span class="fa fa-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>상담유형</th>
                    <td>
                        <div class="form-group">
                            <div class="search-box clear">
                                <select id="" class="form-control">
                                    <option value="">전체</option>
                                    <option value="">등록</option>
                                    <option value="">심층</option>
                                    <option value="">일반</option>
                                    <option value="">학습</option>
                                    <option value="">정기</option>
                                </select>
                            </div>
                        </div>
                    </td>
                    <td></td>
                </tr>
            </table>

            <button class="btn_pack blue" type="button" onclick="fn_search('new');">검색</button>
        </div>

        <h3 class="title_t1">학생 상담 목록</h3>
        <div class="tb_t1" style="margin-bottom:4rem">
            <table>
                <tr>
                    <th>상담날짜</th>
                    <td>
                        <%--<input type="text" id="monthpicker" class="form-control" placeholder="작성일" >--%>
                        <div class="input-group date">
                            <input type="text" id="startDate" class="form-control date-picker" style="" placeholder="상담일">
                            <span class="input-group-addon" id="datepicker_img">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </td>
                    <th>상담자</th>
                    <td><input type="text" id="member_name" class="form-control" placeholder="상담자" ></td>
                </tr>
                <tr>
                    <th>상담유형</th>
                    <td><span id="sel_memo_type" style="width: 100%"></span></td>
                    <th>처리상태</th>
                    <td>
                        <select id="sel_process_status" class="form-control">
                            <option value="">▶선택</option>
                            <option value="false">진행중</option>
                            <option value="true">처리완료</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>상담 제목+내용</th>
                    <td colspan="3"><input type="text" id="memo_content" class="form-control" placeholder="제목+내용"></td>
                </tr>
            </table>
            <button class="btn_pack blue" type="button" onclick="fn_search('new');" style="float:right;">검색</button>
        </div>
        <div class="tb_t1">
            <table>
                <colsgroup>
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="*" />
                    <col width="110">
                </colsgroup>
                <tr>
                    <th>상담제목</th>
                    <th>상담자</th>
                    <th>상담유형</th>
                    <th>상담날짜</th>
                    <th>처리상태</th>
                </tr>
                <tbody id="dataList"></tbody>
                <tr>
                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                </tr>
            </table>
            <div class="form-group row"></div>
            <%@ include file="/common/inc/com_pageNavi.inc" %>
        </div>
    </div>
</section>
<%@include file="/common/jsp/footer.jsp" %>
<script type='text/javascript' src="<%=webRoot%>/js/monthpicker.js"></script>
</body>