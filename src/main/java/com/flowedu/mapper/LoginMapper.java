package com.flowedu.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 7. 6..
 */
public interface LoginMapper {

    Long findFlowEduMember(@Param("memberId") String memberId, @Param("password") String password);

}
