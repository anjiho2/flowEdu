package com.flowedu.service;

import com.flowedu.config.PagingSupport;
import com.flowedu.define.datasource.MemberType;
import com.flowedu.dto.*;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.MemberMapper;
import com.flowedu.mapper.OfficeMapper;
import com.flowedu.session.UserSession;
import com.flowedu.util.Aes256;
import com.flowedu.util.RandomMake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by jihoan on 2017. 8. 4..
 */
@Service
public class MemberService extends PagingSupport {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private OfficeMapper officeMapper;

    @Autowired
    private EmailService emailService;

    /**
     * <PRE>
     * 1. Comment : 멤버 타입 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .04
     * </PRE>
     * @return
     * [
     *  {memberTypeCode:"OPERATOR", memberTypeName:"운영자"},
     *  ...
     * ]
     */
    public List<MemberTypeDto> getMemberType() {
        List<MemberTypeDto> Arr = new ArrayList<>();
        for (int i=1; i< MemberType.size()+1; i++) {
            MemberTypeDto memberTypeDto = new MemberTypeDto(
                    MemberType.getMemberTypeCode(i).toString(),
                    MemberType.getMemberTypeName(i)
            );
            Arr.add(memberTypeDto);
        }
        return Arr;
    }

    /**
     * <PRE>
     * 1. Comment : 멤버 정보 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .04
     * </PRE>
     * @param flowMemberId
     * @return
     */
    @Transactional(readOnly = true)
    public List<FlowEduMemberListDto> getFlowEduMember(Long flowMemberId) {
        if (flowMemberId == null || flowMemberId == 0L) {
            throw new FlowEduException(FlowEduErrorCode.INTERNAL_ERROR);
        }
        return memberMapper.getFlowEduMember(flowMemberId);
    }

    /**
     * <PRE>
     * 1. Comment : 페이징 관련 멤버 개수 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @return Integer
     */
    @Transactional(readOnly = true)
    public int getFlowEduMemberListCount() {
        return memberMapper.getFlowEduMemberListCount();
    }

    /**
     * <PRE>
     * 1. Comment : 페이징 관련 멤버 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @param sPage
     * @param pageListCount
     * @return FlowEduMemberListDto
     */
    @Transactional(readOnly = true)
    public List<FlowEduMemberListDto> getFlowEduMemberList(int sPage, int pageListCount) {
        PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        List<FlowEduMemberListDto> list = memberMapper.getFlowEduMemberList(pagingDto.getStart(), pageListCount);
        return list;
    }

    /**
     * <PRE>
     * 1. Comment : 팀 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @param teamId
     * @return
     */
    @Transactional(readOnly = true)
    public List<FlowEduTeamDto> getFlowEduTeamList(Integer teamId) {
        return officeMapper.getFlowEduTeamList(teamId);
    }

    /**
     * <PRE>
     * 1. Comment : 직책 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @return
     */
    @Transactional(readOnly = true)
    public List<JobPositionDto> getJobPositionList() {
        return memberMapper.getJobPositionList();
    }

    /**
     * <PRE>
     * 1. Comment : 핸드폰 중복된 멤버가 있는지 확인
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @param phoneNumber
     * @return 있으면 false, 없으면 true
     */
    @Transactional(readOnly = true)
    public boolean isMember(String phoneNumber) {
        if ("".equals(phoneNumber)) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        int memberCount = memberMapper.getMemberCount(phoneNumber, "");
        if (memberCount == 0) {
            return false;
        }
        return true;
    }

    @Transactional(readOnly = true)
    public boolean isMemberByPassword(String phoneNumber, String password) throws Exception {
        if ("".equals(phoneNumber)) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        int memberCount = memberMapper.getMemberCount(phoneNumber, Aes256.encrypt(password));
        if (memberCount == 0) {
            return false;
        }
        return true;
    }

    /**
     * <PRE>
     * 1. Comment : 선생님 리스트 받아오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .16
     * </PRE>
     * @param officeId
     * @return
     */
    @Transactional(readOnly = true)
    public List<FlowEduMemberDto> getTeacherList(Long officeId) {
        if (officeId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        return memberMapper.getTeacherList(officeId);
    }

    /**
     * <PRE>
     * 1. Comment : 사용자 정보 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .16
     * </PRE>
     * @param flowMemberId
     * @return
     */
    @Transactional(readOnly = true)
    public FlowEduMemberDto getFlowEduMemberCheck(Long flowMemberId) {
        return memberMapper.getFlowEduMemberCheck(flowMemberId);
    }

    /**
     * <PRE>
     * 1. Comment : 비밀번호 찾기 후 임시비밀번호 발급하기(memberId : 핸드폰번호, 키값)
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 01 .16
     * </PRE>
     * @param memberId
     * @param email
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public String findFlowEduMemberPassword(String memberId, String email) throws Exception {
        Long findMemberId = memberMapper.findFlowEduMember(memberId, "", email);
        if (findMemberId != null) {
            String changePassword = RandomMake.getRandomPassword();
            memberMapper.modifyFlowMemberPassword(findMemberId, Aes256.encrypt(changePassword));
            return changePassword;
        }
        return null;
    }

    /**
     * <PRE>
     * 1. Comment : 회원 아이디 찾기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 01 .16
     * </PRE>
     * @param memberName
     * @param email
     * @return
     * @throws Exception
     */
    @Transactional(readOnly = true)
    public boolean findFlowEduMemberId(String memberName, String email) throws Exception {
        Integer memberCount = memberMapper.findFlowEudMemberByCount(memberName, email);
        if (memberCount == 0 || memberCount == null) return false;

        Long memberId = memberMapper.findFlowEudMemberId(memberName, email);
        //메일로 보낼 내용 조회
        FlowEduMemberDto memberDto = memberMapper.getFlowEduMemberCheck(memberId);
        //이메일 발송
        EmailSendDto emailSendDto = new EmailSendDto(
                "플로우 교육 아이디 안내 이메일",
                memberDto,
                memberDto.getMemberEmail(),
                null
        );
        emailService.SendEMail(emailSendDto);
        return true;
    }

    /**
     * <PRE>
     * 1. Comment : 운영자, 선생님정보 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .04
     * </PRE>
     * @param officeId
     * @param teamId
     * @param phoneNumber
     * @param memberPassword
     * @param memberName
     * @param memberBirthDay
     * @param memberAddress
     * @param memeberEmail
     * @param sexualAssultConfirmDate
     * @param educationRegDate
     * @param memberType
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveFlowEduMember(Long officeId, Integer teamId, Integer jobPositionId, String phoneNumber, String memberPassword, String memberName,
        String memberBirthDay, String memberAddress, String memeberEmail, String sexualAssultConfirmDate,
        String educationRegDate, String memberType) throws Exception {
        if (officeId == null) {
            throw new FlowEduException(FlowEduErrorCode.INTERNAL_ERROR);
        }
        FlowEduMemberDto dto = new FlowEduMemberDto(
            officeId, teamId, jobPositionId,  phoneNumber,  memberName, memberBirthDay, memberAddress,
                memberPassword, memeberEmail, sexualAssultConfirmDate, educationRegDate, memberType
        );
        memberMapper.saveFlowEduMember(dto);
    }

    /**
     * <PRE>
     * 1. Comment : 운영자, 선생님정보 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .04
     * </PRE>
     * @param flowMemberId
     * @param officeId
     * @param teamId
     * @param phoneNumber
     * @param memberPassword
     * @param memberName
     * @param memberBirthDay
     * @param memberAddress
     * @param memeberEmail
     * @param sexualAssultConfirmDate
     * @param educationRegDate
     * @param memberType
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyFlowEduMember(Long flowMemberId, Long officeId, Integer teamId, Integer jobPositionId, String phoneNumber,
        String memberPassword, String memberName, String memberBirthDay, String memberAddress, String memeberEmail,
        String sexualAssultConfirmDate, String educationRegDate, String memberType) throws Exception {
        if (flowMemberId == null || flowMemberId == 0L) {
            throw new FlowEduException(FlowEduErrorCode.INTERNAL_ERROR);
        }
        FlowEduMemberDto dto = new FlowEduMemberDto(
                flowMemberId, officeId, teamId, jobPositionId, phoneNumber,  memberName, memberBirthDay, memberAddress,
                memberPassword, memeberEmail, sexualAssultConfirmDate, educationRegDate, memberType
        );
        memberMapper.modifyFlowEduMember(dto);
    }

    /**
     * <PRE>
     * 1. Comment : 비밀번호 변경하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 09 .15
     * </PRE>
     * @param phoneNumber
     * @param existPassword
     * @param modifyPassword
     * @return ( 1 : 기존 비밀번호가 틀렸을때, 0 : 변경 성공 )
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int modifyFlowMemberPassword(String phoneNumber, String existPassword, String modifyPassword) throws Exception {
        if ("".equals(phoneNumber)) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        Long memberId = memberMapper.findFlowEduMember(phoneNumber, Aes256.encrypt(existPassword), "");
        if (memberId == null) {
            return 1;
        }
        memberMapper.modifyFlowMemberPassword(memberId, Aes256.encrypt(modifyPassword));
        return 0;
    }

    /**
     * <PRE>
     * 1. Comment : 운영자, 선생님정보 삭제
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .04
     * </PRE>
     * @param flowMemberId
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteFlowEduMember(Long flowMemberId) {
        if (flowMemberId == null || flowMemberId == 0L) {
            throw new FlowEduException(FlowEduErrorCode.INTERNAL_ERROR);
        }
        memberMapper.deleteFlowEduMember(flowMemberId);
    }
}
