package com.flowedu.manager;

import com.flowedu.dto.LectureCalendarDto;
import com.flowedu.dto.LectureDetailDto;
import com.flowedu.dto.LectureInfoDto;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.service.LectureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by jihoan on 2017. 8. 10..
 */
@Service
public class LectureManager {

    @Autowired
    private LectureService lectureService;

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

    //public List<LectureCalendarDto>

    public void test() {
        LectureInfoDto dto = new LectureInfoDto();
        dto.setLectureId(26L);
        dto.setOfficeId(4L);
        dto.setChargeMemberId(5L);
        dto.setManageMemberId(6L);
        dto.setLecturePriceId(2L);
        dto.setLectureName("강의1111");
        dto.setLectureSubject("수학");
        dto.setLectureGrade(1);
        dto.setLectureLevel("LOW");
        dto.setLectureOperationType("MONTH");
        dto.setLectureStartDate("2017-10-01");
        dto.setLectureEndDate("2017-10-30");
        dto.setLectureLimitStudent(30);
        dto.setLectureStatus("CANCEL");

        //this.saveLectureInfo(dto);

        List<LectureDetailDto> Arr = new ArrayList<>();

        for (int i=0; i<2; i++) {
            LectureDetailDto detailDto = new LectureDetailDto();
            Long l = new Long(i+1);
            detailDto.setLectureRoomId(2L);
            detailDto.setStartTime("11:00:00");
            detailDto.setEndTime("12:00:00");
            detailDto.setLectureDay("MON");
            detailDto.setLectureDetailId(l);
            Arr.add(detailDto);
        }

        this.modifyLecture(dto, Arr);
    }

}
