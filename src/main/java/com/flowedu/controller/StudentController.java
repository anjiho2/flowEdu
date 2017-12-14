package com.flowedu.controller;

import com.flowedu.util.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by WONEUNJEONG on 2017-08-09.
 */
@Controller
public class StudentController {


    @RequestMapping(value={"/student","/student/{page_gbn}"})
    public ModelAndView student(@RequestParam(value="page_gbn", required=false)String page_gbn) throws Exception {
        ModelAndView mvc = new ModelAndView();
        page_gbn = Util.isNullValue(page_gbn, "");

        if("save_student".equals(page_gbn)){
            mvc.setViewName("/student/save_student");
        }else if("modify_student".equals(page_gbn)){
            mvc.setViewName("/student/modify_student");
        }else if("lecture_student".equals(page_gbn)){
            mvc.setViewName("/student/lecture_student");
        }else if("memo_student".equals(page_gbn)){
            mvc.setViewName("/student/memo_student");
        }else if("detail_memo_student".equals(page_gbn)){
            mvc.setViewName("/student/detail_memo_student");
        }else if("attend_student_list".equals(page_gbn)){
            mvc.setViewName("/student/attend_student_list");
        }else if("student_list".equals(page_gbn)){
            mvc.setViewName("/student/student_list");
        }

        return mvc;
    }

}
