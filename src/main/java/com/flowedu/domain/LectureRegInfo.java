package com.flowedu.domain;

import com.flowedu.dto.LectureInfoDto;
import com.flowedu.dto.LectureStudentRelDto;
import lombok.Data;

import java.util.List;

@Data
public class LectureRegInfo {

    private LectureInfoDto lectureInfo;

    private List<LectureStudentRelDto> lectureStudentRelList;

    public LectureRegInfo(LectureInfoDto lectureInfo, List<LectureStudentRelDto>lectureStudentRelList) {
        this.lectureInfo =  lectureInfo;
        this.lectureStudentRelList = lectureStudentRelList;
    }
}
