package com.flowedu.mapper;

import com.flowedu.dto.*;
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

    List<LectureInfoDto> getLectureInfoList(@Param("flowMemberId") Long flowMemberId, @Param("memberType") String memberType);

    List<LectureDetailDto> getLectureDetailInfoList(@Param("lectureId") Long lectureId);

    LectureInfoDto getLectureInfo(@Param("lectureId")Long lectureId);

    int getLectureDetailCountByTime(@Param("lectureRoomId") Long lectureRoomId, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("lectureDay") String lectureDay);

    int getRegisteredLectureStudentCount(@Param("lectureId") Long lectureId);

    List<LectureStudentRelDto> getStudentListByLectureRegister(@Param("lectureId") Long lectureId);

    /** INSERT **/
    void saveLectureRoom(@Param("officeId") Long officeId, @Param("lectureRoomName") String lectureRoomName);

    void saveLecturePrice(@Param("lecturePrice") int lecturePrice);

    void saveLectureInfo(LectureInfoDto lectureInfoDto);

    void saveLectureDetailList(@Param("lectureDeatilList")List<LectureDetailDto> lectureDetailDtoList);

    void saveLectureStudentRel(@Param("relList") List<LectureStudentRelDto> lectureStudentRelDtoList);

    /** UPDATE **/
    void modifyLectureRoom(@Param("lectureRoomId") Long lectureRoomId, @Param("lectureRoomName") String lectureRoomName);

    void modifuLecturePrice(@Param("lecturePriceId") Long lecturePriceId, @Param("lecturePrice") int lecturePrice);

    void modifyLectureInfo(LectureInfoDto lectureInfoDto);

    void modifyLectureDetailInfo(LectureDetailDto lectureDetailDto);

}
