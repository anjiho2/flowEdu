package com.flowedu.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * Created by jihoan on 2017. 10. 16..
 */
@Component
public class FlowEduApiConfigHolder {

    private static FlowEduApiConfigHolder configHolder;

    @Value("#{config['flowedu.api.url']}")
    private String floweduApiUrl;

    @PostConstruct
    private FlowEduApiConfigHolder init() {
        configHolder = this;
        return this;
    }

    public static String getFlowEduApiUrl() {
        return configHolder.floweduApiUrl;
    }
}
