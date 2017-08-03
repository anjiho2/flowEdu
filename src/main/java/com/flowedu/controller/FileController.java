package com.flowedu.controller;

import com.flowedu.config.FileUploadConfigHolder;
import com.flowedu.util.FileUploadUtil;
import com.flowedu.util.JsonBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * Created by jihoan on 2017. 7. 24..
 */
@Controller
@RequestMapping(value = "/file")
public class FileController {

    @RequestMapping(value = "/upload.do", method = RequestMethod.POST)
    public @ResponseBody String fileUpload(MultipartHttpServletRequest request) {
        String fileName = FileUploadUtil.fileUploadYmdLocation(request, getFileUploadRoot());
        if (!"".equals(fileName)) {
            return new JsonBuilder().add("result", "1").build();
        }
        return new JsonBuilder().add("result", "0").build();
    }

    public String getFileUploadRoot() {
        return FileUploadConfigHolder.uploadRoot();
    }
}
