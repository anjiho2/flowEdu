package com.flowedu.dto;

import lombok.Data;

import java.util.HashMap;
import java.util.List;

/**
 * Created by jihoan on 2017. 8. 19..
 */
@Data
public class CalendarJsonDto {

    private Long id;

    private String title;

    private String start;

    private String end;

    private List<Integer> dow;

    private List<HashMap<String, Object>> ranges;

    public CalendarJsonDto() {}

    public CalendarJsonDto(Long id, String title, String start, String end, List<Integer>dow, List<HashMap<String, Object>>ranges) {
        this.id = id;
        this.title = title;
        this.start = start;
        this.end = end;
        this.dow = dow;
        this.ranges = ranges;
    }
}
