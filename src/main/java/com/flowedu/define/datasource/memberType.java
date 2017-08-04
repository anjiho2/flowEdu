package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 8. 4..
 */
public enum memberType {
    ADMIN(0), TEACHER(1);

    private int memberTypeCode;

    memberType(int memberTypeCode) {
        this.memberTypeCode = memberTypeCode;
    }
}
