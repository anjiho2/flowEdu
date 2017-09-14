package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 25..
 */
@Data
public class StudentMemoDto {

    //  메모 아이디
    private Long studentMemoId;

    //  학생 아이디
    private Long studentId;

    //  작성자 아이디
    private Long flowMemberId;

    //  메모 내용
    private String memoContent;

    //  생성일
    private String createDate;

    // 작성자 이름
    private String memberName;

    private String memoType;

    private boolean processYn;

    private int replyCount;
}
