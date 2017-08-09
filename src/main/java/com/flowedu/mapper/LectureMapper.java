package com.flowedu.mapper;

import org.apache.ibatis.annotations.Param;

/**
 * Created by jihoan on 2017. 7. 6..
 */
public interface LectureMapper {

    /** SELECT **/
    Integer getLectureRoomCount(@Param("lectureRoomName") String lectureRoomName);

    /** INSERT **/
    void saveLectureRoom(@Param("lectureRoomName") String lectureRoomName);

}
