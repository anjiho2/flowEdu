package com.flowedu.domain;

import lombok.Data;

/**
 * Created by jihoan on 2017. 10. 18..
 */
@Data
public class RequestApi {

    private String body;

    private int httpStatusCode;

    public RequestApi(String body, int httpStatusCode) {
        this.body = body;
        this.httpStatusCode = httpStatusCode;
    }
}
