<%@ page import="com.flowedu.util.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type='text/javascript' src='/flowEdu/dwr/interface/academyService.js'></script>
<script type='text/javascript' src='/flowEdu/dwr/interface/lectureService.js'></script>
<script type="text/javascript">
    $(document).ready(function () {
        searchAcademySelectbox("sel_academy", "");
    });

    function init(val) {
        var officeId = "";
        if (val != undefined) {
            officeId = val;
        }

        var spans = $('.ms-error');
        spans.text('');

        for (var k=1; k<=25; k++) {
            $("#td_"+k).hide();
        }

        lectureService.getLectureRoomListByRegSuccess(officeId, "08:00", "14:00", function(selList) {
            if (selList.length == 0) return;

            for (var i=0; i<selList.length; i++) {
                var j = i+1;
                $("#td_"+j).show();
                $("#class_"+j).removeClass();
                if (selList[i].cnt > 0)  {
                    $("#class_"+j).attr('data-book', '1');
                    $("#class_"+j).addClass('class_btn class_btn_block class_btn_checked');
                } else {
                    $("#class_"+j).addClass('class_btn class_btn_block class_btn_success');
                }
                $("#class_"+j).find("input").val(selList[i].lectureRoomId);
                $("#class_"+j).find("input").after("<span class=\"ms-error\">" + selList[i].lectureRoomName + "</span>");
            }
        });
    }


</script>
<body onload="init();">
<form name="frm" method="get">
    <input type="hidden" name="page_gbn" id="page_gbn">
</form>
<div class="container">
    <%--<%@include file="/common/jsp/member_top_menu.jsp" %>--%>
    <div class="title-top">강의관리</div>
</div>
</section>
<section class="content">
    <div>
        <select id="sel_academy" class="form-control" onchange="init(this.value);">
            <option value="">선택</option>
        </select>
    </div>
    <input type="hidden" id="isClassClick">
        <table id="classTable">
            <tbody id="dataList">
                <tr>
                    <% for (int i=1; i<=5; i++) { %>
                    <td data-toggle="buttons" id="td_<%=i%>" style="display: none">
                        <label style="width: 100px;" class="class_btn class_btn_block class_btn_default" id="class_<%=i%>">
                            <input type="checkbox" id="check_<%=i%>" name="class_check_list[]" value="" checked="" autocomplete="off">
                        </label>
                    </td>
                    <% } %>
                </tr>
                <tr>
                    <% for (int i=6; i<=10; i++) { %>
                    <td data-toggle="buttons" id="td_<%=i%>" style="display: none">
                        <label style="width: 100px;" class="class_btn class_btn_block class_btn_default" id="class_<%=i%>">
                            <input type="checkbox" id="check_<%=i%>" name="class_check_list[]" value="" checked="" autocomplete="off">
                        </label>
                    </td>
                    <% } %>
                </tr>
                <tr>
                    <% for (int i=11; i<=15; i++) { %>
                    <td data-toggle="buttons" id="td_<%=i%>" style="display: none">
                        <label style="width: 100px;" class="class_btn class_btn_block class_btn_default" id="class_<%=i%>">
                            <input type="checkbox" id="check_<%=i%>" name="class_check_list[]" value="" checked="" autocomplete="off">
                        </label>
                    </td>
                    <% } %>
                </tr>
                <tr>
                    <% for (int i=16; i<=20; i++) { %>
                    <td data-toggle="buttons" id="td_<%=i%>" style="display: none">
                        <label style="width: 100px;" class="class_btn class_btn_block class_btn_default" id="class_<%=i%>">
                            <input type="checkbox" id="check_<%=i%>" name="class_check_list[]" value="" checked="" autocomplete="off">
                        </label>
                    </td>
                    <% } %>
                </tr>
                <tr>
                    <% for (int i=21; i<=25; i++) { %>
                    <td data-toggle="buttons" id="td_<%=i%>" style="display: none">
                        <label style="width: 100px;" class="class_btn class_btn_block class_btn_default" id="class_<%=i%>">
                            <input type="checkbox" id="check_<%=i%>" name="class_check_list[]" value="" checked="" autocomplete="off">
                        </label>
                    </td>
                    <% } %>
                </tr>
            </tbody>
        </table>
    </div>

</section>
</body>
</html>
<script>
    $(document).ready(function () {
        $("#classTable tbody td").each(function() {
            //var text = $(this).html();
            var isBook = $(this).find("label.class_btn").attr("data-book");
            if (isBook == 1) {
                $(this).find("label").addClass("class_btn class_btn_block class_btn_checked");
            }
        });

        $("label.class_btn").click(function() {
            var is_class = $(this).attr("data-book");
            if (is_class == "1") {
                alert("선택할 수 없는 강의실입니다.")
                return false;
            }
            //Find the child check box.
            var $input = $(this).find('input');

            $(this).toggleClass('class_btn_danger class_btn_success');
            //Remove the attribute if the button is "disabled"
            if ($(this).hasClass('class_btn_danger')) {
                var isClassClick = getInputTextValue("isClassClick");
                if (isClassClick == "1") {
                    alert("이미 강의실이 선택되었습니다.");
                    $(this).toggleClass('class_btn_danger class_btn_success');
                    return false;
                }
                $input.attr('checked', '');
                innerValue("isClassClick", "1");
            } else {
                $input.removeAttr('checked');
                innerValue("isClassClick", "0");
            }
            return false; //Click event is triggered twice and this prevents re-toggling of classes
        });
    });
</script>





















