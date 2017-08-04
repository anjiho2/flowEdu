package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 4..
 */
@Data
public class MemberTypeDto {

    private String memberTypeCode;

    private String memberTypeName;

    public MemberTypeDto (String memberTypeCode, String memberTypeName) {
        this.memberTypeCode = memberTypeCode;
        this.memberTypeName = memberTypeName;
    }
}
