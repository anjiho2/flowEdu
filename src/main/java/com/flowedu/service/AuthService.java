package com.flowedu.service;

import com.flowedu.domain.MainMenu;
import com.flowedu.domain.Menu;
import com.flowedu.domain.SubMenu;
import com.flowedu.mapper.AuthMapper;
import com.flowedu.session.UserSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class AuthService {

    @Autowired
    private AuthMapper authMapper;

    @Transactional(readOnly = true)
    public List<Menu>getLeftMenuInfo() {
        List<MainMenu>mainMenuList = authMapper.selectMainMenuList(UserSession.flowMemberId());
        List<Menu>menus = new ArrayList<>();
        for (MainMenu mainMenu : mainMenuList) {
            Menu menu = new Menu();
            if (mainMenu.isViewYn() == true) {
                menu.setMainMenuName(mainMenu.getMainMenuName());

                List<SubMenu>list2 = authMapper.selectSubMenuList(UserSession.flowMemberId(), mainMenu.getMainMenuId());
                menu.setSubMenus(list2);

                menus.add(menu);
            }
        }
        return menus;
    }
}
