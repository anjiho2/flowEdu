package com.flowedu.domain;

import lombok.Data;

/**
 * Created by jihoan on 2017. 11. 8..
 */
@Data
public class CalcLecturePayment {

    private Long lectureRelId;

    private int paymentPrice;

    private String calcType;

    public CalcLecturePayment(Long lectureRelId, int paymentPrice, String calcType) {
        this.lectureRelId = lectureRelId;
        this.paymentPrice = paymentPrice;
        this.calcType = calcType;
    }
}
