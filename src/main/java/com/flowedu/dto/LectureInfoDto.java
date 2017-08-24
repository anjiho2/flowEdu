package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 9..
 */
@Data
public class LectureInfoDto {

    //  강의 아이디
    private Long lectureId;

    //  관 구분 코드
    private Long officeId;

    //  담임 선생님 아이디
    private Long chargeMemberId;

    //  관리 선생님 아이디
    private Long manageMemberId;

    //  강의 금액
    private Long lecturePriceId;

    //  강의명
    private String lectureName;

    //  강의 과목
    private String lectureSubject;

    //  강의 학년
    private Integer lectureGrade;

    //  강의 레벨
    private String lectureLevel;

    //  강의 운영형태(월,횟수)
    private String lectureOperationType;

    //  강의시작월일
    private String lectureStartDate;

    //  강의종료월일
    private String lectureEndDate;

    //  강의 정원
    private Integer lectureLimitStudent;

    //  개강/휴강/폐강
    private String lectureStatus;

    //  생성일
    private String createDate;


    // 학교 타입(초, 중, 고)
    private String schoolType;


    private String chargeMemberName;

    private String manageMemberName;

    private String officeName;

    private Integer lecturePrice;

    private Integer regCount;


}
