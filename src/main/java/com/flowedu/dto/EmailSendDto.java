package com.flowedu.dto;

import lombok.Data;

import java.util.List;

@Data
public class EmailSendDto {

    private String subject;

    private String content;

    private String receiver;

    private List<String> toCc;

    private FlowEduMemberDto flowEduMemberDto;

    public EmailSendDto(String subject, FlowEduMemberDto flowEduMemberDto, String receiver, List<String>toCC) {
        this.subject = subject;
        this.flowEduMemberDto = flowEduMemberDto;
        this.receiver = receiver;
        this.toCc = toCC;
    }

}
