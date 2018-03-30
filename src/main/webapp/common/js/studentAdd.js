//형제 추가
function brotherAdd(){
    var brotherLimit = 5,
        $brotherInput = $('.cont-wrap .brother .brother-input');

    if($brotherInput.find('.form-control').length < brotherLimit){
        $brotherInput.append('<input type="text" class="form-control add-input" id="">');
    } else {
        alert('더 이상 추가할 수 없습니다.');
    }
}


//강의신청 레이어팝업
function lecture_apply_popup(){
    initPopup($("#lecture_apply_layer"));
}