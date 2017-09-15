package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 9. 11..
 */
@Data
public class StudentMemoReplyDto {

    private Long studentMemoReplyId;

    private Long studentMemoId;

    private Long flowMemberId;

    private String replyContent;

    private String createDate;

    private boolean deleteYn;

    private String memberName;
}
