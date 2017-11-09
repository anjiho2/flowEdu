package com.flowedu.service;

import com.flowedu.api.service.LogService;
import com.flowedu.domain.CalcLecturePayment;
import com.flowedu.domain.KisPosOcx;
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
    public int paymentLecture(Long lectureRelId, String studentName, int paymentPrice, String calcType, KisPosOcx kisPosOcx) throws Exception {
        if (lectureRelId == null || kisPosOcx == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        //결제 요청 금액 만큼 차감하기
        CalcLecturePayment calcLecturePayment = new CalcLecturePayment(lectureRelId, paymentPrice, calcType);
        lectureMapper.calcLecturePaymentPrice(calcLecturePayment);
        //차감후 금액 확인
        LectureStudentRelByIdDto dto = lectureMapper.getLectureStudentRelInfo(lectureRelId);
        //차금 금액이 전부 결제 됬는지 확인
        if (dto.getPaymentPrice() == 0) {
            //전부 결제가 되었으면 결제 완료 상태로 변경
            paymentMapper.paymentLecture(lectureRelId);
        }
        LecturePaymentLogDto lecturePaymentLogDto = new LecturePaymentLogDto(
            dto.getLectureName(), paymentPrice, studentName, kisPosOcx
        );
        RequestApi requestApi = logService.lecturePaymentLog(lecturePaymentLogDto);
        return requestApi.getHttpStatusCode();
    }

}
