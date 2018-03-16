package com.flowedu.api.dto;

import lombok.Data;

@Data
public class EmailSendReservationDto {

    private Long idx;

    private String emailAddress;

    private String memberName;

    private String phoneNumber;

    private String authKey;

    public EmailSendReservationDto(String emailAddress, String memberName, String phoneNumber, String authKey) {
        this.emailAddress = emailAddress;
        this.memberName = memberName;
        this.phoneNumber = phoneNumber;
        this.authKey = authKey;
    }
}
