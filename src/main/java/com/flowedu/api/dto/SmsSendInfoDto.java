package com.flowedu.api.dto;

import lombok.Data;

@Data
public class SmsSendInfoDto {

    private String receiver;

    private String smsSendCode;

    public SmsSendInfoDto(String receiver, String smsSendCode) {
        this.receiver = receiver;
        this.smsSendCode = smsSendCode;
    }
}
