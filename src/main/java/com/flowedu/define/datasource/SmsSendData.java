package com.flowedu.define.datasource;

public enum SmsSendData {

    LECTURE_ATTEND("0"),   //등원
    LECUTRE_LATE("1"),      //지각
    LECTURE_ABSENT("2"),    //결석
    LECTURE_LEAVE("3"),     //조퇴
    LECTURE_MAKEUP("4"),    //보강
    LECTURE_DISMISS("5");   //하원

    String smsSendTypeId;

    SmsSendData(String smsSendTypeId) {
        this.smsSendTypeId = smsSendTypeId;
    }

    public static String getSmsSendType(String smsSendTypeId) {
        for (SmsSendData sendData : SmsSendData.values()) {
            if (sendData.smsSendTypeId.equals(smsSendTypeId)) {
                return sendData.name();
            }
        }
        return null;
    }

}
