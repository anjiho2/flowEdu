package com.flowedu.service;

import com.flowedu.api.service.LogService;
import com.flowedu.dto.FlowEduMemberDto;
import com.flowedu.mapper.LoginMapper;
import com.flowedu.mapper.MemberMapper;
import com.flowedu.session.UserSession;
import com.flowedu.util.Aes256;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by jihoan on 2017. 7. 6..
 */
@Service
public class LoginService {

    @Autowired
    private LoginMapper loginMapper;

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private LogService logService;

    /**
     * <PRE>
     * 1. Comment : 유저가 있는지 확인
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @param phoneNumber
     * @param password
     * @param memberType
     * @return {유저가 있으면 FlowEduMemberDto, 없으면 null}
     * @throws Exception
     */
    @Transactional(readOnly = true)
    public FlowEduMemberDto isMember(String phoneNumber, String password, String memberType, String connectIp) throws Exception {
        FlowEduMemberDto dto = new FlowEduMemberDto();
        Long flowMemberId = loginMapper.findFlowEduMember(phoneNumber, Aes256.encrypt(password), memberType);
        if (flowMemberId != null) {
            dto = memberMapper.getFlowEduMemberCheck(flowMemberId);
            UserSession.set(
            new FlowEduMemberDto(
                    dto.getFlowMemberId(),
                    dto.getMemberType(),
                    dto.getMemberName(),
                    dto.getOfficeId()
                )
            );
            logService.memberLoginLog(dto, connectIp);
            return dto;
        }
        return dto;
    }

}
