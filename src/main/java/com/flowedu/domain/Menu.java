package com.flowedu.domain;

import lombok.Data;

import java.util.List;

@Data
public class Menu {

//    private int mainMenuId;
//
//    private String mainMenuName;
//
//    private boolean viewYn;

    private MainMenu mainMenu;

    private List<SubMenu>subMenus;
}
