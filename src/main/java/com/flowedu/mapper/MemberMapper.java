package com.flowedu.mapper;

import com.flowedu.domain.MemberIdName;
import com.flowedu.dto.FlowEduMemberDto;
import com.flowedu.dto.FlowEduMemberListDto;
import com.flowedu.dto.JobPositionDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 4..
 */
public interface MemberMapper {

    /** SELECT **/
    List<FlowEduMemberListDto> getFlowEduMember(@Param("flowMemberId") Long flowMemberId);

    FlowEduMemberDto getFlowEduMemberCheck(@Param("flowMemberId") Long flowMemberId);

    Integer getFlowEduMemberListCount();

    List<FlowEduMemberListDto> getFlowEduMemberList(@Param("start") int start, @Param("end") int end);

    List<JobPositionDto> getJobPositionList();

    Integer getMemberCount(@Param("phoneNumber") String phoneNumber, @Param("memberPass") String memberPass);

    List<FlowEduMemberDto> getTeacherList(@Param("officeId") Long officeId);

    List<MemberIdName> getMemberIdNameByMemberIds(@Param("memberIds") List<Long> memberIds);

    Long findFlowEduMember(@Param("phoneNumber") String phoneNumber, @Param("password") String password, @Param("email") String email);

    /** INSERT **/
    void saveFlowEduMember(FlowEduMemberDto flowEduMemberDto);

    /** UPDATE **/
    void modifyFlowEduMember(FlowEduMemberDto flowEduMemberDto);

    void modifyFlowMemberPassword(@Param("flowMemberId") Long flowMemberId, @Param("password") String password);

    /** DELETE **/
    void deleteFlowEduMember(@Param("flowMemberId") Long flowMemberId);
}
