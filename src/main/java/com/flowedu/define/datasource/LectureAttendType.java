package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 8. 29..
 */
public enum LectureAttendType {
    ATTEND(0, "출석"),
    LATE(1, "지각"),
    ABSENT(2, "결석"),
    LEAVE(3, "조퇴"),
    MAKEUP(4, "보강출석"),
    DISMISS(5, "하원")
    ;

    int attendTypeCode;

    String attendTypeName;

    LectureAttendType(int attendTypeCode, String attendTypeName) {
        this.attendTypeCode = attendTypeCode;
        this.attendTypeName = attendTypeName;
    }

    public static LectureAttendType getLectureAttendTypeCode(int attendTypeCode) {
        for (LectureAttendType attendType : LectureAttendType.values()) {
            if (attendType.attendTypeCode == attendTypeCode) {
                return attendType;
            }
        }
        return null;
    }

    public static String getLectureAttendTypeName(int attendTypeCode) {
        for (LectureAttendType attendType : LectureAttendType.values()) {
            if (attendType.equals(getLectureAttendTypeCode(attendTypeCode))) {
                return attendType.attendTypeName.toString();
            }
        }
        return null;
    }
}
