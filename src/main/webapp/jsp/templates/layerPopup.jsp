<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int depth1 = 6;
    int depth2 = 5;
%>
<%@include file="/common/jsp/top.jsp" %>
<%@include file="/common/jsp/header.jsp" %>
    <div class="container">
        <%@include file="/common/jsp/titleArea.jsp" %>
        <%@include file="/common/jsp/depth_menu.jsp" %>
            </div>
        </section>
        <section class="content">
            <h3 class="title_t1">Layer Popup</h3>
            <div class="btns">
                <button class="btn_pack purple" id="popup1">기본 팝업</button>
                <button class="btn_pack green" id="popup2">팝업 옵션추가</button>
                <button class="btn_pack yellow" id="popup3">XHR 비동기 팝업</button>
            </div>
        </section>
    </div>
    <div class="layer_popup_template apt_request_layer" id="test_layer" style="display: none;">
        <div class="layer-title">
            <h3>레이어팝업 타이틀</h3>
            <button class="fa fa-close btn-close"></button>
        </div>
        <div class="layer-body">
            <div class="cont">
                <form class="form_st1" name="frm" method="get">
                    <div class="form-group"><div><input type="text" class="form-control" id="" placeholder="이름"></div></div>
                    <div class="form-group"><div><input type="email" class="form-control" id="" placeholder="이메일"></div></div>
                </form>
            </div>
            <div class="bot_btns_t1">
                <button class="btn_pack btn-close">취소</button>
                <button class="btn_pack blue">확인</button>
            </div>
        </div>
    </div>
<script>
    $("#popup1").on('click', function(){
        initPopup($("#test_layer"));
    });
    $("#popup2").on('click', function(){
        initPopup($("#test_layer"), {
            onStart : function(t){alert('시작')}, //팝업 시작할때 실행되는 함수, 인자는 layer엘리먼트
            onClose : function(t){alert('닫힘 완료')}, //팝업 닫히고 나서 실행되는 팝업, 인자는 layer엘리먼트
            onLoad : function(t){alert('열림 완료')}, //팝업이 뜨고 나서 실행되는 팝업, 인자는 layer엘리먼트
            btnCloseCl : 'btn-close', //닫기버튼으로 사용할 엘리먼트의 클래스
            bgEle : '.bg-layer', //백그라운드로 사용할 div 엘리먼트의 클래스
            resize : true, //리사이즈에 반응할 것인지
            htmlOverHide: true, //html엘리먼트에 overflow:hidden을 줄것인지
            setScroll: true, //레이어 팝업 스크롤 설정
            showAfterImgLoad: false, //팝업내에 이미지를 로딩 한 후 팝업을 띄울것인지
            hideByKey: true, //esc버튼으로 팝업 닫히도록 할것인지
            hideByClickBg: true //백그라운드를 클릭했을때 팝업이 닫히게 할것인지
        });
    });
    $("#popup3").on('click', function(){
        initAjaxPopup({
            url : '/flowEdu/template.do?page_gbn=layer'
        });
    });
</script>
<%@include file="/common/jsp/footer.jsp" %>