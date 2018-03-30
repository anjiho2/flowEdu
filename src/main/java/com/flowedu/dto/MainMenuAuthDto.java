package com.flowedu.dto;

import lombok.Data;

@Data
public class MainMenuAuthDto {

    private Long mainMenuAuthId;

    private int mainMenuId;

    private Long flowMemberId;

    private Long createMemberId;

    private String createDate;

    public MainMenuAuthDto() {}

}
