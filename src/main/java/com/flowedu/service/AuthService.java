package com.flowedu.service;

import com.flowedu.domain.MainMenu;
import com.flowedu.domain.Menu;
import com.flowedu.domain.SubMenu;
import com.flowedu.dto.FlowEduMemberDto;
import com.flowedu.dto.OfficeDto;
import com.flowedu.mapper.AuthMapper;
import com.flowedu.mapper.MemberMapper;
import com.flowedu.session.UserSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class AuthService {

    @Autowired
    private AuthMapper authMapper;

    @Autowired
    private MemberMapper memberMapper;

    /**
     * <PRE>
     * 1. Comment : 좌측메뉴 권한 정보 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 03 .30
     * </PRE>
     * @return
     */
    @Transactional(readOnly = true)
    public List<Menu>getLeftMenuInfo() {
        List<MainMenu>mainMenuList = authMapper.selectMainMenuList(UserSession.flowMemberId());
        List<Menu>menus = new ArrayList<>();
        for (MainMenu mainMenu : mainMenuList) {
            Menu menu = new Menu();
                menu.setMainMenu(mainMenu);

                List<SubMenu>list2 = authMapper.selectSubMenuList(UserSession.flowMemberId());
                menu.setSubMenus(list2);

                menus.add(menu);
        }
        return menus;
    }

    @Transactional(readOnly = true)
    public List<OfficeDto>getMemberOfficeInfo() {
        return authMapper.selectOfficeList(UserSession.flowMemberId());
    }

    @Transactional(readOnly = true)
    public List<OfficeDto>getOfficeAllList() {
        return authMapper.getOfficeAllList();
    }
}
