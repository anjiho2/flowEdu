
function getContextPath() {
	 var offset=location.href.indexOf(location.host)+location.host.length;
	var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
	return ctxPath;
}

function goHome() {
	location.href= getContextPath();
}

function goUser(page_value, val1) {
	var selValue = getSelectboxValue("sel_searchType");
	with(document.frm) { 
		if (page_value != "") 	
			page_gbn.value = page_value;
		
			if (page_value == "detail" || page_value == "modify") {
				user_id.value = val1;
			}
			if (selValue == undefined) selValue = "";
			if (selValue != "") {
				search_type.value = selValue;		
			}
		action = getContextPath()+"/user.do";
		submit();
	} 
}
 
function excelDownload(url) {
	if (confirm("전체리스트의 엑셀표를 다운받으시겠습니까?")) {
		with (document.frm) {
			action = getContextPath() + "/" + url;
			submit();
		}
	}
}

function goUserDetail(page_value) {
	with(document.frm) {
		if (page_value != "")
			page_gbn.value = page_value;
		action = getContextPath()+"/user.do";
		submit();
	}
}

function goLogout() {
	if (confirm("로그아웃 하시겠습니까?")) {
		with(document.frm) {
			page_gbn.value = "logout";
			action = getContextPath()+"/login.do";
			submit();
		} 
	}
}

function goPage(mapping_value, page_value) {
	with(document.frm) {
		if (mapping_value != "" && page_value != "") {
			page_gbn.value = page_value;
		}
		action = getContextPath()+"/"+mapping_value+".do";
		submit();
	}
}

function lecture_go(val) {
    if(val=="price"){
        goPage('lecture','lecture_price');
    }else if(val=="room"){
        goPage('lecture','lecture_room');
    }else if(val=="lecture_list"){
        goPage('lecture','lecture_list');
	}
}