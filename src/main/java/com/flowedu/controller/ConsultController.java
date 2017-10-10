package com.flowedu.controller;

import com.flowedu.util.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by jihoan on 2017. 9. 29..
 */
@Controller
public class ConsultController {

    @RequestMapping(value = {"/consult", "/conssult/{page_gbn}"})
    public ModelAndView consult(@RequestParam(value = "page_gbn", required = false) String page_gbn) throws Exception {
        ModelAndView mvc = new ModelAndView();
        page_gbn = Util.isNullValue(page_gbn, "");

        if ("save_consult".equals(page_gbn)) {
            mvc.setViewName("/consult/save_consult");
        } else if ("consult_list".equals(page_gbn)) {
            mvc.setViewName("/consult/consult_list");
        }
        return mvc;
    }
}
