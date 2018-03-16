package com.flowedu.api.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 10. 20..
 */
@Data
public class MemberLoginLogDto {

    private Long memberLoginLogId;

    private Long flowMemberId;

    private String memberName;

    private String connectIp;

    private String createDate;

    public MemberLoginLogDto() {}

    public MemberLoginLogDto(Long flowMemberId, String memberName, String connectIp) {
        this.flowMemberId = flowMemberId;
        this.memberName = memberName;
        this.connectIp = connectIp;
    }
}
