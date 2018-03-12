package com.flowedu.domain;

import com.flowedu.util.Util;
import lombok.Data;

@Data
public class LectureSearch {

    private int start;

    private int end;

    private int academyGroupId;

    private Long officeId;

    private String schoolType;

    private int lectureGrade;

    private String lectureSubject;

    private String lectureStatus;

    private String searchType;

    private String searchValue;

    public LectureSearch(int start, int end, int academyGroupId, Long officeId, String schoolType, int lectureGrade,
                         String lectureSubject, String lectureStatus, String searchType, String searchValue) {
        this.start = start;
        this.end = end;
        this.academyGroupId = academyGroupId;
        this.officeId = officeId;
        this.schoolType = Util.isNullValue(schoolType, "");
        this.lectureGrade = lectureGrade;
        this.lectureSubject = Util.isNullValue(lectureSubject, "");
        this.lectureStatus = Util.isNullValue(lectureStatus, "");
        this.searchType = Util.isNullValue(searchType, "");
        this.searchValue = Util.isNullValue(searchValue, "");
    }
}
