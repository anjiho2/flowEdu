package com.flowedu.controller;

import com.flowedu.service.ExcelReadService;
import com.flowedu.util.JsonBuilder;
import com.flowedu.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;

/**
 * Created by jihoan on 2017. 10. 13..
 */
@Controller
@RequestMapping(value = "excel_read")
public class ExcelReadController {

    @Autowired
    private ExcelReadService excelReadService;

    @RequestMapping(value = "/student_info", method = RequestMethod.POST)
    public @ResponseBody String readStudentExcel(MultipartHttpServletRequest servletRequest) throws Exception {
        MultipartFile excelFile = servletRequest.getFile("excel_file");

        if (excelFile == null || excelFile.isEmpty()) {
            return new JsonBuilder().add("result", "엑셀파일을 선택 해 주세요.").build();
        }
        File destFile = new File(excelFile.getOriginalFilename());
        excelFile.transferTo(destFile);
        String result = excelReadService.readStudentExcel(destFile);
        if ("VALUE_EMPTY".equals(result)) {
            return new JsonBuilder().add("result", "필수값이 없어나 값이 잘못되었습니다.").build();
        } else if (result.contains("MOTHER")) {
            String[] results = StringUtil.stringSplit(result, "_");
            return new JsonBuilder().add("result", results[1] + " 전화번호는 이미 엄마 전화번호에 등록되어있는 전화번호 입니다.").build();
        }
        return new JsonBuilder().add("result", "완료됬습니다.").build();
    }
}
