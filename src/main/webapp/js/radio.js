/**
 * 강의 레벨 선택 라디오 박스
 * @param tag_id
 * @param val
 * @param on_click
 */
function lectureLevelRadio(tag_id, val, on_click) {
    lectureService.getLectureLevelList(function (list) {
    	var html = "";
    	var check = "";
        for (var i=0; i<list.length; i++) {
            if (list[i].levelCode == val) {
				check = "checked"
            } else {
				check = "";
            }
            html += "<input type='radio' name='lecture_level' value=" + list[i].levelCode + " onclick=" + "'" + on_click + "'" + check + ">" + list[i].levelName;
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}