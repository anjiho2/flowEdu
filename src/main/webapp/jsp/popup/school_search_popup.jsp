<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/jsp/top.jsp" %>
<%
    String sch_type = Util.isNullValue(request.getParameter("school_type"),"");
%>

<script type='text/javascript' src='/flowEdu/dwr/interface/studentService.js'></script>
<script>
    var school_type = "<%=sch_type%>";
    function school_type_name() {
        var school_name;
        if(school_type == "elem_list"){
            school_name = "초등학교";
        }else if(school_type == "midd_list"){
            school_name = "중학교";
        }else{
            school_name = "고등학교";
        }
        innerHTML("l_school_name", school_name);
    }

    function school_search() {
        var region =  getSelectboxValue("inputregion");
        var searchSchoolName = getInputTextValue("schoo_name");
       if(region==""){
           alert("지역을 선택해 주세요.");
           return false;
       }else if(searchSchoolName == ""){
           alert("학교명을 입력해 주세요.");
           return false;
       }


        studentService.getApiSchoolName(school_type, region, searchSchoolName, function (schoolName) {
            if (schoolName == null) {
                alert("검색된 학교가 없습니다.")
                return;
            } else {
                window.opener.document.getElementById("schoolname").value = remove_double_quotation(schoolName);
                self.close();
            }
        });
    }

</script>
<body onload="school_type_name();">
<form>
    <tr>
        <th>학교구분</th>
        <td>
           [ <span id="l_school_name"></span> ]
        </td>
        <br>
        <th>지역</th>
        <td>
            <select title="선택" name="inputregion" id="inputregion" style="padding: 5px;width:30%;">
                <option value="">전체</option>
                <option value="100260">서울특별시</option>
                <option value="100267">부산광역시</option>
                <option value="100269">인천광역시</option>
                <option value="100272">대구광역시</option>
                <option value="100275">광주광역시</option>
                <option value="100271">대전광역시</option>
                <option value="100273">울산광역시</option>
                <option value="100704">세종특별자치시</option>
                <option value="100276" selected>경기도</option>
                <option value="100278">강원도</option>
                <option value="100281">충청남도</option>
                <option value="100280">충청북도</option>
                <option value="100285">경상북도</option>
                <option value="100291">경상남도</option>
                <option value="100282">전라북도</option>
                <option value="100283">전라남도</option>
                <option value="100292">제주특별자치도</option>
                <option value="100771">해외거주</option>
            </select>
        </td>
        <br>
        <th>학교이름</th>
        <td>
            <input type="text" id="schoo_name" onkeypress="javascript:if(event.keyCode == 13){school_search(); return false;}">
        </td>
            <input type="button" value="검색" onclick="school_search();">
    <tr>
</form>
</body>