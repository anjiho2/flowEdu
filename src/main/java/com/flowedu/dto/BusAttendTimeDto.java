package com.flowedu.dto;

import lombok.Data;

@Data
public class BusAttendTimeDto {
    //  인덱스
    private Long busAttendTimeIdx;

    //  정류소명
    private String stationName;

    //  버스 인덱스
    private Long busIdx;

    //  1T
    private String firstTime;

    //  2T
    private String secondTime;

    //  3T
    private String thirdTime;

    //  4T
    private String fourthTime;

    //  5T
    private String fifthTime;

    //  6T
    private String sixthTime;

    //  정렬 순서
    private Integer sortNumber;
}
