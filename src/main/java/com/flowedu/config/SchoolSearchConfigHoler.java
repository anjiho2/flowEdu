package com.flowedu.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * Created by jihoan on 2017. 8. 14..
 */
@Component
public class SchoolSearchConfigHoler {

    private static SchoolSearchConfigHoler configHoler;

    @Value("#{config['school.search.api.key']}")
    private String schoolSearchApiKey;

    @Value("#{config['school.search.api.url']}")
    private String getSchoolSearchApiUrl;

    @PostConstruct
    private SchoolSearchConfigHoler init() {
        configHoler = this;
        return this;
    }

    public static String getSchoolSearchApiKey() {
        return configHoler.schoolSearchApiKey;
    }

    public static String getSchoolSearchApiUrl() {
        return configHoler.getSchoolSearchApiUrl;
    }

}
