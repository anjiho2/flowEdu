package com.flowedu.controller;

import com.flowedu.dto.FlowEduMemberDto;
import com.flowedu.session.UserSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RequestMapping("/session")
@Controller
public class SessionController {

    private static final Logger logger = LoggerFactory.getLogger(SessionController.class);

    /**
     * <PRE>
     * 1. Comment : 상단메뉴 관변경하기(세션 값 변경)
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 04 .01
     * </PRE>
     * @param request
     * @return
     */
    @RequestMapping(value = "/change", method = RequestMethod.POST)
    public ResponseEntity chageSession(HttpServletRequest request) {
        Long officeId = Long.valueOf(request.getParameter("office_id"));
        HttpSession session = request.getSession();
        FlowEduMemberDto memberDto = UserSession.get();
        FlowEduMemberDto dto = new FlowEduMemberDto(
                memberDto.getFlowMemberId(),
                memberDto.getMemberType(),
                memberDto.getMemberName(),
                officeId,
                memberDto.getAcademyThumbnail()
        );
        UserSession.set(dto);
        session.setAttribute("member_info", dto);
        session.setMaxInactiveInterval(60*60);
        logger.info("new_session >>> " + UserSession.get());
        return new ResponseEntity("OK", HttpStatus.OK);
    }
}
