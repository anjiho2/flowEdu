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

    private String attendModifyComment;

    private String modifyDate;

    private String attendStartTime;

    private String attendEndTime;

    private String lectureName;

    public LectureAttendDto() {}

    public List<LectureAttendDto> consume(List<LectureAttendDto> lectureAttendDtoList) throws Exception {
        List<LectureAttendDto> Arr = new ArrayList<>();
        for (LectureAttendDto dto : lectureAttendDtoList) {
            LectureAttendDto lectureAttendDto = new LectureAttendDto();
            lectureAttendDto.setLectureId(dto.getLectureId());
            lectureAttendDto.setStudentId(dto.getStudentId());
            lectureAttendDto.setAttendType(dto.getAttendType());
            lectureAttendDto.setAttendDay(LectureDay.getDay());
            Arr.add(lectureAttendDto);
        }
        return Arr;
    }
}
