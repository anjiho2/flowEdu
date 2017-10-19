package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 10. 10..
 */
@Data
public class EarlyConsultMemoDto {

    private Long earlyConsultMemoId;

    private String phoneNumber;

    private String memoType;

    private String memoContent;

    private Long createMemberId;

    private String createDate;

    private boolean completeYn;

    private String memberName;
}
