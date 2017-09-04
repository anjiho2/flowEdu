package com.flowedu.dto;

import com.flowedu.define.datasource.LectureDay;
import com.flowedu.util.DateUtils;
import com.flowedu.util.Util;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by jihoan on 2017. 8. 29..
 */
@Data
public class LectureAttendDto {

    //  아이디
    private Long lectureAttendId;

    //  강의 아이디
    private Long lectureId;

    //  학생 아이디
    private Long studentId;

    //  출석요일
    private String attendDay;

    //  출석 타입
    private String attendType;

    //  출석생성일
    private String attendDate;

    private String studentName;

    public LectureAttendDto() {}

    public List<LectureAttendDto> consume(List<LectureAttendDto> lectureAttendDtoList) throws Exception {
        List<LectureAttendDto> Arr = new ArrayList<>();
        for (LectureAttendDto dto : lectureAttendDtoList) {
            this.lectureId = dto.getLectureId();
            this.studentId = dto.getStudentId();
            this.attendType = dto.getAttendType();
            this.attendDay = LectureDay.getLectureDayCode(
                    DateUtils.getDateDay(
                            Util.returnToDate("yyyy-MM-dd"), "yyyy-MM-dd"
                    ) - 1 ).toString();
            Arr.add(this);
        }
        return Arr;
    }
}
