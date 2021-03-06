package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 11..
 */
@Data
public class LectureStudentRelDto {

    //  아이디
    private Long lectureRelId;

    //  강의 정보 아이디
    private Long lectureId;

    //  학생 아이디
    private Long studentId;

    //  생성일
    private String createDate;

    private boolean addYn;

    private String studentName;

    private String schoolName;

    private Integer paymentPrice;

    private boolean paymentYn;

    private String paymentDate;

    public LectureStudentRelDto() {}

    public LectureStudentRelDto(Long lectureId, Long studentId) {
        this.lectureId = lectureId;
        this.studentId = studentId;
    }
}
