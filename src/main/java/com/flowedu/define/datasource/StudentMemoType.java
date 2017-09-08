package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 9. 8..
 */
public enum StudentMemoType {
    REG(0, "등록"),
    NORAML(1, "일반"),
    STUDY(2, "학습"),
    PERIOD(3, "정기");

    int studentMemoTypceCode;

    String studentMemoTypeName;

    StudentMemoType(int studentMemoTypceCode, String studentMemoTypeName) {
        this.studentMemoTypceCode = studentMemoTypceCode;
        this.studentMemoTypeName = studentMemoTypeName;
    }

    public static StudentMemoType getStudentMemoTypeCode(int studentMemoTypceCode) {
        for (StudentMemoType type : StudentMemoType.values()) {
            if (type.studentMemoTypceCode == studentMemoTypceCode) {
                return type;
            }
        }
        return null;
    }

    public static String getStudentMemoTypeName(int studentMemoTypceCode) {
        for (StudentMemoType type : StudentMemoType.values()) {
            if (type.equals(getStudentMemoTypeCode(studentMemoTypceCode))) {
                return type.studentMemoTypeName.toString();
            }
        }
        return null;
    }
}
