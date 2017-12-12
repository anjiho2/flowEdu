package com.flowedu.dto;

import com.flowedu.util.Aes256;
import lombok.Data;

import java.io.Serializable;

/**
 * Created by jihoan on 2017. 8. 4..
 */
@Data
public class FlowEduMemberDto implements Serializable {
    //  회원 아이디
    private Long flowMemberId;

    //  관 구분 아이디
    private Long officeId;

    //  팀 아이디
    private Integer teamId;

    //  직책 아이디
    private Integer jobPositionId;

    //  로그인 전화번호 사용
    private String phoneNumber;

    //  비밀번호
    private String memberPassword;

    //  이름
    private String memberName;

    //  생년월일
    private String memberBirthday;

    //  주소
    private String memberAddress;

    //  이메일
    private String memberEmail;

    //  성범죄경력조회 확인일자
    private String sexualAssultConfirmDate;

    //  교육정 강사등록일자
    private String educationRegDate;

    //  운영자, 선생님인지 구분
    private String memberType;

    //  생성일
    private String createDate;

    private String academyThumbnail;

    public FlowEduMemberDto() {}

    public FlowEduMemberDto(Long officeId, int teamId, int jobPositionId,  String phoneNumber, String memberName, String memberBirthDay,
                String memeberAddress, String memberPassword, String memberEmail, String sexualAssultConfirmDate,
                String educationRegDate, String memberType) throws Exception {
        this.officeId = officeId;
        this.teamId = teamId;
        this.jobPositionId = jobPositionId;
        this.phoneNumber = phoneNumber;
        this.memberName = memberName;
        this.memberBirthday = memberBirthDay;
        this.memberAddress = memeberAddress;
        this.memberPassword = Aes256.encrypt(memberPassword);
        this.memberEmail = memberEmail;
        this.sexualAssultConfirmDate = sexualAssultConfirmDate;
        this.educationRegDate = educationRegDate;
        this.memberName = memberName;
        this.memberType = memberType;
    }

    public FlowEduMemberDto(Long flowMemberId,Long officeId, Integer teamId, int jobPositionId, String phoneNumber, String memberName,
                            String memberBirthDay, String memeberAddress, String memberPassword, String memberEmail,
                            String sexualAssultConfirmDate, String educationRegDate, String memberType) throws Exception {
        this.flowMemberId = flowMemberId;
        this.officeId = officeId;
        this.teamId = teamId;
        this.jobPositionId = jobPositionId;
        this.phoneNumber = phoneNumber;
        this.memberName = memberName;
        this.memberBirthday = memberBirthDay;
        this.memberAddress = memeberAddress;
        this.memberPassword = Aes256.encrypt(memberPassword);
        this.memberEmail = memberEmail;
        this.sexualAssultConfirmDate = sexualAssultConfirmDate;
        this.educationRegDate = educationRegDate;
        this.memberName = memberName;
        this.memberType = memberType;
    }

    public FlowEduMemberDto(Long flowMemberId, String memberType, String memberName, Long officeId, String academyThumbnail) {
        this.flowMemberId = flowMemberId;
        this.memberType = memberType;
        this.memberName = memberName;
        this.officeId = officeId;
        this.academyThumbnail = academyThumbnail;
    }
}
