package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 9. 14..
 */
@Data
public class LecturePaymentLogDto {

    private Long lecturePaymentLogId;

    private String lectureName;

    private Integer paymentPrice;

    private String studentName;

    private String memberName;

    private String createDate;

    LecturePaymentLogDto() {}

    public LecturePaymentLogDto(String lectureName, Integer paymentPrice, String studentName, String memberName) {
        this.lectureName = lectureName;
        this.paymentPrice = paymentPrice;
        this.studentName = studentName;
        this.memberName = memberName;
    }
}
