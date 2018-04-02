package com.flowedu.mapper;

import com.flowedu.domain.CalcLecturePayment;
import com.flowedu.domain.LectureSearch;
import com.flowedu.domain.MainMenu;
import com.flowedu.domain.SubMenu;
import com.flowedu.dto.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 7. 6..
 */
public interface AuthMapper {

    /** SELECT **/
    List<MainMenu>selectMainMenuList(@Param("memberId") Long memberId);

    List<SubMenu>selectSubMenuList(@Param("memberId") Long memberId);

    List<OfficeDto>selectOfficeList(@Param("memberId") Long memberId);

    List<OfficeDto>getOfficeAllList();
}