package com.flowedu.mapper;

import com.flowedu.dto.FlowEduMemberDto;
import org.apache.ibatis.annotations.Param;

/**
 * Created by jihoan on 2017. 8. 4..
 */
public interface MemberMapper {

    /** SELECT **/
    FlowEduMemberDto getFlowEduMember(@Param("flowMemberId") Long flowMemberId);

    /** INSERT **/
    void saveFlowEduMember(FlowEduMemberDto flowEduMemberDto);

    /** UPDATE **/
    void modifyFlowEduMember(FlowEduMemberDto flowEduMemberDto);

    /** DELETE **/
    void deleteFlowEduMember(@Param("flowMemberId") Long flowMemberId);
}
