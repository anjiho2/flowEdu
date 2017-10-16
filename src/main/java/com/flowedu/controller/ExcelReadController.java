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
import java.util.HashMap;
import java.util.Map;

/**
 * Created by jihoan on 2017. 10. 13..
 */
@Controller
@RequestMapping(value = "excel_read")
public class ExcelReadController {

    @Autowired
    private ExcelReadService excelReadService;

    /**
     * <PRE>
     * 1. Comment : 학생 정보 엑셀 업로드 입력 기능
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 10 .16
     * </PRE>
     * @param servletRequest
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/student_info", method = RequestMethod.POST)
    public @ResponseBody String readStudentExcel(MultipartHttpServletRequest servletRequest) throws Exception {
        MultipartFile excelFile = servletRequest.getFile("excel_file");

        Map<String, Object> resultEntity = new HashMap<>();
        String result = null;
        String phoneNumber = null;
        if (excelFile == null || excelFile.isEmpty()) {
            result = "EMPTY_FILE";
        }
        File destFile = new File(excelFile.getOriginalFilename());
        excelFile.transferTo(destFile);
        result = excelReadService.readStudentExcel(destFile);
        if ("VALUE_EMPTY".equals(result)) {
            result = "VALUE_EMPTY";
        } else if (result.contains("MOTHER")) {
            String[] results = StringUtil.stringSplit(result, "_");
            result = "MOTHER";
            phoneNumber = results[1];
        }
        resultEntity.put("code", result);
        resultEntity.put("phoneNumber", phoneNumber);
        return new JsonBuilder().add("result", resultEntity).build();
    }
}
