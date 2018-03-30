package com.flowedu.mapper;

import com.flowedu.domain.CalcLecturePayment;
import com.flowedu.domain.LectureSearch;
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

    List<LectureInfoDto> getLectureInfoList(LectureSearch lectureSearch);

    int getLectureInfoCount(LectureSearch lectureSearch);

    List<LectureDetailDto> getLectureDetailInfoList(@Param("lectureId") Long lectureId);

    LectureInfoDto getLectureInfo(@Param("lectureId")Long lectureId);

    int getLectureDetailCountByTime(@Param("lectureRoomId") Long lectureRoomId, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("lectureDay") String lectureDay);

    int getRegisteredLectureStudentCount(@Param("lectureId") Long lectureId);

    List<LectureStudentRelDto> getStudentListByLectureRegister(@Param("lectureId") Long lectureId);

    int getLectureStudentRel(@Param("lectureId") Long lectureId, @Param("studentId") Long studentId);

    List<LectureStudentRelByIdDto> getLectureStudentRelByStudentId(@Param("studentId") Long studentId, @Param("type") String type,
                                                                   @Param("startDate") String startDate, @Param("endDate") String endDate);

    int getLectureStudentRelByStudentIdCount(@Param("studentId") Long studentId, @Param("type") String type,
                                             @Param("startDate") String startDate, @Param("endDate") String endDate);

    List<LectureAttendDto> getLectureAttendList(@Param("lectureId") Long lectureId, @Param("day") String day);

    Integer getLectureAttendListByStudentIdCount(@Param("studentId") Long studentId, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("officeId") Long offceId);

    List<LectureAttendDto> getLectureAttendListByStudentId(@Param("studentId") Long studentId, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("officeId") Long offceId,
                                                           @Param("start") int start, @Param("end") int end);

    LectureStudentRelByIdDto getLectureStudentRelInfo(@Param("lectureRelId") Long lectureRelId);

    List<LectureAttendDto> getLectureAttendListBySearch(@Param("lectureId") Long lectureId, @Param("day") String day,
                                                        @Param("searchDate") String searchDate, @Param("studentName") String studentName,
                                                        @Param("today") String today);

    List<LectureInfoDto> getLectureInfoMyClass(@Param("flowMemberId") Long flowMemberId, @Param("memberType") String memberType);

    List<AssignmentInfoDto> getAssignmentInfoList(@Param("assignmentIdx") Long assignmentIdx, @Param("lectureId") Long lectureId, @Param("useYn") boolean useYn,
                                                  @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("memberName") String memberName);

    List<LectureRoomDto>selectLecutreRoomRegSuccess(@Param("lectureDay") String lectureDay, @Param("startTime") String startTime,
                                                     @Param("endTime") String endTime, @Param("officeId") Long officeId);

    /** INSERT **/
    void saveLectureRoom(@Param("officeId") Long officeId, @Param("lectureRoomName") String lectureRoomName);

    void saveLecturePrice(@Param("lecturePrice") int lecturePrice);

    void saveLectureInfo(LectureInfoDto lectureInfoDto);

    void saveLectureDetailList(@Param("lectureDeatilList")List<LectureDetailDto> lectureDetailDtoList);

    void saveLectureDetail(LectureDetailDto lectureDetailDto);

    void saveLectureStudentRel(@Param("relList") List<LectureStudentRelDto> lectureStudentRelDtoList);

    void saveLectureAttend(@Param("lectureId") Long lectureId, @Param("studentId") Long studentId, @Param("attendType") String attendType, @Param("attendDay") String attendDay);

    void saveLectureAttendList(@Param("attendList") List<LectureAttendDto> lectureAttendDtoList);

    void saveAssignmentInfo(AssignmentInfoDto assignmentInfoDto);

    /** UPDATE **/
    void modifyLectureRoom(@Param("lectureRoomId") Long lectureRoomId, @Param("officeId") Long officeId, @Param("lectureRoomName") String lectureRoomName);

    void modifuLecturePrice(@Param("lecturePriceId") Long lecturePriceId, @Param("lecturePrice") int lecturePrice);

    void modifyLectureInfo(LectureInfoDto lectureInfoDto);

    void modifyLectureDetailInfo(LectureDetailDto lectureDetailDto);

    void modifyLecutreStatus(@Param("lectureId") Long lectureId, @Param("lectureStatus") String lectureStatus);

    void modifyLectureStudentRel(@Param("lectureRelId") Long lectureRelId, @Param("lectureId") Long lectureId, @Param("studentId") Long studentId, @Param("addYn") boolean addYn);

    void modifyAttendComment(@Param("lectureAttendId") Long lectureAttendId, @Param("attendType") String attendType, @Param("attendModifyComment") String attendModifyComment);

    void calcLecturePaymentPrice(CalcLecturePayment calcLecturePayment);

    void updateLectureAttend(LectureAttendDto lectureAttendDto);

    void modifyAssignmentInfo(AssignmentInfoDto assignmentInfoDto);

    void deleteLectureDetailInfo(@Param("lectureId") Long lectureId);

    void deleteLectureStudentRel(@Param("lectureRelId") Long lectureRelId);

}
