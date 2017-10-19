package com.flowedu.service;

import com.flowedu.domain.RequestApi;
import com.flowedu.dto.LecturePaymentLogDto;
import com.flowedu.dto.LectureStudentRelByIdDto;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.LectureMapper;
import com.flowedu.mapper.PaymentMapper;
import com.flowedu.session.UserSession;

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

    /**
     * 결제하기 기능
     * @param lectureRelId
     * @param studentName
     * @param paymentPrice
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int paymentLecture(Long lectureRelId, String studentName, int paymentPrice) throws Exception {
        if (lectureRelId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        int result = paymentMapper.paymentLecture(lectureRelId);
        LectureStudentRelByIdDto dto = lectureMapper.getLectureStudentRelInfo(lectureRelId);
        if (result == 0 || dto == null) {
            return 0;
        }
        LecturePaymentLogDto paymentLogDto = new LecturePaymentLogDto(
                dto.getLectureName(), paymentPrice, studentName, UserSession.memberName()
        );
        RequestApi requestApi = logService.lecturePaymentLog(paymentLogDto);
        return requestApi.getHttpStatusCode();
    }

}
