package com.flowedu.controller;

import com.flowedu.util.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
/**
 * Created by WONEUNJEONG on 2017-08-08.
 */

@Controller
public class MemberController {

    @RequestMapping(value={"/member","/member/{page_gbn}"})
    public ModelAndView member(@RequestParam(value="page_gbn", required=false)String page_gbn) throws Exception {
        ModelAndView mvc = new ModelAndView();
        page_gbn = Util.isNullValue(page_gbn, "");

        if("save_member".equals(page_gbn)){
            mvc.setViewName("/member/save_member");
        }else if("modify_member".equals(page_gbn)){
            mvc.setViewName("/member/modify_member");
        }
        return mvc;
    }
}
