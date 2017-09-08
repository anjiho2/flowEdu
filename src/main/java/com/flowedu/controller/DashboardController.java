package com.flowedu.controller;

import com.flowedu.util.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by jihoan on 2017. 9. 8..
 */
@Controller
public class DashboardController {

    @RequestMapping(value={"/dashboard","/dashboard/{page_gbn}"})
    public ModelAndView dashboard(@RequestParam(value="page_gbn", required=false)String page_gbn) throws Exception {
        ModelAndView mvc = new ModelAndView();
        page_gbn = Util.isNullValue(page_gbn, "");

        if("dashboard_list".equals(page_gbn)){
            mvc.setViewName("/dashboard/dashboard_list");
        }
        return mvc;
    }
}
