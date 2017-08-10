package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 8. 9..
 */
public enum LectureDay {
    MON(0, "월요일"),
    TUE(1, "화요일"),
    WEN(2, "수요일"),
    THU(3, "목요일"),
    FRI(4, "금요일"),
    SAT(5, "토요일"),
    SUN(6, "일요일");

    int lectureDayCode;

    String lectureDayName;

    LectureDay(int lectureDayCode, String lectureDayName) {
        this.lectureDayCode = lectureDayCode;
        this.lectureDayName = lectureDayName;
    }

    public static LectureDay getLectureDayCode(int lectureDayCode) {
        for (LectureDay day : LectureDay.values()) {
            if (day.lectureDayCode == lectureDayCode) {
                return day;
            }
        }
        return null;
    }

    public static String getLectureDayName(int lectureDayCode) {
        for (LectureDay day : LectureDay.values()) {
            if (day.equals(getLectureDayCode(lectureDayCode))) {
                return day.lectureDayName.toString();
            }
        }
        return null;
    }

    public static int size() {
        return LectureDay.values().length;
    }
}
