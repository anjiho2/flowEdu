package com.flowedu.define.datasource;

import com.flowedu.util.DateUtils;
import com.flowedu.util.Util;

/**
 * Created by jihoan on 2017. 8. 9..
 */
public enum LectureDay {
    SUN(0, "일요일"),
    MON(1, "월요일"),
    TUE(2, "화요일"),
    WEN(3, "수요일"),
    THU(4, "목요일"),
    FRI(5, "금요일"),
    SAT(6, "토요일");


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

    public static Integer getLectureDayCode(String lectureDayName) {
        for (LectureDay lectureDay : LectureDay.values()) {
            if (lectureDay.toString().equals(lectureDayName)) {
                return lectureDay.lectureDayCode;
            }
        }
        return null;
    }

    public static String getDay() throws Exception {
        return getLectureDayCode( DateUtils.getDateDay( Util.returnToDate("yyyy-MM-dd"), "yyyy-MM-dd" ) - 1 ).toString();
    }

    public static int size() {
        return LectureDay.values().length;
    }
}
