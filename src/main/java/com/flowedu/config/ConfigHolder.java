package com.flowedu.config;

import org.springframework.beans.factory.annotation.Value;

import javax.annotation.PostConstruct;

/**
 * Created by jihoan on 2017. 11. 2..
 */
public class ConfigHolder {

    private static ConfigHolder config;

    @Value("#{config['service.isQuartzUseCheck']}")
    private boolean isQuartzUseCheck;
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

    @PostConstruct
    private ConfigHolder init() {
        config = this;
        return this;
    }

    public static boolean isQuartzUseCheck() {
        return config.isQuartzUseCheck;
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

}
