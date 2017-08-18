package com.flowedu.service;

import com.flowedu.config.PagingSupport;
import com.flowedu.define.datasource.*;
import com.flowedu.dto.*;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.LectureMapper;
import com.flowedu.session.UserSession;
import com.flowedu.util.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by jihoan on 2017. 8. 8..
 */
@Service
public class LectureService extends PagingSupport {

    private final Logger logger = LoggerFactory.getLogger(LectureService.class);

    @Autowired
    private LectureMapper lectureMapper;

    /**
     * <PRE>
     * 1. Comment : 요일 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @return
     */
    public List<HashMap<String, Object>> getLectureDayList() {
        List<HashMap<String, Object>> Arr = new ArrayList<>();

        for (int i=0; i<LectureDay.size(); i++) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("dayCode", LectureDay.getLectureDayCode(i).toString());
            map.put("dayName", LectureDay.getLectureDayName(i));
            Arr.add(map);
        }
        return Arr;
    }

    /**
     * <PRE>
     * 1. Comment : 강의 상태 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .14
     * </PRE>
     * @return
     */
    public List<HashMap<String, Object>> getLectureStatusList() {
        List<HashMap<String, Object>> Arr = new ArrayList<>();

        for (int i=0; i<LectureStatus.size(); i++) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("statusCode", LectureStatus.getLectureStatusCode(i).toString());
            map.put("statusName", LectureStatus.getLectureStatusName(i));
            Arr.add(map);
        }
        return Arr;
    }

    /**
     * <PRE>
     * 1. Comment : 강의 운영 형태 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .14
     * </PRE>
     * @return
     */
    public List<HashMap<String, Object>> getLectureOperationTypeList() {
        List<HashMap<String, Object>> Arr = new ArrayList<>();

        for (int i=0; i< LectureOperationType.size(); i++) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("operationTypeCode", LectureOperationType.getLectureOpeationTypeCode(i).toString());
            map.put("operationTypeName", LectureOperationType.getLectureOperationTypeName(i));
            Arr.add(map);
        }
        return Arr;
    }

    /**
     * <PRE>
     * 1. Comment : 과목 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .14
     * </PRE>
     * @return
     */
    public List<HashMap<String, Object>> getLectureSubjectList() {
        List<HashMap<String, Object>> Arr = new ArrayList<>();

        for (int i=0; i< LectureSubject.size(); i++) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("subjectCode", LectureSubject.getLectureSubjectCode(i).toString());
            map.put("subjectName", LectureSubject.getLectureSubjectName(i));
            Arr.add(map);
        }
        return Arr;
    }

    /**
     * <PRE>
     * 1. Comment : 강의 레벨 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .14
     * </PRE>
     * @return
     */
    public List<HashMap<String, Object>> getLectureLevelList() {
        List<HashMap<String, Object>> Arr = new ArrayList<>();

        for (int i=0; i< LectureLevel.size(); i++) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("levelCode", LectureLevel.getLectureLevelCode(i).toString());
            map.put("levelName", LectureLevel.getLectureLevelName(i));
            Arr.add(map);
        }
        return Arr;
    }

    /**
     * <PRE>
     * 1. Comment : 강의실 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @param officeId
     * @return
     */
    @Transactional(readOnly = true)
    public List<LectureRoomDto> getLectureRoomList(Long officeId) {
        return lectureMapper.getLectureRoomList(officeId);

    }

    /**
     * <PRE>
     * 1. Comment : 강의 가격 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @return
     */
    @Transactional(readOnly = true)
    public List<LecturePriceDto> getLecturePriceList() {
        return lectureMapper.getLecturePriceList();
    }

    /**
     * <PRE>
     * 1. Comment : 강의 기본 정보 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .10
     * </PRE>
     * @return
     */
    @Transactional(readOnly = true)
    public List<LectureInfoDto> getLectureInfoList(int sPage, int pageListCount) {
        PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        List<LectureInfoDto> Arr = lectureMapper.getLectureInfoList(
                pagingDto.getStart(), pageListCount, UserSession.flowMemberId(), UserSession.memberType());
        return Arr;
    }

    /**
     * <PRE>
     * 1. Comment : 강의 기본 정보 리스트 개수
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .18
     * </PRE>
     * @return
     */
    @Transactional(readOnly = true)
    public int getLectureInfoCount() {
        return lectureMapper.getLectureInfoCount();
    }

    /**
     * <PRE>
     * 1. Comment : 강의 상세 정보
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .10
     * </PRE>
     * @param lectureId
     * @return
     */
    @Transactional(readOnly = true)
    public List<LectureDetailDto> getLectureDetailInfoList(Long lectureId) {
        if (lectureId < 1L) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        return lectureMapper.getLectureDetailInfoList(lectureId);
    }

    /**
     * <PRE>
     * 1. Comment : 강의 상세 정보 중복 체크 (강의실아이디, 시작시각, 종료시각, 요일)
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .10
     * </PRE>
     * @param lectureRoomId
     * @param startTime
     * @param endTime
     * @param lectureDay
     * @return
     */
    @Transactional(readOnly = true)
    public boolean checkDuplicateLectureDetail(Long lectureRoomId, String startTime, String endTime, String lectureDay) {
        if (lectureRoomId < 1L) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        int count = lectureMapper.getLectureDetailCountByTime(lectureRoomId, startTime, endTime, lectureDay);
        if (count > 0) {
            return true;
        }
        return false;
    }

    /**
     * <PRE>
     * 1. Comment : 강의실 명 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @param officeId
     * @param lectureRoomName
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean saveLectureRoom(Long officeId, String lectureRoomName) {
        if (officeId < 1L && "".equals(lectureRoomName)) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        int roomCnt = lectureMapper.getLectureRoomCount(officeId, lectureRoomName);
        if (roomCnt > 0) {
            return false;
        }
        lectureMapper.saveLectureRoom(officeId, lectureRoomName);
        return true;
    }

    /**
     * <PRE>
     * 1. Comment : 강의실 가격 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @param lecturePrice
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean saveLecturePrice(int lecturePrice) {
        if (lecturePrice == 0) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        int priceCnt = lectureMapper.getLecturePriceCount(lecturePrice);
        if (priceCnt > 0) {
            return false;
        }
        lectureMapper.saveLecturePrice(lecturePrice);
        return true;
    }

    /**
     * <PRE>
     * 1. Comment : 강의 기본 정보 등록하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @param lectureInfoDto
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Long saveLectureInfo(LectureInfoDto lectureInfoDto) {
        if (lectureInfoDto == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        lectureMapper.saveLectureInfo(lectureInfoDto);
        return lectureInfoDto.getLectureId();
    }

    /**
     * <PRE>
     * 1. Comment : 강의 상세 정보 등록하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @param lectureId
     * @param lectureDetailDtoList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveLectureDetailInfo(Long lectureId, List<LectureDetailDto> lectureDetailDtoList) {
        if (lectureId < 1L && lectureDetailDtoList.size() == 0) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        ArrayList<LectureDetailDto> Arr = new ArrayList<>();
        for (LectureDetailDto lectureDetailDto : lectureDetailDtoList) {
            LectureDetailDto dto = new LectureDetailDto(
                    lectureId,
                    lectureDetailDto.getLectureRoomId(),
                    lectureDetailDto.getStartTime(),
                    lectureDetailDto.getEndTime(),
                    lectureDetailDto.getLectureDay()
            );
            Arr.add(dto);
        }
        lectureMapper.saveLectureDetailList(Arr);
    }

    /**
     * <PRE>
     * 1. Comment : 강의와 학생 연관 짓기(특정 강의에 학생 등록)
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .11
     * </PRE>
     * @param lectureStudentRelDtoList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean saveLectureStudentRel(Long lectureId, List<LectureStudentRelDto> lectureStudentRelDtoList) {
        if (lectureId < 1L || lectureStudentRelDtoList.size() == 0) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        LectureInfoDto lectureInfo = lectureMapper.getLectureInfo(lectureId);
        if (lectureInfo != null) {
            //학생 제한 숫자 정보 가져오기
            int limitStudent = lectureInfo.getLectureLimitStudent();
            //강의에 등록 되어있는 학생 수 가져오기
            int registeredLectureStudentCount = lectureMapper.getRegisteredLectureStudentCount(lectureId);
            //등록 할려는 학생 수 >= 제한 숫자 return fase;
            if (registeredLectureStudentCount >= limitStudent) {
               return false;
            }
        }
        lectureMapper.saveLectureStudentRel(lectureStudentRelDtoList);
        return true;
    }

    /**
     * <PRE>
     * 1. Comment : 강의에 등록된 학생 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .11
     * </PRE>
     * @param lectureId
     * @return
     */
    @Transactional(readOnly = true)
    public List<LectureStudentRelDto> getStudentListByLectureRegister(Long lectureId) {
        return lectureMapper.getStudentListByLectureRegister(lectureId);
    }

    /**
     * <PRE>
     * 1. Comment : 강의실 명 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09123
     * </PRE>
     * @param lectureRoomId
     * @param lectureRoomName
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyLectureRoom(Long lectureRoomId, Long officeId, String lectureRoomName) {
        if (lectureRoomId < 1L && "".equals(lectureRoomName)) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        lectureMapper.modifyLectureRoom(lectureRoomId, officeId, lectureRoomName);
    }

    /**
     * <PRE>
     * 1. Comment : 강의가격 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @param lecturePriceId
     * @param lecturePrice
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean modifyLecutrePrice(Long lecturePriceId, int lecturePrice) {
        if (lecturePriceId < 1L) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        int priceCnt = lectureMapper.getLecturePriceCount(lecturePrice);
        if (priceCnt > 0) {
            return false;
        }
        lectureMapper.modifuLecturePrice(lecturePriceId, lecturePrice);
        return true;
    }

    /**
     * <PRE>
     * 1. Comment : 강의 기본 정보 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .10
     * </PRE>
     * @param lectureInfoDto
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyLectureInfo(LectureInfoDto lectureInfoDto) {
        if (lectureInfoDto == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        lectureMapper.modifyLectureInfo(lectureInfoDto);
    }

    /**
     * <PRE>
     * 1. Comment : 강의 상세 정보 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .10
     * </PRE>
     * @param lectureDetailDto
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyLectureDetailInfo(LectureDetailDto lectureDetailDto) {
        if (lectureDetailDto == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        lectureMapper.modifyLectureDetailInfo(lectureDetailDto);
    }

    /**
     * <PRE>
     * 1. Comment : 강의 상태 변경
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .14
     * </PRE>
     * @param lectureId
     * @param lectureStatus (LectureStatus enum 클래스 정의)
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyLecutreStatus(Long lectureId, String lectureStatus) {
        if (lectureId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        lectureMapper.modifyLecutreStatus(lectureId, lectureStatus);
    }

    /**
     * <PRE>
     * 1. Comment : 강의와 학생 연관 값 변경 (LECTURE_STUDENT_REL)
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .14
     * </PRE>
     * @param lectureRelId
     * @param lectureId
     * @param studentId
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyLectureStudentRel(Long lectureRelId, Long lectureId, Long studentId) {
        if (lectureRelId == null || lectureId == null || studentId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        lectureMapper.modifyLectureStudentRel(lectureRelId, lectureId, studentId);
    }


}
