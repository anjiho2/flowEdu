package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 8. 14..
 */
public enum LectureStatus {
    OPEN(0, "개강"),
    CANCEL(1, "휴강"),
    CLOSE(2, "폐강"),
    WAIT(3, "대기")
    ;

    int lectureStatusCode;

    String lectureStatusName;

    LectureStatus(int lectureStatusCode, String lectureStatusName) {
        this.lectureStatusCode = lectureStatusCode;
        this.lectureStatusName = lectureStatusName;
    }

    public static LectureStatus getLectureStatusCode(int lectureStatusCode) {
        for (LectureStatus status : LectureStatus.values()) {
            if (status.lectureStatusCode == lectureStatusCode) {
                return status;
            }
        }
        return null;
    }

    public static String getLectureStatusName(int lectureStatusCode) {
        for (LectureStatus status : LectureStatus.values()) {
            if (status.equals(getLectureStatusCode(lectureStatusCode))) {
                return status.lectureStatusName.toString();
            }
        }
        return null;
    }

    public static int size() {
        return LectureStatus.values().length;
    }

}
