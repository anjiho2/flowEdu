package com.flowedu.dto;

import com.flowedu.util.Aes256;
import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 4..
 */
@Data
public class FlowEduMemberDto {
    //  회원 아이디
    private Long flowMemberId;

    //  관 구분
    private String officeCode;

    //  로그인 전화번호 사용
    private String phoneNumber;

    //  비밀번호
    private String memberPassword;

    //  이름
    private String memberName;

    //  운영자, 선생님인지 구분
    private String memberType;

    //  생성일
    private String createDate;

    public FlowEduMemberDto(String officeCode, String phoneNumber, String memberPassword, String memberName, String memberType) throws Exception {
        this.officeCode = officeCode;
        this.phoneNumber = phoneNumber;
        this.memberPassword = Aes256.encrypt(memberPassword);
        this.memberName = memberName;
        this.memberType = memberType;
    }
}
