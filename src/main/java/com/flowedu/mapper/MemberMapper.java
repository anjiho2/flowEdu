package com.flowedu.mapper;

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

    Integer getMemberCount(@Param("phoneNumber") String phoneNumber);

    /** INSERT **/
    void saveFlowEduMember(FlowEduMemberDto flowEduMemberDto);

    /** UPDATE **/
    void modifyFlowEduMember(FlowEduMemberDto flowEduMemberDto);

    /** DELETE **/
    void deleteFlowEduMember(@Param("flowMemberId") Long flowMemberId);
}
