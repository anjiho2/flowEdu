package com.flowedu.controller;

import com.flowedu.util.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by jihoan on 2017. 9. 26..
 */
@Controller
public class PopupController {

    @RequestMapping(value = {"/popup", "/popup/{page_gbn}"})
    public ModelAndView popup(@RequestParam(value = "page_gbn", required = false) String page_gbn) throws Exception {
        ModelAndView mvc = new ModelAndView();
        page_gbn = Util.isNullValue(page_gbn, "");

        if ("school_search".equals(page_gbn)) {
            mvc.setViewName("/popup/school_search_popup");
        }
        return mvc;
    }
}
