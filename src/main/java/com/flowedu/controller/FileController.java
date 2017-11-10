package com.flowedu.controller;

import com.flowedu.config.ConfigHolder;
import com.flowedu.util.FileUploadUtil;
import com.flowedu.util.JsonBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.Map;

/**
 * Created by jihoan on 2017. 7. 24..
 */
@Controller
@RequestMapping(value = "/file")
public class FileController {

    @RequestMapping(value = "/upload.do", method = RequestMethod.POST)
    public @ResponseBody String fileUpload(MultipartHttpServletRequest request) {
        Map<String, Object> uploadInfoMap = FileUploadUtil.fileUploadYmdLocation(request, getFileUploadRoot());
        if (uploadInfoMap != null) {
            return new JsonBuilder().add("result", uploadInfoMap).build();
        }
        return new JsonBuilder().add("result", null).build();
    }

    public String getFileUploadRoot() {
        return ConfigHolder.uploadRoot();
    }
}
