package com.flowedu.service;

import com.flowedu.dto.FlowEduMemberDto;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by jihoan on 2017. 8. 4..
 */
@Service
public class MemberService {

    @Transactional(propagation = Propagation.REQUIRED)
    public void saveFlowEduMember(String officeCode, String phoneNumber, String memberPassword, String memberName, String memberType) throws Exception {
        FlowEduMemberDto dto = new FlowEduMemberDto(
            officeCode, phoneNumber, memberPassword, memberName, memberType
        );

    }
}
