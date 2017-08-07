package com.flowedu.mapper;

import com.flowedu.dto.FlowEduMemberDto;
import com.flowedu.dto.FlowEduMemberListDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 4..
 */
public interface MemberMapper {

    /** SELECT **/
    FlowEduMemberDto getFlowEduMember(@Param("flowMemberId") Long flowMemberId);

    Integer getFlowEduMemberListCount();

    List<FlowEduMemberListDto> getFlowEduMemberList(@Param("start") int start, @Param("end") int end);

    /** INSERT **/
    void saveFlowEduMember(FlowEduMemberDto flowEduMemberDto);

    /** UPDATE **/
    void modifyFlowEduMember(FlowEduMemberDto flowEduMemberDto);

    /** DELETE **/
    void deleteFlowEduMember(@Param("flowMemberId") Long flowMemberId);
}
