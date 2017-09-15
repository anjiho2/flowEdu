package com.flowedu.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.flowedu.dto.StudentMemoDto;
import com.flowedu.dto.StudentMemoReplyDto;
import lombok.Data;

import java.util.List;

/**
 * Created by jihoan on 2017. 9. 11..
 */
@Data
public class StudentMemo {

    private StudentMemoDto studentMemoDto;

    private List<StudentMemoReplyDto> studentMemoReplyDtoList;

    public StudentMemo() {}

    public StudentMemo(StudentMemoDto studentMemoDto, List<StudentMemoReplyDto> studentMemoReplyDtoList) {
        this.studentMemoDto = studentMemoDto;
        this.studentMemoReplyDtoList = studentMemoReplyDtoList;
    }
}
