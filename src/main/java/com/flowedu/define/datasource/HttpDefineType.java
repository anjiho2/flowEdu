package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 11. 20..
 */
public enum HttpDefineType {
    UTF_8("UTF-8"),
    CONTENT_TYPE("content-type"),
    APPLICATION_JSON("application/json");

    String property;

    HttpDefineType(String property) {
        this.property = property;
    }

    public String getProperty() {
        return this.property;
    }
}
