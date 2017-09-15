package com.flowedu.service;

import com.flowedu.define.datasource.DataSource;
import com.flowedu.define.datasource.DataSourceType;
import com.flowedu.dto.FlowEduMemberDto;
import com.flowedu.dto.LecturePaymentLogDto;
import com.flowedu.dto.LectureStudentRelByIdDto;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.LectureMapper;
import com.flowedu.mapper.PaymentMapper;
import com.flowedu.session.UserSession;
import lombok.Data;
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

    @Autowired
    private LectureMapper lectureMapper;

    @Autowired
    private LogService logService;

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void paymentLecture(Long lectureRelId, String studentName, int paymentPrice) {
        if (lectureRelId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        int result = paymentMapper.paymentLecture(lectureRelId);
        LectureStudentRelByIdDto dto = lectureMapper.getLectureStudentRelInfo(lectureRelId);
        if (result == 0 || dto == null) return;
        LecturePaymentLogDto paymentLogDto = new LecturePaymentLogDto(
                dto.getLectureName(), paymentPrice, studentName, UserSession.memberName()
        );
        logService.lecturePaymentLog(paymentLogDto);
    }

}
