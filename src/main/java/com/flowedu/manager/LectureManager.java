package com.flowedu.manager;

import com.flowedu.api.service.SendService;
import com.flowedu.define.datasource.SmsSendData;
import com.flowedu.domain.LectureRegInfo;
import com.flowedu.domain.RequestApi;
import com.flowedu.dto.*;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.service.LectureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collector;
import java.util.stream.Collectors;

/**
 * Created by jihoan on 2017. 8. 10..
 */
@Service
public class LectureManager {

    @Autowired
    private LectureService lectureService;

    @Autowired
    private SendService sendService;

    /**
     * <PRE>
     * 1. Comment : 강의 기본 정보와 상세정보 한번에 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .10
     * </PRE>
     * @param lectureInfoDto
     * @param lectureDetailDtoList
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean regLecture(LectureInfoDto lectureInfoDto, List<LectureDetailDto> lectureDetailDtoList) {
        if (lectureInfoDto == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        //LECTURE_INFO 테이블 정보 입력
        Long lectureId = lectureService.saveLectureInfo(lectureInfoDto);
        if (lectureDetailDtoList.size() > 0) {
            //특정 강의에 상세 정보 입력(LECTURE_DETAIL_INFO)
            lectureService.saveLectureDetailInfo(lectureId, lectureDetailDtoList);
        }
        return true;
    }

    /**
     * <PRE>
     * 1. Comment : 강의 기본 정보와 상세정보 한번에 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .22
     * </PRE>
     * @param lectureInfoDto
     * @param lectureDetailDtoList
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean modifyLecture(LectureInfoDto lectureInfoDto, List<LectureDetailDto> lectureDetailDtoList) {
        if (lectureInfoDto == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        lectureService.modifyLectureInfo(lectureInfoDto);
        lectureService.modifyLectureDetailInfoList(lectureDetailDtoList);
        return true;
    }

    /**
     * <PRE>
     * 1. Comment : 출석하기 기능
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 01 .29
     * </PRE>
     * @param lectureAttendDtoList
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean attendLecture(List<LectureAttendDto> lectureAttendDtoList) throws Exception {
        if (lectureAttendDtoList.size() == 0) return false;
        Optional<LectureAttendDto>findInfo = lectureAttendDtoList
                .stream()
                .filter(lectureAttendDto -> !lectureAttendDto.getAttendStartTime().equals(""))
                .findFirst();
        if (findInfo.isPresent()) { // 등원일때
            lectureService.saveLectureAttendList(lectureAttendDtoList);
        } else {
            // 하원일때
            for (LectureAttendDto dto : lectureAttendDtoList) {
                lectureService.modifyLectureAttend(dto);
            }
        }
        //출석 sms 전송
        RequestApi requestApi = sendService.sendAttendSms(lectureAttendDtoList);
        if (requestApi.getHttpStatusCode() != 200 || requestApi == null) return false;
        return true;
    }

    /**
     * <PRE>
     * 1. Comment : 강의 신청 메뉴
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 03 .13
     * </PRE>
     * @param lectureId
     * @return
     */
    @Transactional(readOnly = true)
    public LectureRegInfo getLectureRegInfo(Long lectureId) {
        //강의 기본 정보 가져오기
        LectureInfoDto lectureInfoDto = lectureService.getLectureInfo(lectureId);
        //기존 수강중인 학생
        List<LectureStudentRelDto> lectureStudentRelDtoList = lectureService.getStudentListByLectureRegister(lectureId);
        LectureRegInfo lectureRegInfo = new LectureRegInfo(
                lectureInfoDto, lectureStudentRelDtoList
        );
        return lectureRegInfo;
    }

    public void test() {
       List<LectureAttendDto> arr = new ArrayList<>();
       //for (int i=0; i<2; i++) {
           LectureAttendDto lectureAttendDto = new LectureAttendDto();
           lectureAttendDto.setLectureId(5L);
           //lectureAttendDto.setLectureAttendId(9L);
           lectureAttendDto.setStudentId(560L);
           lectureAttendDto.setAttendType("0");
           lectureAttendDto.setAttendStartTime("18:00");
           lectureAttendDto.setAttendEndTime("");
           lectureAttendDto.setAttendModifyComment("수정입니다.");
           arr.add(lectureAttendDto);
       //}
       try {
           attendLecture(arr);
       } catch (Exception e) {
           e.printStackTrace();
       }
    }

}
