package com.flowedu.service;

import com.flowedu.api.service.LogService;
import com.flowedu.define.datasource.CalcType;
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

import com.flowedu.util.SerialPortUtil;
import gnu.io.CommPortIdentifier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Enumeration;

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
     * @param paymentPrice
     * @param kisPosOcx
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int paymentLecture(Long lectureRelId, String studentName, int paymentPrice, String calcType, KisPosOcx kisPosOcx) throws Exception {
        if (lectureRelId == null || kisPosOcx == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        if (kisPosOcx.getAuthNo() == null) {
            return FlowEduErrorCode.CUSTOM_PAYMENT_ACCESS_CODE_NULL.code();
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
            lectureRelId, dto.getLectureName(), paymentPrice, studentName, kisPosOcx
        );
        RequestApi requestApi = logService.lecturePaymentLog(lecturePaymentLogDto);
        return requestApi.getHttpStatusCode();
    }

    /**
     * <PRE>
     * 1. Comment : 강의 가격 책정하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 11 .09
     * </PRE>
     * @param lectureRelId
     * @param price
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void formulateLecturePrice(Long lectureRelId, int price) {
        if (lectureRelId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        CalcLecturePayment calcLecturePayment = new CalcLecturePayment(lectureRelId, price, CalcType.PLUS.toString());
        lectureMapper.calcLecturePaymentPrice(calcLecturePayment);
    }

}
