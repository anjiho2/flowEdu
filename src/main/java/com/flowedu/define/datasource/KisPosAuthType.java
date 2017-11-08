package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 11. 8..
 */
public enum KisPosAuthType {
    D1("신용승인"),
    D2("신용취소"),
    CC("현금영수증승인"),
    CR("현금영수증취소");

    String authName;

    KisPosAuthType(String authName) {
        this.authName = authName;
    }

    public static String getKisPosAuthTypeName(KisPosAuthType kisPosAuthType) {
        for (KisPosAuthType authType : KisPosAuthType.values()) {
            if (authType.toString().equals(kisPosAuthType.toString())) {
                return authType.authName;
            }
        }
        return null;
    }
}
