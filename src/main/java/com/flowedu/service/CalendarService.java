package com.flowedu.service;

import com.flowedu.define.datasource.LectureDay;
import com.flowedu.define.datasource.LectureOperationType;
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

    /**
     * <PRE>
     * 1. Comment : 달력 표현할 강의 정보
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .21
     * </PRE>
     * @param lectureId
     * @return
     */
    @Transactional(readOnly = true)
    public List<CalendarJsonDto> getCalendarLectureInfo(Long lectureId) {
        List<CalendarLectureInfoDto> list = calendarMapper.getCalendarInfoByLecture(lectureId);
        //강의가 월별, 회수별인지 찾기
        Optional<CalendarLectureInfoDto> result = list
                .stream()
                .filter(dto -> dto.getLectureOperationType().equals(LectureOperationType.MONTH.toString()))
                .findFirst();
        //월별 반복일때
        if (result.isPresent()) {
            return this.getLectureByRepeatMonth(list);
        } else {
        //TODO 횟수별일 때 변경 로직 추가.
            logger.info("not find~~~");
        }
        return null;
    }

    /**
     * <PRE>
     * 1. Comment : 달력 표현할 강의 정보(월별)
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .21
     * </PRE>
     * @param calendarLectureInfoDtoList
     * @return
     */
    private List<CalendarJsonDto> getLectureByRepeatMonth(List<CalendarLectureInfoDto> calendarLectureInfoDtoList) {
        List<CalendarJsonDto> calendarJsonDtoList = new ArrayList<>();

        for (CalendarLectureInfoDto lectureInfoDto : calendarLectureInfoDtoList) {
            List<Integer> dayAsList = Arrays.asList(LectureDay.getLectureDayCode(lectureInfoDto.getLectureDay()));

            HashMap<String, Object> range = new HashMap<>();
            range.put("start", lectureInfoDto.getLectureStartDate());
            range.put("end", lectureInfoDto.getLectureEndDate());
            List<HashMap<String, Object>> rangeAsList = Arrays.asList(range);

            CalendarJsonDto jsonDto = new CalendarJsonDto(
                    lectureInfoDto.getLectureDetailId(),
                    lectureInfoDto.getLectureName() + "[" + lectureInfoDto.getLectureRoomName() + "]",
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
