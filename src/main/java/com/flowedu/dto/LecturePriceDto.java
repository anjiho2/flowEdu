package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 9..
 */
@Data
public class LecturePriceDto {

    //  강의 금액 아이디
    private Integer lecturePriceId;

    //  금액
    private Integer lecturePrice;

    //  생성일
    private String createDate;

}
