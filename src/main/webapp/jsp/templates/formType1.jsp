<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 0;
    int depth2 = 0;
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
            <h3 class="title_t1">Form Type1</h3>
            <form class="form_st1" name="frm" method="get">
                <input type="hidden" name="page_gbn" id="page_gbn">
                <div class="form-group row">
                    <label>학생사진</label>
                    <div>
                        <label class="custom-file">
                            <input type="file" id="file" class="custom-file-input" required>
                            <span class="custom-file-control"></span>
                        </label>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="">학생이름<b>*</b></label>
                    <div><input type="text" class="form-control" id=""></div>
                </div>
                <div class="form-outer-group">
                    <div class="form-group row">
                        <label for="">성별<b>*</b></label>
                        <div>
                            <div class="checkbox_t1">
                                <label><input type="radio" name="gender" value="1" checked><span>남자</span></label>
                                <label><input type="radio" name="gender" value="2"><span>여자</span></label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="">생일<b>*</b></label>
                        <div><input type="text" class="form-control date-picker"></div>
                    </div>
                </div>
                <div class="form-outer-group">
                    <div class="form-group row">
                        <label for="">핸드폰번호</label>
                        <div class="inputs">
                            <input type="text" size="2" id="student_phone1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.student_phone2,3)">&nbsp;-&nbsp;
                            <input type="text" size="5" id="student_phone2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.student_phone3,4)">&nbsp;-&nbsp;
                            <input type="text" size="5" id="student_phone3" class="form-control" maxlength="4">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="">집전화번호</label>
                        <div class="inputs">
                            <input type="text" size="2" id="student_tel1" class="form-control" maxlength="3" onkeyup="js_tab_order(this,frm.student_tel2,3)">&nbsp;-&nbsp;
                            <input type="text" size="5" id="student_tel2" class="form-control" maxlength="4" onkeyup="js_tab_order(this,frm.student_tel3,4)">&nbsp;-&nbsp;
                            <input type="text" size="5" id="student_tel3" class="form-control" maxlength="4">
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="">이메일</label>
                    <div><input type="email" class="form-control datepicker" id="student_email"></div>
                </div>
                <div class="form-outer-group">
                    <div class="form-group row">
                        <label>학교구분</label>
                        <div class="checkbox_t1">
                            <label><input type="radio" name="school_type" class="form-control" value="elem_list" checked><span>초등학교</span></label>
                            <label><input type="radio" name="school_type" class="form-control" value="midd_list"><span>중학교</span></label>
                            <label><input type="radio" name="school_type" class="form-control" value="high_list"><span>고등학교</span></label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label>학교이름</label>
                        <div><input type="text" class="form-control" id=""></div>
                    </div>
                    <div class="form-group row">
                        <label>학년</label>
                        <div>
                            <select class="form-control">
                                <% for(int i = 1 ; i < 7; i++) {%>
                                <option value="<%=i%>"><%=i%>학년</option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label>메모</label>
                    <div><textarea class="form-control"  rows="5"></textarea></div>
                </div>
                <div class="form-outer-group">
                    <div class="form-group row">
                        <label for="">학부모(모)이름<b>*</b></label>
                        <div><input type="text" class="form-control" id=""></div>
                    </div>
                    <div class="form-group row">
                        <label for="">학부모(모)전화번호<b>*</b></label>
                        <div class="inputs">
                            <input type="text" size="2" id="" class="form-control" maxlength="3">&nbsp;-&nbsp;
                            <input type="text" size="5" id="" class="form-control" maxlength="4">&nbsp;-&nbsp;
                            <input type="text" size="5" id="" class="form-control" maxlength="4">
                        </div>
                    </div>
                </div>
                <div class="form-outer-group">
                    <div class="form-group row">
                        <label for="">학부모(부)이름</label>
                        <div><input type="text" class="form-control" id=""></div>
                    </div>
                    <div class="form-group row">
                        <label for="">학부모(부)전화번호</label>
                        <div class="inputs">
                            <input type="text" size="2" id="" class="form-control" maxlength="3">&nbsp;-&nbsp;
                            <input type="text" size="5" id="" class="form-control" maxlength="4">&nbsp;-&nbsp;
                            <input type="text" size="5" id="" class="form-control" maxlength="4">
                        </div>
                    </div>
                </div>
                <div class="bot_btns">
                    <button class="btn_pack blue s2">저장</button>
                </div>
            </form>
        </section>
    </div>
<%@include file="/common/jsp/footer.jsp" %>
</body>