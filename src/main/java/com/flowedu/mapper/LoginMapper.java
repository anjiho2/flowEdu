package com.flowedu.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 7. 6..
 */
public interface LoginMapper {

    List<UserDto> findUserName(@Param("start") int start, @Param("end") int end);

    int userCount();
}
