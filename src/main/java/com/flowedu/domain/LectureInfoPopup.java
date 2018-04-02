package com.flowedu.domain;

import lombok.Data;

@Data
public class LectureInfoPopup {

    private Long lectureId;

    private String lectureName;

    private String lectureStatus;

    private String memberName;

    private String lectureStartDate;

    private String lectureEndDate;

    private String lectureTime;

    public LectureInfoPopup() {}

    public LectureInfoPopup(Long lectureId, String lectureName, String lectureStatus, String memberName,
                            String lectureStartDate, String lectureEndDate, String lectureTime) {
        this.lectureId = lectureId;
        this.lectureName = lectureName;
        this.lectureStatus = lectureStatus;
        this.memberName = memberName;
        this.lectureStartDate = lectureStartDate;
        this.lectureEndDate = lectureEndDate;
        this.lectureTime = lectureTime;
    }

}
