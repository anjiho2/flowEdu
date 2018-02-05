package com.flowedu.util;

import com.flowedu.dto.FlowEduMemberDto;
import com.flowedu.mapper.MemberMapper;
import com.flowedu.service.AcademyService;
import com.flowedu.service.MemberService;
import com.flowedu.session.UserSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

@Component
public class CreateSESSION {
	
	final static Logger logger = LoggerFactory.getLogger(CreateSESSION.class);

	@Autowired
	private AcademyService academyService;

	public static FlowEduMemberDto sessionCF(HttpServletRequest request) throws Exception {
		FlowEduMemberDto dto = new FlowEduMemberDto();
		dto.setFlowMemberId(Long.parseLong(request.getParameter("flow_member_id")));
		dto.setOfficeId(Long.parseLong(request.getParameter("office_id")));
		//dto.setTeamId(Integer.parseInt(request.getParameter("team_id")));
		dto.setPhoneNumber(request.getParameter("phone_number"));
		dto.setMemberName(request.getParameter("member_name"));
		dto.setMemberType(request.getParameter("member_type"));
		dto.setAcademyThumbnail(request.getParameter("academy_thumbnail"));

		logger.info("sesssion_info >>> " + dto);

		UserSession.set(dto);

		request.setAttribute("memberInfo", dto);
		return dto;
	}
}
