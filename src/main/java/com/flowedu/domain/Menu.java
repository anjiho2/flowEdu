package com.flowedu.domain;

import lombok.Data;

import java.util.List;

@Data
public class Menu {

    private String mainMenuName;

    private List<SubMenu>subMenus;
}
