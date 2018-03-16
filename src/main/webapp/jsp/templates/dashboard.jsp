<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 6;
    int depth2 = 1;
%>
<%@include file="/common/jsp/top.jsp" %>
<script>
    $(document).ready(function () {
        var isChange = false;

        $("input, select").change(function () {
            isChange = true;
        });
        $(window).on("beforeunload", function () {
            if (isChange) {
                return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
            }
        });
        $("#btn1").click(function(){
            isChange = false;
        });
    });

    function test() {

    }
</script>
<%@include file="/common/jsp/header.jsp" %>
    <div class="container">
        <%@include file="/common/jsp/titleArea.jsp" %>
        <%@include file="/common/jsp/depth_menu.jsp" %>
    </div>
</section>
    <section class="content">
        <h3 class="title_t1">DashBoard</h3>
        <div class="layout_dashboard">
            <section>
                <div class="in">
                    <div class="top">
                        <h3><span class="fa fa-address-card"></span>기본정보</h3>
                        <div class="form-group row">
                            <label>학생</label>
                            <div class="flex">
                                <input type="text" class="form-control underline my_name" placeholder="이름" style="flex:3" id="sutentName" value="홍길동">
                                <input type="text" class="form-control underline" id="" placeholder="전화번호" style="flex:5" value="010-1234-1234">
                                <button class="btn_pack white fa fa-check" id="btn1"></button>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label>부모</label>
                            <div class="flex">
                                <input type="text" class="form-control underline" id="" placeholder="이름" style="flex:3" value="길동맘">
                                <input type="text" class="form-control underline" id="" placeholder="전화번호" style="flex:5" value="010-1234-1234">
                                <button class="btn_pack white fa fa-check"></button>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label>학교/학년</label>
                            <div class="flex">
                                <input type="text" class="form-control underline" id="" placeholder="학교" value="수내초등학교" style="flex:3">
                                <select type="text" class="form-control underline" id="" placeholder="학년" value="3학년" style="flex:2">
                                    <option value="">1학년</option>
                                    <option value="">2학년</option>
                                    <option value="">3학년</option>
                                </select>
                                    <button class="btn_pack white fa fa-check"></button>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label>메모</label>
                            <div class="flex"><textarea class="form-control underline" id="메모를 입력해주세요." >메모입니다</textarea> <button class="btn_pack white fa fa-check"></button></div>
                        </div>
                    </div>
                    <div class="bot">
                        <button class="btn_pack blue" id="basic-info-more">더보기</button> <button class="btn_pack blue">신규 + </button>
                    </div>
                </div>
            </section>
            <section>
                <div class="in">
                    <div class="top">
                        <h3><span class="fa fa-address-card"></span>수강정보</h3>
                        <div class="tb_t1">
                            <table class="class_list">
                                <tbody>
                                    <tr>
                                        <td>[월수금]ABC-a</td>
                                        <td>완철쌤</td>
                                        <td>월수금</td>
                                        <td>19:30</td>
                                        <td><button class="fa fa-search "></button></td>
                                    </tr>
                                    <tr>
                                        <td>[월수금]ABC-a</td>
                                        <td>완철쌤</td>
                                        <td>월수금</td>
                                        <td>19:30</td>
                                        <td><button class="fa fa-search "></button></td>
                                    </tr>
                                    <tr>
                                        <td>[월수금]ABC-a</td>
                                        <td>완철쌤</td>
                                        <td>월수금</td>
                                        <td>19:30</td>
                                        <td><button class="fa fa-search "></button></td>
                                    </tr>
                                    <tr style="text-align: right;">
                                        <td colspan="5" style="border-bottom: 0;">...외 5개 강좌 더 수강중입니다.</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="bot">
                        <button class="btn_pack blue" id="basic-info-more">수강이력</button>
                        <button class="btn_pack blue" id="basic-info-more">수강등록</button>
                    </div>
                </div>
            </section>
            <section>
                <div class="in">
                    <div class="top">
                        <h3><span class="fa fa-address-card"></span>수납정보</h3>
                        <div class="tb_t1 price">
                            <h4>700,000<small>미납금액</small></h4>
                            <table>
                                <tbody>
                                <tr>
                                    <td>[월수금]ABC-a</td>
                                    <td>340,000</td>
                                    <td>340,000</td>
                                    <td><button class="fa fa-credit-card"></button></td>
                                </tr>
                                <tr>
                                    <td>[월수금]ABC-a</td>
                                    <td>240,000</td>
                                    <td>240,000</td>
                                    <td><button class="fa fa-credit-card"></button></td>
                                </tr>
                                <tr>
                                    <td>[월수금]ABC-a</td>
                                    <td>240,000</td>
                                    <td>120,000</td>
                                    <td><button class="fa fa-credit-card"></button></td>
                                </tr>
                                <tr style="text-align: right;">
                                    <td colspan="5" style="border-bottom: 0;">...외 5개 미납 항목이 있습니다.</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="bot">
                        <button class="btn_pack blue" id="basic-info-more">납입이력</button>
                        <button class="btn_pack blue" id="basic-info-more">전체납부</button>
                    </div>
                </div>
            </section>
            <section>
                <div class="in">
                    <div class="top">
                        <h3><span class="fa fa-address-card"></span>상담정보</h3>
                        <ul class="list_t2 checkbox_t2">
                            <li>
                                <label><input type="checkbox"><span class="fa fa-check"></span></label>
                                <div>
                                    <p>학생이 학원버스를 놓쳐서 학부모님에게 연락이 왔습니다. 기사분께 연락드려서 확인해야 합니다.</p>
                                    <h4><span><i class="tag">일반</i>홍길동 실장</span> <em>2017-09-24 18:49:41</em></h4>
                                </div>
                            </li>
                            <li>
                                <label><input type="checkbox" checked><span class="fa fa-check"></span></label>
                                <div>
                                    <p>학생이 학원버스를 놓쳐서 학부모님에게 연락이 왔습니다. 기사분께 연락드려서 확인 해야 합니다.</p>
                                    <h4><span><i class="tag">일반</i>홍길동 실장</span> <em>2017-09-24 18:49:41</em></h4>
                                </div>
                            </li>
                            <li>
                                <label><input type="checkbox" checked><span class="fa fa-check"></span></label>
                                <div>
                                    <p>학생이 학원버스를 놓쳐서 학부모님에게 연락이 왔습니다. 기사분께 연락드려서 확인 해야 합니다.</p>
                                    <h4><span><i class="tag">일반</i>홍길동 실장</span> <em>2017-09-24 18:49:41</em></h4>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="bot">
                        <button class="btn_pack blue" id="basic-info-more">상담이력</button>
                        <button class="btn_pack blue" id="basic-info-more">상담등록</button>
                    </div>
                </div>
            </section>
        </div>
    </section>

    </div>
<script>
    $('#basic-info-more').on('click', function(){
        initAjaxPopup({
            url : '/flowEdu/template.do?page_gbn=layer'
        },{
            hideByClickBg: false
        });
    })
</script>
<%@include file="/common/jsp/footer.jsp" %>