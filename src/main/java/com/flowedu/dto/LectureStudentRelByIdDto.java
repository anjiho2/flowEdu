package com.flowedu.dto;

import com.flowedu.domain.MemberIdName;
import com.flowedu.domain.MemberNameContain;
import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 24..
 */
@Data
public class LectureStudentRelByIdDto implements MemberNameContain {

    private Long lectureRelId;

    private Long lectureId;

    private boolean addYn;

    private Long officeId;

    private Long chargeMemberId;

    private Long manageMemberId;

    private Integer lecturePrice;

    private String lectureName;

    private String lectureSubject;

    private String schoolType;

    private Integer lectureGrade;

    private String lectureLevel;

    private String lectureOperationType;

    private String lectureStartDate;

    private String lectureEndDate;

    private Integer lectureLimitStudent;

    private String lectureStatus;

    private String officeName;

    private String chargeMemberName;

    private String manageMemberName;

    @Override
    public Long manageMemberId() {
        return manageMemberId;
    }

    @Override
    public Long chargeMemberId() {
        return chargeMemberId;
    }

    @Override
    public void addManageMemberName(MemberIdName memberIdName) {
        manageMemberName = memberIdName.getMemberName();
    }

    @Override
    public void addChargeMamberName(MemberIdName memberIdName) {
       chargeMemberName = memberIdName.getMemberName();
    }
}
