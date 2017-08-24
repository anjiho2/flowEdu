package com.flowedu.service;

import com.flowedu.config.PagingSupport;
import com.flowedu.define.datasource.*;
import com.flowedu.dto.*;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.LectureMapper;
import com.flowedu.repository.MemberNameRepository;
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

    @Autowired
    private MemberNameRepository memberNameRepository;

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
    public List<LectureInfoDto> getLectureInfoList(int sPage, int pageListCount, Long officeId) {
        PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        List<LectureInfoDto> Arr = lectureMapper.getLectureInfoList(
                pagingDto.getStart(), pageListCount, officeId, UserSession.flowMemberId(), UserSession.memberType());
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
     * 1. Comment : 강의에 학생을 넣을때 체크 기능
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .22
     * </PRE>
     * @param lectureId
     * @param studentId
     * @return (0 : 등록가능, 1 : 인원수 제한 걸렸을때, 2 : 해당 강의에 학생이 등록되어있을 때)
     */
    @Transactional(readOnly = true)
    public int checkLectureStudentRel(Long lectureId, Long studentId) {
        if (lectureId < 1L && studentId < 1L) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        LectureInfoDto lectureInfo = lectureMapper.getLectureInfo(lectureId);
        if (lectureInfo != null) {
            //학생 제한 숫자 정보 가져오기
            int limitStudent = lectureInfo.getLectureLimitStudent();
            //강의에 등록 되어있는 학생 수 가져오기
            int registeredLectureStudentCount = lectureMapper.getRegisteredLectureStudentCount(lectureId);
            //등록 할려는 학생 수 >= 제한 숫자 return 1;
            if (registeredLectureStudentCount >= limitStudent) {
                return 1;
            } else {
                //등록할려는 학생이 해당 강의에 등록되어있는지 확인
                int isRegCount = lectureMapper.getLectureStudentRel(lectureId, studentId);
                if (isRegCount == 1) {
                    return 2;
                }
            }
        }
        return 0;
    }

    /**
     * <PRE>
     * 1. Comment : 강의 상세 정보
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .21
     * </PRE>
     * @param lectureId
     * @return
     */
    @Transactional(readOnly = true)
    public LectureInfoDto getLectureInfo(Long lectureId) {
        return lectureMapper.getLectureInfo(lectureId);
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
     * 1. Comment : 학생 아이디로 등록된 강의 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .24
     * </PRE>
     * @param studentId
     * @return
     */
    @Transactional(readOnly = true)
    public List<LectureStudentRelByIdDto> getLectureStudentRelById(Long studentId) {
        List<LectureStudentRelByIdDto> Arr = lectureMapper.getLectureStudentRelByStudentId(studentId);
        if (Arr != null) {
            //담임 선생님, 관리 선생님 이름 주입하기
            memberNameRepository.fillMemberNameAny(Arr);
        }
        return Arr;
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
     * @param studentIds
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean saveLectureStudentRel(Long lectureId, List<Long> studentIds) {
        if (lectureId < 1L || studentIds.size() == 0) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        List<LectureStudentRelDto> Arr = new ArrayList<>();
        for (Long studentId : studentIds) {
            int checkCount = this.checkLectureStudentRel(lectureId, studentId);
            if (checkCount == 1 || checkCount == 2) {
                return false;
            }
            LectureStudentRelDto dto = new LectureStudentRelDto(lectureId, studentId);
            Arr.add(dto);
        }
        lectureMapper.saveLectureStudentRel(Arr);
        return true;
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
     * 3. 작성일 : 2017. 08 .102
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
     * 1. Comment : 강의 상세 정보 수정(배열)
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .22
     * </PRE>
     * @param lectureDetailDtoList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyLectureDetailInfoList(List<LectureDetailDto> lectureDetailDtoList) {
        if (lectureDetailDtoList.size() == 0) return;
        for (LectureDetailDto dto : lectureDetailDtoList)  {
            lectureMapper.modifyLectureDetailInfo(dto);
        }
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
    public void modifyLectureStudentRel(Long lectureRelId, Long lectureId, Long studentId, boolean addYn) {
        if (lectureRelId == null || lectureId == null || studentId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        lectureMapper.modifyLectureStudentRel(lectureRelId, lectureId, studentId, addYn);
    }

}
