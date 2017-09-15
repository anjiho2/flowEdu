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
public class PaymentController {

    @RequestMapping(value={"/payment","/payment/{page_gbn}"})
    public ModelAndView payment(@RequestParam(value="page_gbn", required=false)String page_gbn) throws Exception {
        ModelAndView mvc = new ModelAndView();
        page_gbn = Util.isNullValue(page_gbn, "");

        if("lecture_payment_list".equals(page_gbn)){
            mvc.setViewName("/payment/lecture_payment_list");
        }
        return mvc;
    }
}
