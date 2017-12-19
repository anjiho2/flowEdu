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
        } else if("tableList".equals(page_gbn)){
            mvc.setViewName("/templates/tableList");
        } else if("formType1".equals(page_gbn)){
            mvc.setViewName("/templates/formType1");
        } else if("tileType1".equals(page_gbn)){
            mvc.setViewName("/templates/tileType1");
        } else if("layerPopup".equals(page_gbn)){
            mvc.setViewName("/templates/layerPopup");
        } else if("twoPartLayout".equals(page_gbn)){
            mvc.setViewName("/templates/twoPartLayout");
        } else if("introGate".equals(page_gbn)){
            mvc.setViewName("/templates/introGate");
        } else if("viewDevelop".equals(page_gbn)) {
            mvc.setViewName("/templates/viewDevelop");
        }




        else if("layer".equals(page_gbn)){
            mvc.setViewName("/templates/layer");
        }
        return mvc;
    }
}
