package com.flowedu.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;


/**
 * Created by jihoan on 2017. 7. 24..
 */
@Component
public class FileUploadConfigHolder {

    private static FileUploadConfigHolder config;

    @Value("#{config['service.uploadRoot']}")
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
