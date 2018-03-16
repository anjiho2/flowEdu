package com.flowedu.mapper;

import com.flowedu.dto.FlowEduMemberDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 7. 6..
 */
public interface LoginMapper {

    FlowEduMemberDto findFlowEduMemberByMemberId(@Param("memberId") String memberId);

}
