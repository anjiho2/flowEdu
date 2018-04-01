//형제 추가
function brotherAdd(){
    var brotherLimit = 5,
        $brotherInput = $('.cont-wrap .brother .brother-input');

    if($brotherInput.find('.form-control').length < brotherLimit){
        var len = $("#addNewBrotherLen").val();
        if (len == "") len = 1;

        $brotherInput.append("<input type='text' class='form-control' id='new_cur_"+ len +"' name='studentInfo[]' value='' onclick='student_search_popup(this);'>");
        $brotherInput.append('<input type="hidden" id="" name="addBrotherId[]">');

        innerValue("addNewBrotherLen", ++len);
    } else {
        alert('더 이상 추가할 수 없습니다.');
    }
}


//강의신청 레이어팝업
function lecture_apply_popup(){
    initPopup($("#lecture_apply_layer"));
}