package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 9..
 */
@Data
public class LectureRoomDto {

    //  강의실 아이디
    private Long lectureRoomId;

    //  관 아이디
    private Long officeId;

    //  강의실 명
    private String lectureRoomName;

    //  생성일
    private String createDate;

    // 조인에 의해서 관 이름 추가
    private String officeName;

    //
    private int cnt;

    private int roomLimitStudent;

}
