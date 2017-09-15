package com.flowedu.define.datasource;

/**
 * Created by jihoan on 2017. 8. 8..
 */
public enum SchoolType {
    ELEMENT(0, "초등학교"),
    MIDDLE(1, "중학교"),
    HIGH(2, "고등학교");

    int schoolTypeCode;

    String schoolTypeName;

    SchoolType(int schoolTypeCode, String schoolTypeName) {
        this.schoolTypeCode = schoolTypeCode;
        this.schoolTypeName = schoolTypeName;
    }

    public static SchoolType getSchoolTypeCode(int schoolTypeCode) {
        for (SchoolType type : SchoolType.values()) {
            if (type.schoolTypeCode == schoolTypeCode) {
                return type;
            }
        }
        return null;
    }

    public static String getSchoolTypeName(int schoolTypeCode) {
        for (SchoolType type : SchoolType.values()) {
            if (type.equals(getSchoolTypeCode(schoolTypeCode))) {
                return type.schoolTypeName.toString();
            }
        }
        return null;
    }

    public static int size() {
        return SchoolType.values().length;
    }
}
