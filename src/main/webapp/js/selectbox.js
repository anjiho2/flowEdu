function memberTypeSelectbox(tag_id, val) {
	memberService.getMemberType(function(list) {
		var html = "<select id='sel_memberType'>";
		html += "<option value=''>▶선택</option>";
		for (var i=0; i<list.length; i++) {
			if (list[i].memberTypeCode == val) {
				html += "<option value="+list[i].memberTypeCode+" selected>"+ list[i].memberTypeName +"</option>";
			} else {
                html += "<option value="+list[i].memberTypeCode+">"+ list[i].memberTypeName +"</option>";
			}
		}
		html += "</select>";
		innerHTML(tag_id, html);
    });
}

function jobPositionSelectbox(tag_id, val) { //직책 리스트
    memberService.getJobPositionList(function(list) {
        var html = "<select id='sel_jobPosition'>";
        html += "<option value=''>▶선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].jobPositionId == val) {
                html += "<option value="+list[i].jobPositionId+" selected>"+ list[i].jobPositionName +"</option>";
            } else {
                html += "<option value="+list[i].jobPositionId+">"+ list[i].jobPositionName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

function academyListSelectbox(tag_id, val) { //소속부서(학원)리스트
    academyService.getAcademyList(function(list) {
        var html = "<select id='sel_academyList'>";
        html += "<option value=''>▶선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].officeId == val) {
                html += "<option value="+list[i].officeId+" selected>"+ list[i].officeName +"</option>";
            } else {
                html += "<option value="+list[i].officeId+">"+ list[i].officeName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

function academyListSelectbox2(tag_id, val) { //소속부서(학원)리스트
    academyService.getAcademyList(function(list) {
        var html = "<select id='sel_academyList2' onchange='academy_sel_change(this.value);' >";
        html += "<option value=''>▶선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].officeId == val) {
                html += "<option value="+list[i].officeId+" selected>"+ list[i].officeName +"</option>";
            } else {
                html += "<option value="+list[i].officeId+">"+ list[i].officeName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

function flowEduTeamListSelectbox(tag_id, val) { //소속팀 리스트
    memberService.getFlowEduTeamList(function(list) {
        var html = "<select id='sel_FlowEduTeamList'>";
        html += "<option value=''>▶선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].teamId == val) {
                html += "<option value="+list[i].teamId+" selected>"+ list[i].teamName +"</option>";
            } else {
                html += "<option value="+list[i].teamId+">"+ list[i].teamName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

/**
 * 요일 셀렉트 박스 (월, 화, 수, 목, 금, 토, 일)
 * @param tag_id
 * @param val
 */
function lectureDaySelectbox(tag_id, val) {
	lectureService.getLectureDayList(function (list) {
		var html = "<select id='sel_lectureDayList' name='lecture_day[]'>";
		html += "<option value=''>▶요일선택</option>";
		for (var i=0; i<list.length; i++) {
			if (list[i].dayCode == val) {
				html += "<option value="+list[i].dayCode+" selected>"+ list[i].dayName +"</option>";
			} else {
                html += "<option value="+list[i].dayCode+">"+ list[i].dayName +"</option>";
			}
		}
		html += "</select>";
		innerHTML(tag_id, html);
    });
}

/**
 * 강의 상태 셀렉트 박스(개강, 휴강, 폐강)
 * @param tag_id
 * @param val
 */
function lectureStatusSelectbox(tag_id, val) {
    lectureService.getLectureStatusList(function (list) {
        var html = "<select id='sel_lectureStatusList'>";
        html += "<option value=''>▶강의상태선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].statusCode == val) {
                html += "<option value="+list[i].statusCode+" selected>"+ list[i].statusName +"</option>";
            } else {
                html += "<option value="+list[i].statusCode+">"+ list[i].statusName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

/**
 * 강의 운영 형태 선텍 셀렉트 박스(월, 횟수)
 * @param tag_id
 * @param val
 */
function lectureOperationTypeSelectbox(tag_id, val) {
    lectureService.getLectureOperationTypeList(function (list) {
        var html = "<select id='sel_lectureOperationTypeList'>";
        html += "<option value=''>▶운영형태선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].operationTypeCode == val) {
                html += "<option value="+list[i].operationTypeCode+" selected>"+ list[i].operationTypeName +"</option>";
            } else {
                html += "<option value="+list[i].operationTypeCode+">"+ list[i].operationTypeName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

/**
 * 강의 인원수 선택 셀렉트 박스(limitCount로 인원수 설정)
 * @param tag_id
 * @param val
 * @param limitCount
 */
function lectureStudentLimitSelectbox(tag_id, val, limitCount) {
    var html = "<select id='sel_lectureStudentLimitList'>";
    html += "<option value=''>▶인원수선택</option>";
    for (var i=1; i<=limitCount; i++) {
        if (i == val) {
            html += "<option value="+ i +" selected>"+ i +"명</option>";
        } else {
            html += "<option value="+ i +">"+ i +"명</option>";
        }
    }
    html += "</select>";
    innerHTML(tag_id, html);
}

/**
 * 관 선택에 따른 선생님 셀렉트 박
 * @param office_id
 * @param tag_id
 * @param val
 */
function teacherList(office_id, tag_id, val) {
    memberService.getTeacherList(office_id, function (list) {
        var html = "<select id='sel_teacherList'>";
        html += "<option value=''>▶선생님선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].flowMemberId == val) {
                html += "<option value="+list[i].flowMemberId+" selected>"+ list[i].memberName +"</option>";
            } else {
                html += "<option value="+list[i].flowMemberId+">"+ list[i].memberName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

function teacherList2(office_id, tag_id, val) {
    memberService.getTeacherList(office_id, function (list) {
        var html = "<select id='sel_teacherList2'>";
        html += "<option value=''>▶선생님선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].flowMemberId == val) {
                html += "<option value="+list[i].flowMemberId+" selected>"+ list[i].memberName +"</option>";
            } else {
                html += "<option value="+list[i].flowMemberId+">"+ list[i].memberName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

/**
 * 강의 과목 셀렉트 박스
 * @param tag_id
 * @param val
 */
function lectureSubjectSelectbox(tag_id, val) {
    lectureService.getLectureSubjectList(function (list) {
        var html = "<select id='sel_lectureSubject'>";
        html += "<option value=''>▶과목선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].subjectCode == val) {
                html += "<option value="+list[i].subjectCode+" selected>"+ list[i].subjectName +"</option>";
            } else {
                html += "<option value="+list[i].subjectCode+">"+ list[i].subjectName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

/**
 * 강의 가격 셀렉트 박스
 * @param tag_id
 * @param val
 */
function lecturePriceSelectbox(tag_id, val) {
    lectureService.getLecturePriceList(function (list) {
        var html = "<select id='sel_lecturePrice'>";
        html += "<option value=''>▶가격선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].lecturePriceId == val) {
                html += "<option value="+list[i].lecturePriceId+" selected>"+ addThousandSeparatorCommas(list[i].lecturePrice) +"원</option>";
            } else {
                html += "<option value="+list[i].lecturePriceId+">"+ addThousandSeparatorCommas(list[i].lecturePrice) +"원</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

function lectureRoomSelectbox(office_id, tag_id, val) {
    lectureService.getLectureRoomList(office_id, function (list) {
        var html = "<select id='sel_lectureRoom' name='sel_lectureRoom[]'>";
        html += "<option value=''>▶강의실선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].lectureRoomId == val) {
                html += "<option value="+list[i].lectureRoomId+" selected>"+ list[i].lectureRoomName +"</option>";
            } else {
                html += "<option value="+list[i].lectureRoomId+">"+ list[i].lectureRoomName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

/**
 * <PRE>
 * 1. Comment : 년도 선택 셀렉트 박스.
 * 2. 작성자 : 안지호
 * 3. 작성일 : 2016. 04. 20
 * </PRE>
 * @param tagValue
 * @param onChangeValue
 */
function yearSelectBox(tagValue, onChangeValue, showDiv, selectValue) {
	if (showDiv != "") {
		$("#"+showDiv).show();
	}
	selHTML = "<select class='select' id='sel_year' onChange='"+onChangeValue+"'>";
	selHTML+= "<option value=''>▶년도선택</option>";
	for (var i = 2016; i <= 2020; i++) {
		if (i == selectValue) {
			selHTML+= "<option value="+i+" selected>"+i+"년</option>";
		} else {
			selHTML+= "<option value="+i+">"+i+"년</option>";	
		}
	}
	selHTML+= "</select>";
	$("#"+tagValue).html(selHTML);
}

/**
 * <PRE>
 * 1. Comment : 주차 선택 셀렉트 박스.
 * 2. 작성자 : 안지호
 * 3. 작성일 : 2016. 04. 20
 * </PRE>
 * @param tagName
 * @param showDiv
 */
function weekSelectBox(tagName, showDiv) {
	if (showDiv != "") {
		$("#"+showDiv).show();
	}
	selHTML = "<select class='select' id='sel_week'>";
	selHTML+= "<option value=''>▶주차선택</option>";
	for (var i = 1; i <= 53; i++) {
		selHTML+= "<option value="+i+">"+i+"주차</option>";
	}
	selHTML+= "</select>";
	$("#"+tagName).html(selHTML);
}

/**
 * <PRE>
 * 1. Comment : 월 선택 셀렉트 박스.
 * 2. 작성자 : 안지호
 * 3. 작성일 : 2016. 04. 20
 * </PRE>
 * @param tagValue
 */
function monthSelectBox(tagValue, month) {
	selHTML = "<select class='select' id='sel_month'>";
	selHTML+= "<option value=''>▶월선택</option>";
	for (var i = 1; i <= 12; i++) {
		if (month == i) {
			selHTML+= "<option value="+i+" selected>"+i+"월</option>";	
		} else {
			selHTML+= "<option value="+i+">"+i+"월</option>";
		}
	}
	selHTML+= "</select>";
	$("#"+tagValue).html(selHTML);
}

/**
 * <PRE>
 * 1. Comment : 기기종류 셀렉트 박스(애플, 안드로이드).
 * 2. 작성자 : 안지호
 * 3. 작성일 : 2016. 04. 20
 * </PRE>
 * @param tagName
 * @param type
 */
function deviceTypeSelectBox(tagName, type) {
	var selectHTML = "<select class='select' id='sel_deviceType' onChange='javascript:goDeviceType()';>";
	selectHTML+= "<option value=''>▶기기선택</option>";
	
	if (type == "ANDROID") {
		selectHTML+= "<option value='IOS'>애플</option>";
		selectHTML+= "<option value='ANDROID' selected>안드로이드</option>";
	} else if (type == "IOS") {
		selectHTML+= "<option value='IOS' selected>애플</option>";
		selectHTML+= "<option value='ANDROID'>안드로이드</option>";
	} else {
		selectHTML+= "<option value='IOS'>애플</option>";
		selectHTML+= "<option value='ANDROID'>안드로이드</option>";
	}
	selectHTML+= "</select>";
	$("#"+tagName).html(selectHTML);
}

/**
 * 24시간 셀렉트 박스
 * @param hour
 * @param tagName
 */
function hourSelectbox(hour, tagName) {
	var selectbox = "<select class='select width-small' id='sel_hour'>";
	selectbox+= "<option value=''>▶시간선택</option>";
	for (var i = 0; i <= 24; i++) {
		if (hour == i) {
			selectbox+= "<option value='"+hour+"' selected>"+hour+"시간</option>";
		} else {
			selectbox+= "<option value='"+i+"'>"+i+"시간</option>";	
		}
	}
	selectbox+= "</select>";
	$("#"+tagName).html(selectbox);
}

/**
 * 0분~ 59분 셀렉트 박스
 * @param minute
 * @param tagName
 */
function minuteSelectbox(minute, tagName) {
	var selectbox = "<select class='select width-small' id='sel_minute'>";
	selectbox += "<option value=''>▶분선택</option>";
	for (var i = 0; i <= 59; i++) {
		if (minute == i) {
			selectbox+= "<option value='"+minute+"' selected>"+minute+"분</option>";
		} else {
			selectbox+= "<option value='"+i+"'>"+i+"분</option>";	
		}
	}
	selectbox+= "</select>";
	$("#"+tagName).html(selectbox);
}

function pagingListSelectbox(val, tagName) {
	var selectbox = "<select class='select_small' id='sel_pagingCnt' onChange='javascript:fn_search("+ '"'+"new"+'"'+");'>";
	for (var i=10; i<=40; i+=10) {
		if (i == val) {
			selectbox += "<option value='"+i+"' selected>"+ i +"</option>";	
		} else {
			selectbox += "<option value='"+i+"' >"+ i +"</option>";	
		}
	}
	selectbox += "</select>";
	$("#"+tagName).html(selectbox);
}

function pagingListSelectbox2(val, tagName) {
	var selectbox = "<select class='select_small' id='sel_pagingCnt2' onChange='javascript:fn_search2("+ '"'+"new"+'"'+");'>";
	for (var i=10; i<=40; i+=10) {
		if (i == val) {
			selectbox += "<option value='"+i+"' selected>"+ i +"</option>";	
		} else {
			selectbox += "<option value='"+i+"' >"+ i +"</option>";	
		}
	}
	selectbox += "</select>";
	$("#"+tagName).html(selectbox);
}

function pagingListSelectbox3(val, tagName) {
	var selectbox = "<select class='select_small' id='sel_pagingCnt3' onChange='javascript:fn_search3("+ '"'+"new"+'"'+");'>";
	for (var i=10; i<=40; i+=10) {
		if (i == val) {
			selectbox += "<option value='"+i+"' selected>"+ i +"</option>";	
		} else {
			selectbox += "<option value='"+i+"' >"+ i +"</option>";	
		}
	}
	selectbox += "</select>";
	$("#"+tagName).html(selectbox);
}

function pagingListSelectbox4(val, tagName) {
	var selectbox = "<select class='select_small' id='sel_pagingCnt4' onChange='javascript:fn_search4("+ '"'+"new"+'"'+");'>";
	for (var i=10; i<=40; i+=10) {
		if (i == val) {
			selectbox += "<option value='"+i+"' selected>"+ i +"</option>";	
		} else {
			selectbox += "<option value='"+i+"' >"+ i +"</option>";	
		}
	}
	selectbox += "</select>";
	$("#"+tagName).html(selectbox);
}

//학교구분별 학년 셀렉트박스
function schoolSelectbox(tag_id, val, school_grade) {
	var count = 0;
    var html = "<select id='sel_school'>";
    html += "<option value=''>▶선택</option>";
    //초등(6)
	if(school_grade == "elem_list" ){
		count = 6;
	}else{	//중,고등(3)
		count = 3;
	}
	for (var i=1; i<count+1; i++) {
		if (i == val) {
			html += "<option value="+ i +" selected>"+ i +"학년</option>";
		} else {
            html += "<option value="+ i +">"+ i +"학년</option>";
		}
	}
	html += "</select>";
	innerHTML(tag_id, html);

}