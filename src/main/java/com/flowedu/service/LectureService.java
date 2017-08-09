package com.flowedu.service;

import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.LectureMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by jihoan on 2017. 8. 8..
 */
@Service
public class LectureService {

    @Autowired
    private LectureMapper lectureMapper;

    /**
     * <PRE>
     * 1. Comment : 강의실 명 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .09
     * </PRE>
     * @param lectureRoomName
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean saveLectureRoom(String lectureRoomName) {
        if ("".equals(lectureRoomName)) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        int roomCnt = lectureMapper.getLectureRoomCount(lectureRoomName);
        if (roomCnt > 0) {
            return false;
        }
        lectureMapper.saveLectureRoom(lectureRoomName);
        return true;
    }
}
