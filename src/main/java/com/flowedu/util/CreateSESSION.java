package com.flowedu.util;

import com.flowedu.dto.FlowEduMemberDto;
import com.flowedu.mapper.MemberMapper;
import com.flowedu.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

@Component
public class CreateSESSION {
	
	final static Logger logger = LoggerFactory.getLogger(CreateSESSION.class);

	public static FlowEduMemberDto sessionCF(HttpServletRequest request) throws Exception {
		FlowEduMemberDto dto = new FlowEduMemberDto();
		dto.setFlowMemberId(Long.parseLong(request.getParameter("flow_member_id")));

		request.setAttribute("memberInfo", dto);
		return dto;
	}
}
