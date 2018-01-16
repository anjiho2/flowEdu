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

    @Autowired
    private AcademyService academyService;

    /**
     * <PRE>
     * 1. Comment : 유저가 있는지 확인
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @param memberId
     * @param password
     * @return {유저가 있으면 FlowEduMemberDto, 없으면 null}
     * @throws Exception
     */
    @Transactional(readOnly = true)
    public FlowEduMemberDto isMember(String memberId, String password, String connectIp) throws Exception {
        FlowEduMemberDto dto = new FlowEduMemberDto();
        FlowEduMemberDto dto2 = new FlowEduMemberDto();
        Long flowMemberId = loginMapper.findFlowEduMember(memberId, Aes256.encrypt(password));
        if (flowMemberId != null) {
            dto = memberMapper.getFlowEduMemberCheck(flowMemberId);
            String academyThumbnail = academyService.getAcademyThumbnailUrl(dto.getOfficeId());
            UserSession.set(
            new FlowEduMemberDto(
                    dto.getFlowMemberId(),
                    dto.getMemberType(),
                    dto.getMemberName(),
                    dto.getOfficeId(),
                    academyThumbnail
                )
            );
            dto2.setFlowMemberId(dto.getFlowMemberId());
            dto2.setPhoneNumber(dto.getPhoneNumber());
            dto2.setOfficeId(dto.getOfficeId());
            dto2.setTeamId(dto.getTeamId());
            dto2.setMemberName(dto.getMemberName());
            dto2.setMemberType(dto.getMemberType());
            dto2.setAcademyThumbnail(academyThumbnail);

            logService.memberLoginLog(dto, connectIp);
            return dto2;
        }
        return dto2;
    }

}
