package com.flowedu.define.datasource;

import com.flowedu.dto.MemberTypeDto;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by jihoan on 2017. 8. 4..
 */
public enum MemberType {
    OPERATOR(1, "운영자"),
    TEACHER(2, "담임 선생님"),
    TEACHER_MANAGE(3, "관리 선생님"),
    ADMIN(4, "관리자");

    int memberTypeCode;

    String memberTypeName;

    MemberType(int memberTypeCode, String memberTypeName) {
        this.memberTypeCode = memberTypeCode;
        this.memberTypeName = memberTypeName;
    }

    public static MemberType getMemberTypeCode(int memberTypeCode) {
        for (MemberType type : MemberType.values()) {
            if (type.memberTypeCode == memberTypeCode) {
                return type;
            }
        }
        return null;
    }

    public static String getMemberTypeName(int memberTypeCode) {
        for (MemberType type : MemberType.values()) {
            if (type.equals(getMemberTypeCode(memberTypeCode))) {
                return type.memberTypeName.toString();
            }
        }
        return null;
    }

    public static int size() {
        return MemberType.values().length;
    }

    @Override
    public String toString() {
        return super.toString();
    }
}
