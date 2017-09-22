function convert_school(val) {
	var str = "";
	if (val == "elem_list") {
		str = "초등학교";
	} else if (val == "midd_list") {
        str = "중학교";
	} else if (val == "high_list") {
        str = "고등학교";
	}
	return str;
}

function convert_lecture_subject(val) {
	var str = "";
    switch (val) {
		case "KOREAN":
			str = "국어";
			break;
        case "ENGLISH":
            str = "영어";
            break;
        case "MATH":
            str = "수학";
            break;
        case "SCIENCE":
            str = "과학";
            break;
        case "SCIENCE":
            str = "소프트웨어";
            break;
	}
	return str;
}

function convert_lecture_level(val) {
	var str = "";
	if (val == "HIGH") {
		str = "상";
	} else if (val == "MIDDLE") {
        str = "중";
	}  else if (val == "LOW") {
        str = "하";
    }
    return str;
}

function convert_lecture_grade(val) {
	if (val != "") {
		val += "학년";
	}
	return val;
}

function convert_lecture_status(val) {
    var str = "";
    if (val == "OPEN") {
        str = "개강";
    } else if (val == "CANCEL") {
        str = "휴강";
    }  else if (val == "CLOSE") {
        str = "폐강";
    }
    return str;
}

function convert_attend(val) {
    var str = "";
    if(val == "ATTEND") str ="출석";
    else if(val == "LATE") str = "지각";
    else if(val == "ABSENT") str = "결석";

    return str;
}


function convert_memberType(val) {
    var str = "";
    if(val == "OPERATOR") str ="운영자";
    else if(val == "TEACHER") str = "담임선생님";
    else if(val == "TEACHER_MANAGE") str = "관리선생님";
    else if(val == "ADMIN") str = "관리자";

    return str;
}

function convert_memo_type(val) {
    var str = "";
    if(val == "REG") str ="등록";
    else if(val == "NORAML") str = "일반";
    else if(val == "STUDY") str = "학습";
    else if(val == "PERIOD") str = "정기";

    return str;
}

function convert_day(val) {
    var str = "";
    switch (val) {
        case "MON":
            str = "월요일";
            break;
        case "TUE":
            str = "화요일";
            break;
        case "WEN":
            str = "수요일";
            break;
        case "THU":
            str = "목요일";
            break;
        case "FRI":
            str = "금요일";
            break;
        case "SAT":
            str = "토요일";
            break;
        case "SUN":
            str = "일요일";
            break;
    }
    return str;
}