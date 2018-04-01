package com.flowedu.filter;

import com.flowedu.dto.FlowEduMemberDto;
import com.flowedu.service.AcademyService;
import com.flowedu.service.MemberService;
import com.flowedu.session.UserSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.filter.DelegatingFilterProxy;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by jihoan on 2017. 8. 18..
 */
public class UserSessionFilter extends DelegatingFilterProxy {

    static final Logger logger = LoggerFactory.getLogger(UserSessionFilter.class);

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
        try {
            HttpServletRequest req = ((HttpServletRequest)request);
            MemberService memberService = findWebApplicationContext().getBean(MemberService.class);
            AcademyService academyService = findWebApplicationContext().getBean(AcademyService.class);

            FlowEduMemberDto dto = (FlowEduMemberDto)req.getSession().getAttribute("member_info");
            if (dto != null) {
                if (UserSession.get() == null) {
                    FlowEduMemberDto flowEduMemberDto = memberService.getFlowEduMemberCheck(dto.getFlowMemberId());
                    String academyThumbnail = academyService.getAcademyThumbnailUrl(flowEduMemberDto.getOfficeId());
                    UserSession.set(new FlowEduMemberDto(flowEduMemberDto.getFlowMemberId(), flowEduMemberDto.getMemberType(), flowEduMemberDto.getMemberName(), flowEduMemberDto.getOfficeId(), academyThumbnail));
                    logger.info("userSession >>>>>>>>>>>>>>> " + flowEduMemberDto);
                } else {
                    //관 변경시 세션의 관의 값을 변경한다. 2018. 04. 01 안지호
                    if (UserSession.officeId() != dto.getOfficeId()) {
                        String academyThumbnail = academyService.getAcademyThumbnailUrl(dto.getOfficeId());
                        UserSession.set(new FlowEduMemberDto(dto.getFlowMemberId(), dto.getMemberType(), dto.getMemberName(), dto.getOfficeId(), academyThumbnail));
                    }
                }
            }
            chain.doFilter(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void destroy() {
        //
    }
}
