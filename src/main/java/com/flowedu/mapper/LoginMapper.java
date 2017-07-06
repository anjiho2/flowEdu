package com.flowedu.mapper;

import org.apache.ibatis.annotations.Param;

/**
 * Created by jihoan on 2017. 7. 6..
 */
public interface LoginMapper {

    public String findUserName(@Param("userName") String userName);
}
