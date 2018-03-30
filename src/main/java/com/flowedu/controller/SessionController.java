package com.flowedu.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

@RequestMapping("/session")
@Controller
public class SessionController {

    private static final Logger logger = LoggerFactory.getLogger(SessionController.class);

    @RequestMapping(value = "/change", method = RequestMethod.GET)
    public ResponseEntity chageSession(ServletRequest request) {
        HttpServletRequest req = ((HttpServletRequest)request);
        logger.info("request >>> " + req.getSession().toString());
        logger.info("request >>> " + req.getAttribute("member_info"));
        return null;
    }
}
