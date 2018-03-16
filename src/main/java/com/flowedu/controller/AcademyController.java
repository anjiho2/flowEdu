package com.flowedu.controller;

import com.flowedu.util.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by WONEUNJEONG on 2017-08-07.
 */
@Controller
public class AcademyController {

    @RequestMapping(value={"/academy","/academy/{page_gbn}"})
    public ModelAndView academy(@RequestParam(value="page_gbn", required=false)String page_gbn) throws Exception {
        ModelAndView mvc = new ModelAndView();
        page_gbn = Util.isNullValue(page_gbn, "");

        if("save_academy".equals(page_gbn)){
            mvc.setViewName("/academy/save_academy");
        }else if("modify_academy".equals(page_gbn)){
            mvc.setViewName("/academy/modify_academy");
        }else if("list_academy".equals(page_gbn)){
            mvc.setViewName("/academy/list_academy");
        }
        return mvc;
    }
}

