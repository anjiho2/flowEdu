package com.flowedu.session;

import com.flowedu.dto.FlowEduMemberDto;

/**
 * Created by jihoan on 2017. 8. 10..
 * 유저 세션 저장
 */
public class UserSession {

    private static ThreadLocal<FlowEduMemberDto> local = new ThreadLocal<>();

    public static void set(FlowEduMemberDto flowEduMemberDto) {
        local.set(flowEduMemberDto);
    }

    public static FlowEduMemberDto get() {
        return local.get();
    }

    public static Long flowMemberId() {
        return local.get().getFlowMemberId();
    }

    public static String memberType() {
        return local.get().getMemberType();
    }

    public static String memberName() {
        return local.get().getMemberName();
    }
}
