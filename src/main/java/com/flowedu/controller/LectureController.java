package com.flowedu.controller;

import com.flowedu.util.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by WONEUNJEONG on 2017-08-11.
 */
@Controller
public class LectureController {

    @RequestMapping(value={"/lecture","/lecture/{page_gbn}"})
    public ModelAndView member(@RequestParam(value="page_gbn", required=false)String page_gbn) throws Exception {
        ModelAndView mvc = new ModelAndView();
        page_gbn = Util.isNullValue(page_gbn, "");

        if("lecture_info".equals(page_gbn)){
            mvc.setViewName("/lecture/lecture_info");
        }else if("lecture_price".equals(page_gbn)){
            mvc.setViewName("/lecture/lecture_price");
        }else if("lecture_room".equals(page_gbn)){
            mvc.setViewName("/lecture/lecture_room");
        }
        return mvc;
    }

}
