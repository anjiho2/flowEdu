package com.flowedu.dto;

import lombok.Data;

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
}
