package com.flowedu.repository;

import com.flowedu.domain.MemberNameContain;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 24..
 */
public interface MemberNameRepository {

    void fillMemberNameAny(List<?> memberNameAny);

    void fillMemberNameContain(List<MemberNameContain> memberNameContains);
}
