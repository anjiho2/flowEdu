package com.flowedu.dto;

import com.flowedu.domain.KisPosOcx;
import com.flowedu.session.UserSession;
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

    private KisPosOcx kisPosOcx;

    LecturePaymentLogDto() {}

    public LecturePaymentLogDto(String lectureName, Integer paymentPrice, String studentName, KisPosOcx kisPosOcx) {
        this.lectureName = lectureName;
        this.paymentPrice = paymentPrice;
        this.studentName = studentName;
        this.memberName = UserSession.memberName();
        this.kisPosOcx = kisPosOcx;
    }
}
