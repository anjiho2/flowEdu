package com.flowedu.mapper;

import com.flowedu.dto.LectureDetailDto;
import com.flowedu.dto.LectureInfoDto;
import com.flowedu.dto.LecturePriceDto;
import com.flowedu.dto.LectureRoomDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 7. 6..
 */
public interface LectureMapper {

    /** SELECT **/
    List<LectureRoomDto> getLectureRoomList(@Param("officeId") Long officeId);

    Integer getLectureRoomCount(@Param("officeId") Long officeId, @Param("lectureRoomName") String lectureRoomName);

    List<LecturePriceDto> getLecturePriceList();

    Integer getLecturePriceCount(@Param("lecturePrice") int lecturePrice);

    /** INSERT **/
    void saveLectureRoom(@Param("officeId") Long officeId, @Param("lectureRoomName") String lectureRoomName);

    void saveLecturePrice(@Param("lecturePrice") int lecturePrice);

    void saveLectureInfo(LectureInfoDto lectureInfoDto);

    void saveLectureDetailList(@Param("lectureDeatilList")List<LectureDetailDto> lectureDetailDtoList);

    /** UPDATE **/
    void modifyLectureRoom(@Param("lectureRoomId") Long lectureRoomId, @Param("lectureRoomName") String lectureRoomName);

    void modifuLecturePrice(@Param("lecturePriceId") Long lecturePriceId, @Param("lecturePrice") int lecturePrice);

}
