package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 8. 14..
 */
public enum LectureOperationType {
    MONTH(0, "월"),
    NUMBER(1, "횟수");

    int lectureOperationTypeCode;

    String lectureOperationTypeName;

    LectureOperationType(int lectureOperationTypeCode, String lectureOperationTypeName) {
        this.lectureOperationTypeCode = lectureOperationTypeCode;
        this.lectureOperationTypeName = lectureOperationTypeName;
    }

    public static LectureOperationType getLectureOpeationTypeCode(int lectureOperationTypeCode) {
        for (LectureOperationType type : LectureOperationType.values()) {
            if (type.lectureOperationTypeCode == lectureOperationTypeCode) {
                return type;
            }
        }
        return null;
    }

    public static String getLectureOperationTypeName(int lectureOperationTypeCode) {
        for (LectureOperationType type : LectureOperationType.values()) {
            if (type.equals(getLectureOpeationTypeCode(lectureOperationTypeCode))) {
                return type.lectureOperationTypeName.toString();
            }
        }
        return null;
    }

    public static int size() {
        return LectureOperationType.values().length;
    }

}
