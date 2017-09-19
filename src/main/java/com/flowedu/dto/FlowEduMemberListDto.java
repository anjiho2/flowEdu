package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 7..
 */
@Data
public class FlowEduMemberListDto {

    //  회원 아이디
    private Long flowMemberId;

    //  관 구분 아이디
    private Long officeId;

    //  팀 아이디
    private Integer teamId;

    // 직책 아이디
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

    //  교육청 강사등록일자
    private String educationRegDate;

    //  운영자, 선생님인지 구분
    private String memberType;

    //  생성일
    private String createDate;

    //관이름
    private String officeName;

    //팀 명
    private String teamName;

    //직책 명
    private String jobPositionName;
}
