package com.flowedu.config;

import org.springframework.beans.factory.annotation.Value;

import javax.annotation.PostConstruct;

/**
 * Created by jihoan on 2017. 11. 2..
 */
public class ConfigHolder {

    private static ConfigHolder config;

    @Value("#{config['file.uploads.path']}")
    private String uploadRoot;
    @Value("#{config['service.version']}")
    private String version;
    @Value("#{config['school.search.api.key']}")
    private String schoolSearchApiKey;
    @Value("#{config['school.search.api.url']}")
    private String getSchoolSearchApiUrl;
    @Value("#{config['flowedu.api.url']}")
    private String floweduApiUrl;
    @Value("#{config['session.use.yn']}")
    private boolean sessionUseYn;
    @Value("#{config['file.view.url']}")
    private String fileViewUrl;
    @Value("#{config['academy.thumbnail.url']}")
    private String academyThumbnailUrl;
    @Value("#{config['assignment.uploads.path']}")
    private String assignmentUploadsPath;
    @Value("#{config['certificate.uploads.path']}")
    private String certificateUploadsPath;

    @PostConstruct
    private ConfigHolder init() {
        config = this;
        return this;
    }

    public static String uploadRoot() {
        return config.uploadRoot;
    }

    public static String gerVersion() {
        return config.version;
    }

    public static String getSchoolSearchApiKey() {
        return config.schoolSearchApiKey;
    }

    public static String getSchoolSearchApiUrl() {
        return config.getSchoolSearchApiUrl;
    }

    public static String getFlowEduApiUrl() {
        return config.floweduApiUrl;
    }

    public static boolean getSessionUseYn() {
        return config.sessionUseYn;
    }

    public static String getFileViewUrl() {
        return config.fileViewUrl;
    }

    public static String getAcademyThumbnailUrl() {
        return config.academyThumbnailUrl;
    }

    public static String getAssignmentUploadsPath() {
        return config.assignmentUploadsPath;
    }

    public static String getCertificateUploadsPath() {
        return config.certificateUploadsPath;
    }

}
