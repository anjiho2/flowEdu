package com.flowedu.service;

import com.flowedu.config.PagingSupport;
import com.flowedu.dto.PagingDto;
import com.flowedu.mapper.LoginMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by jihoan on 2017. 7. 6..
 */
@Service
public class LoginService extends PagingSupport {

    @Autowired
    private LoginMapper loginMapper;

    @Transactional(readOnly = true)
    public List<UserDto> selectUserList(int sPage, int pageCount) {
        PagingDto paging = getPagingInfo(sPage, pageCount);
        List<UserDto> list = loginMapper.findUserName(paging.getStart(), pageCount);
        return list;
    }

    @Transactional(readOnly = true)
    public int userListSize() {
        return loginMapper.userCount();
    }

}
