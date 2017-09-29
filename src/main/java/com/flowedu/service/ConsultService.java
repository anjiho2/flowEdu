package com.flowedu.service;

import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.ConsultMapper;
import com.flowedu.session.UserSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by jihoan on 2017. 9. 29..
 */
@Service
public class ConsultService {

    @Autowired
    private ConsultMapper consultMapper;

    @Transactional(propagation = Propagation.REQUIRED)
    public void saveEarlyConsultMemo(String phoneNumber, String memoType, String content) {
        if ("".equals(phoneNumber)) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        Long memberId = UserSession.flowMemberId();
        consultMapper.saveEarlyConsultMemo(phoneNumber, memoType, content, memberId);
    }

}
