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
public class BusController {

    @RequestMapping(value={"/bus","/bus/{page_gbn}"})
    public ModelAndView academy(@RequestParam(value="page_gbn", required=false)String page_gbn) throws Exception {
        ModelAndView mvc = new ModelAndView();
        page_gbn = Util.isNullValue(page_gbn, "");

        if("bus_info".equals(page_gbn)) {
            mvc.setViewName("/bus/bus_info");
        }else if("save_driver".equals(page_gbn)){
            mvc.setViewName("/bus/save_driver");
        }else if("driver_info".equals(page_gbn)){
            mvc.setViewName("/bus/driver_info");
        }else if("commute_assist_info".equals(page_gbn)){
            mvc.setViewName("/bus/commute_assist_info");
        }else if("save_commute_assist".equals(page_gbn)){
            mvc.setViewName("/bus/save_commute_assist");
        }else if("bus_route_info".equals(page_gbn)){
            mvc.setViewName("/bus/bus_route_info");
        }else if("modify_bus_route".equals(page_gbn)){
            mvc.setViewName("/bus/modify_bus_route");
        }else if("save_bus_route".equals(page_gbn)){
            mvc.setViewName("/bus/save_bus_route");
        }

        return mvc;
    }
}

