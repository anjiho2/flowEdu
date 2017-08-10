package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 9..
 */
@Data
public class LectureDetailDto {
    //  아이디
    private Long lectureDetailId;

    //  강의 정보 아이디
    private Long lectureId;

    //  강의실 아이디
    private Long lectureRoomId;

    //  시작시간
    private String startTime;

    //  종료시산
    private String endTime;

    //  요일
    private String lectureDay;

    //  생성일
    private String createDate;

    private Long officeId;

    private String lectureLoomName;

    private String officeName;

    public LectureDetailDto() {}

    public LectureDetailDto(Long lectureId, Long lectureRoomId,
                String startTime, String endTime, String lectureDay) {
        this.lectureId = lectureId;
        this.lectureRoomId = lectureRoomId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.lectureDay = lectureDay;
    }
}
