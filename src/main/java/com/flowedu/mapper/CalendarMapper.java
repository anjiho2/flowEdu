package com.flowedu.mapper;

import com.flowedu.dto.CalendarLectureInfoDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 21..
 */
public interface CalendarMapper {

    List<CalendarLectureInfoDto> getCalendarInfoByLecture(@Param("lectureId") Long lectureId);

}
