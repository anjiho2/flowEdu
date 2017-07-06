package com.flowedu.service;

import com.flowedu.mapper.LoginMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by jihoan on 2017. 7. 6..
 */
@Service
public class LoginService {

    @Autowired
    private LoginMapper loginMapper;

    @Transactional(readOnly = true)
    public String findUserName(String userName) {
        String name = "";
        if (!"".equals(userName)) {
            name = loginMapper.findUserName(userName);
        }
        return name;
    }
}
