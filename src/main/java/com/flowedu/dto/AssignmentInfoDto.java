package com.flowedu.dto;

import lombok.Data;

//  과제관리 정보 테이블
@Data
public class AssignmentInfoDto {

    //  과제 인덱스
    private Long assignmentIdx;

    //  강의 아이디
    private Long lectureId;

    //  등록자 아이디
    private Long regMemberId;

    //  과제 제목
    private String assignmentSubject;

    //  과제 내용
    private String assignmentContent;

    //  첨부파일 이름
    private String assignmentFileName;

    //  첨부파일 저장 url
    private String attachmentFileUrl;

    //  사용여부
    private Boolean useYn;

    //  등록일
    private String createDate;

    private String memberName;

    public AssignmentInfoDto() {}

    public AssignmentInfoDto(Long lectureId, Long regMemberId, String assignmentSubject,
                             String assignmentContent, String assignmentFileName, boolean useYn) {
        this.lectureId = lectureId;
        this.regMemberId = regMemberId;
        this.assignmentSubject = assignmentSubject;
        this.assignmentContent = assignmentContent;
        this.assignmentFileName = assignmentFileName;
        this.attachmentFileUrl = "assignment/" + lectureId;
        this.useYn = useYn;
    }

    public AssignmentInfoDto(Long assignmentIdx, Long lectureId, Long regMemberId, String assignmentSubject,
                             String assignmentContent, String assignmentFileName, boolean useYn) {
        this.assignmentIdx = assignmentIdx;
        this.lectureId = lectureId;
        this.regMemberId = regMemberId;
        this.assignmentSubject = assignmentSubject;
        this.assignmentContent = assignmentContent;
        this.assignmentFileName = assignmentFileName;
        this.attachmentFileUrl = "assignment/" + lectureId;
        this.useYn = useYn;
    }
}
