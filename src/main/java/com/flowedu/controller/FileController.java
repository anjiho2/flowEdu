package com.flowedu.controller;

import com.flowedu.config.ConfigHolder;
import com.flowedu.service.LectureService;
import com.flowedu.util.FileUploadUtil;
import com.flowedu.util.JsonBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.Map;

/**
 * Created by jihoan on 2017. 7. 24..
 */
@Controller
@RequestMapping(value = "/file")
public class FileController {

    protected final static Logger logger = LoggerFactory.getLogger(FileController.class);

    @RequestMapping(value = "/upload.do", method = RequestMethod.POST)
    public @ResponseBody String fileUpload(MultipartHttpServletRequest request) {
        Map<String, Object> uploadInfoMap = FileUploadUtil.fileUploadYmdLocation(request, getFileUploadRoot());
        if (uploadInfoMap != null) {
            return new JsonBuilder().add("result", uploadInfoMap).build();
        }
        return new JsonBuilder().add("result", null).build();
    }

    /**
     * <PRE>
     * 1. Comment : 과제파일 업로드
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 01 .30
     * </PRE>
     * @param request
     * @param lectureId
     * @return
     */
    @RequestMapping(value = "/assignment_upload.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
    public @ResponseBody String assignmentFileUpload(MultipartHttpServletRequest request,
                                                     @RequestParam(value = "lecture_id") Long lectureId) {
        Map<String, Object> resultInfo = FileUploadUtil.fileUploadAssignmentFile(request, getAssignmentUploadPath(), lectureId);
        if (resultInfo != null) {
            return new JsonBuilder().add("result", resultInfo).build();
        }
        return new JsonBuilder().add("result", null).build();
    }

    /**
     * <PRE>
     * 1. Comment : 학원 증명서 파일 업로드
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 01 .30
     * </PRE>
     * @param request
     * @return
     */
    @RequestMapping(value = "/certificate_upload.do", method = RequestMethod.POST)
    public @ResponseBody String certificateFileUpload(MultipartHttpServletRequest request) throws Exception {
        ///Users/jihoan/Downloads // /var/www/html/download/cetificate
        Map<String, Object> resultInfo = FileUploadUtil.fileUploadCertificateFile(request, ConfigHolder.getCertificateUploadsPath());
        if (resultInfo != null) {
            return new JsonBuilder().add("result", resultInfo).build();
        }
        return new JsonBuilder().add("result", null).build();
    }

    private String getFileUploadRoot() {
        return ConfigHolder.uploadRoot();
    }

    private String getAssignmentUploadPath() {
        return ConfigHolder.getAssignmentUploadsPath();
    }
}
