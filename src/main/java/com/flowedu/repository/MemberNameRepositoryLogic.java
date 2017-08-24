package com.flowedu.repository;

import com.flowedu.domain.MemberIdName;
import com.flowedu.domain.MemberNameContain;
import com.flowedu.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * <PRE>
 *     담임 선생님, 관리자 선생님 이름을 주입해주는 클래스
 * </PRE>
 * Created by jihoan on 2017. 8. 24..
 */
@Repository
public class MemberNameRepositoryLogic implements MemberNameRepository {

    @Autowired
    private MemberMapper memberMapper;

    @Override
    public void fillMemberNameAny(List<?> memberNameAny) {
        if (memberNameAny == null || memberNameAny.size() == 0) return;

        List<MemberNameContain> contains = memberNameAny
                                                .stream()
                                                .filter(Objects::nonNull)
                                                .filter(any->any instanceof MemberNameContain)
                                                .map(any->(MemberNameContain)any)
                                                .collect(Collectors.toList());
        this.fillMemberNameContain(contains);
    }

    @Override
    public void fillMemberNameContain(List<MemberNameContain> memberNameContains) {
        if (memberNameContains == null || memberNameContains.size() == 0) return;

        List<MemberNameContain> fillable = memberNameContains
                                                .stream()
                                                .filter(Objects::nonNull)
                                                .collect(Collectors.toList());
        List<Long> chargeMemberIds = fillable
                                    .stream()
                                    .map(MemberNameContain::chargeMemberId)
                                    .filter(Objects::nonNull)
                                    .distinct()
                                    .collect(Collectors.toList());

        List<Long> manageMemberIds = fillable
                .stream()
                .map(MemberNameContain::manageMemberId)
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());
        if (chargeMemberIds.size() == 0 && manageMemberIds.size() == 0) return;

        List<MemberIdName> manageMemberNameList = memberMapper.getMemberIdNameByMemberIds(manageMemberIds);
        List<MemberIdName> chargeMemberNameList = memberMapper.getMemberIdNameByMemberIds(chargeMemberIds);

        for (MemberNameContain contain : fillable) {
            for (MemberIdName name : manageMemberNameList) {
                if (name.getMemberId() == contain.manageMemberId()) {
                    contain.addManageMemberName(name);
                }
                for (MemberIdName name2 : chargeMemberNameList) {
                    if (name2.getMemberId() == contain.chargeMemberId()) {
                        contain.addChargeMamberName(name2);
                    }
                }
            }
        }
    }
}
