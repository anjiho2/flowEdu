package com.flowedu.dto;

import lombok.Data;

import java.util.List;

@Data
public class BusDto {

    //  버스 인덱스
    private Long busIdx;

    //  노선 번호
    private String routeNumber;

    //  노선명(시점)
    private String startRouteName;

    //  노선명(종점)
    private String endRouteName;

    //  구분
    private String busType;

    //  상태
    private Boolean busStatus;

    //  적용기간(시작일)
    private String applyStartDate;

    //  적용기간(종료일)
    private String applyEndDate;

    //  메모
    private String busMemo;

    //  기사 인덱스
    private Long driverIdx;


    //  인덱스
    private Long busDismissTimeIdx;

    //  1T
    private String dismissFirstTime;

    //  2T
    private String dismissSecondTime;

    //  3T
    private String dismissThirdTime;

    //  4T
    private String dismissFourthTime;

    //  5T
    private String dismissFifthTime;

    //  6T
    private String dismissSixthTime;


    List<BusAttendTimeDto> busAttendTimeList;

}
