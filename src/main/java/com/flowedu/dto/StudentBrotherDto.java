package com.flowedu.dto;

import lombok.Data;

@Data
public class StudentBrotherDto {

    private Long studentBrotherId;

    private Long brotherId;

    private Long studentId;

    private String createDate;

    public StudentBrotherDto() {}

    public StudentBrotherDto(Long brotherId, Long studentId) {
        this.brotherId = brotherId;
        this.studentId = studentId;
    }
}
