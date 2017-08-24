package com.flowedu.domain;

/**
 * Created by jihoan on 2017. 8. 24..
 */
public interface MemberNameContain {

    Long manageMemberId();

    Long chargeMemberId();

    void addManageMemberName(MemberIdName memberIdName);

    void addChargeMamberName(MemberIdName memberIdName);
}
