package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 8. 16..
 */
public enum LectureLevel {
    HIGH(0, "상"),
    MIDDLE(1, "중"),
    LOW(2, "하");

    int lectureLevelCode;

    String lectureLevelName;

    LectureLevel(int lectureLevelCode, String lectureLevelName) {
        this.lectureLevelCode = lectureLevelCode;
        this.lectureLevelName = lectureLevelName;
    }

    public static LectureLevel getLectureLevelCode(int lectureLevelCode) {
        for (LectureLevel level : LectureLevel.values()) {
            if (level.lectureLevelCode == lectureLevelCode) {
                return level;
            }
        }
        return null;
    }

    public static String getLectureLevelName(int lectureLevelCode) {
        for (LectureLevel level : LectureLevel.values()) {
            if (level.equals(getLectureLevelCode(lectureLevelCode))) {
                return level.lectureLevelName.toString();
            }
        }
        return null;
    }

    public static int size() {
        return LectureLevel.values().length;
    }
}
