package com.flowedu.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 7. 6..
 */
public interface LoginMapper {

    Long findFlowEduMember(@Param("phoneNumber") String phoneNumber, @Param("password") String password, @Param("memberType") String memberType);

}
