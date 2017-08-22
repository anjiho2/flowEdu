package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 21..
 */
@Data
public class CalendarLectureInfoDto {

    private Long lectureDetailId;

    private Long lectureId;

    private Long lectureRoomId;

    private String startTime;

    private String endTime;

    private String lectureDay;

    private String lectureName;

    private String lectureStartDate;

    private String lectureEndDate;

    private String lectureOperationType;

    private String officeName;

    private String lectureRoomName;

}
