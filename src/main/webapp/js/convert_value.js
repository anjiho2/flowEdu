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
	if ("HIGH") {
		str = "상";
	} else if ("MIDDLE") {
        str = "중";
	}  else if ("LOW") {
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
    if ("OPEN") {
        str = "개강";
    } else if ("CANCEL") {
        str = "휴강";
    }  else if ("CLOSE") {
        str = "폐강";
    }
    return str;
}