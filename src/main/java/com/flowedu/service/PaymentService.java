package com.flowedu.service;

import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.PaymentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by jihoan on 2017. 9. 14..
 */
@Service
public class PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;

    @Transactional(propagation = Propagation.REQUIRED)
    public void paymentLecture(Long lectureRelId) {
        if (lectureRelId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        paymentMapper.paymentLecture(lectureRelId);
    }

}
