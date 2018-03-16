package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 10. 17..
 */
public enum RequestMethod {

    REQUEST_METHOD_POST(1),
    REQUEST_METHOD_GET(2),
    REQUEST_METHOD_DELETE(3),
    REQUEST_METHOD_PUT(4);

    int requestMethod;

    RequestMethod(int requestMethod) {
        this.requestMethod = requestMethod;
    }

}
