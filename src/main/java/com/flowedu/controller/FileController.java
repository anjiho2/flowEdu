package com.flowedu.controller;

import com.flowedu.config.FileUploadConfigHolder;
import com.flowedu.util.FileUploadUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * Created by jihoan on 2017. 7. 24..
 */
@Controller
public class FileController {

    @RequestMapping(value = "/fileUpload.do", method = RequestMethod.POST)
    public Object fileUpload(MultipartHttpServletRequest request) {
        String fileName = FileUploadUtil.fileUploadYmdLocation(request, getFileUploadRoot());
        return fileName;
    }

    public String getFileUploadRoot() {
        return FileUploadConfigHolder.uploadRoot();
    }
}
