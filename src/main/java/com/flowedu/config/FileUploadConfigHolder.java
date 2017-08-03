package com.flowedu.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;


/**
 * Created by jihoan on 2017. 7. 24..
 * * <pre>
 * 1. Comment : Settings.xml의 파일 업로드 경로 가져오는 Config
 * 2. 작성자 : 안지호
 * 3. 작성일 : 2017. 07. 26
 * </pre>
 */
@Component
public class FileUploadConfigHolder {

    private static FileUploadConfigHolder config;

    @Value("#{config['file.uploads.path']}")
    private String uploadRoot;

    @PostConstruct
    private FileUploadConfigHolder init() {
        config = this;
        return this;
    }

    public static String uploadRoot() {
        return config.uploadRoot;
    }

}
