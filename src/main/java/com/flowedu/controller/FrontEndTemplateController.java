package com.flowedu.controller;

import com.flowedu.util.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FrontEndTemplateController {
    @RequestMapping(value={"/template","/template/{page_gbn}"})
    public ModelAndView dashboard(@RequestParam(value="page_gbn", required=false)String page_gbn) throws Exception {
        ModelAndView mvc = new ModelAndView();
        page_gbn = Util.isNullValue(page_gbn, "");

        if("dashboard".equals(page_gbn)){
            mvc.setViewName("/templates/dashboard");
        }
        return mvc;
    }
}
