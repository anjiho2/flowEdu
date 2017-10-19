package com.flowedu.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * Created by jihoan on 2017. 10. 12..
 */
@Component
public class SessionUseConfigHolder {

    private static SessionUseConfigHolder configHolder;

    @Value("#{config['session.use.yn']}")
    private boolean sessionUseYn;

    @PostConstruct
    private SessionUseConfigHolder init() {
        configHolder = this;
        return this;
    }

    public static boolean getSessionUseYn() {
        return configHolder.sessionUseYn;
    }
}
