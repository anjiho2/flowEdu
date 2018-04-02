package com.flowedu.dto;

import lombok.Data;

@Data
public class StudentSimpleMemoDto {

    private Long studentSimpleMemoId;

    private Long studentId;

    private Long flowMemberId;

    private String memoContent;

    private String createDate;
}
