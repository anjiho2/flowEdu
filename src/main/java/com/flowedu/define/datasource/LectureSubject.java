package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 8. 16..
 */
public enum LectureSubject {
    KOREAN(0, "국어"),
    ENGLISH(1, "영어"),
    MATH(2,"수학"),
    SCIENCE(3, "과학"),
    SOFTWARE(4, "소프트웨어");

    int lectureSubjectCode;

    String lectureSubjectName;

    LectureSubject(int lectureSubjectCode, String lectureSubjectName) {
        this.lectureSubjectCode = lectureSubjectCode;
        this.lectureSubjectName = lectureSubjectName;
    }

    public static LectureSubject getLectureSubjectCode(int lectureSubjectCode) {
        for (LectureSubject subject : LectureSubject.values()) {
            if (subject.lectureSubjectCode == lectureSubjectCode) {
                return subject;
            }
        }
        return null;
    }

    public static String getLectureSubjectName(int lectureSubjectCode) {
        for (LectureSubject subject : LectureSubject.values()) {
            if (subject.equals(getLectureSubjectCode(lectureSubjectCode))) {
                return subject.lectureSubjectName.toString();
            }
        }
        return null;
    }

    public static int size() {
        return LectureSubject.values().length;
    }
}
