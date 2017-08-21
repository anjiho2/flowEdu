package com.flowedu.service;

import com.flowedu.define.datasource.LectureDay;
import com.flowedu.dto.CalendarJsonDto;
import com.flowedu.dto.CalendarLectureInfoDto;
import com.flowedu.mapper.CalendarMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * Created by jihoan on 2017. 8. 21..
 */
@Service
public class CalendarService {

    static final Logger logger = LoggerFactory.getLogger(CalendarService.class);

    @Autowired
    private CalendarMapper calendarMapper;

    @Transactional(readOnly = true)
    public List<CalendarJsonDto> getCalendarLectureInfo(Long lectureId) {
        List<CalendarLectureInfoDto> list = calendarMapper.getCalendarInfoByLecture(lectureId);
        Optional<CalendarLectureInfoDto> result = list.stream().filter(dto -> dto.getLectureOperationType().equals("MONTH"))
                .findFirst();

        if (result.isPresent()) {
            logger.info("find~~~");
        } else {
            logger.info("not find~~~");
        }





        List<CalendarJsonDto> calendarJsonDtoList = new ArrayList<>();
        for (CalendarLectureInfoDto lectureInfoDto : list) {
            List<Integer> dayAsList = Arrays.asList(LectureDay.getLectureDayCode(lectureInfoDto.getLectureDay()));
            HashMap<String, Object> range = new HashMap<>();
            range.put("start", lectureInfoDto.getLectureStartDate());
            range.put("end", lectureInfoDto.getLectureEndDate());
            List<HashMap<String, Object>> rangeAsList = Arrays.asList(range);
            CalendarJsonDto jsonDto = new CalendarJsonDto(
                    lectureInfoDto.getLectureDetailId(),
                    lectureInfoDto.getLectureName(),
                    lectureInfoDto.getStartTime(),
                    lectureInfoDto.getEndTime(),
                    dayAsList,
                    rangeAsList
            );
            calendarJsonDtoList.add(jsonDto);
        }
        return calendarJsonDtoList;
    }
}
