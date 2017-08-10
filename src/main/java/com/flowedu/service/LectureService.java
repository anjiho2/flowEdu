package com.flowedu.service;

import com.flowedu.define.datasource.LectureDay;
import com.flowedu.dto.LectureDetailDto;
import com.flowedu.dto.LectureInfoDto;
import com.flowedu.dto.LecturePriceDto;
import com.flowedu.dto.LectureRoomDto;
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
public class LectureService {

    private final Logger logger = LoggerFactory.getLogger(LectureService.class);

    @Autowired
    private LectureMapper lectureMapper;

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
     * 1. Comment : 요일 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @return
     */
    public List<HashMap<String, Object>> getLectureDayList() {
        List<HashMap<String, Object>> Arr = new ArrayList<>();

        for (int i=0; i< LectureDay.size(); i++) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("dayCode", LectureDay.getLectureDayCode(i).toString());
            map.put("dayName", LectureDay.getLectureDayName(i));
            Arr.add(map);
        }
        return Arr;
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
    public List<LectureInfoDto> getLectureInfoList() {
        List<LectureInfoDto> Arr = new ArrayList<>();
        Arr = lectureMapper.getLectureInfoList(UserSession.flowMemberId(), UserSession.memberType());
        return Arr;
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
     * 1. Comment : 강의실 명 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @param lectureRoomId
     * @param lectureRoomName
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyLectureRoom(Long lectureRoomId, String lectureRoomName) {
        if (lectureRoomId < 1L && "".equals(lectureRoomName)) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        lectureMapper.modifyLectureRoom(lectureRoomId, lectureRoomName);
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
     * 1. Comment : 강의 상세
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .10
     * </PRE>
     * @param lectureDetailDto
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyLectureDetailInfo(LectureDetailDto lectureDetailDto) {
        if (lectureDetailDto == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST)
        }
        lectureMapper.modifyLectureDetailInfo(lectureDetailDto);
    }


}
