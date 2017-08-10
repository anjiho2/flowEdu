package com.flowedu.manager;

import com.flowedu.dto.LectureDetailDto;
import com.flowedu.dto.LectureInfoDto;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.service.LectureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
        Long lectureId = lectureService.saveLectureInfo(lectureInfoDto);
        if (lectureDetailDtoList.size() > 0) {
            lectureService.saveLectureDetailInfo(lectureId, lectureDetailDtoList);
        }
        return true;
    }

}
