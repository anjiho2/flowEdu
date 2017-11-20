/** 결제관련 값 변경 스크립트 파일 **/

function transInstallMent(installMent, authType) {
    var str = "";
    if (authType == "D1") {
        if (installMent == "00") str = "일시불";
        else str = installMent + "개월";
    } else if (authType == "CC") {
        if (installMent == "01") str = "법인";
        else str = "개인";
    } else {
        str = "취소건";
    }
    return str;
}

function transAuthType(authType) {
	var str = "";
	if (authType == "D1") {
		str = "신용승인";
	} else if (authType == "D2") {
        str = "신용취소";
	} else if (authType == "CC") {
        str = "현금영수증승인";
	} else if (authType == "CR") {
        str = "현금영수증취소";
	}
	return str;
}


function getPaymentType(authType) {
    var str = "";
    if (authType == "D1" || authType == "D2") {
        str = "신용카드";
    } else if (authType == "CC" || authType == "CR") {
        str = "현금";
    }
    return str;
}