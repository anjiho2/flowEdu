package com.flowedu.domain;

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
}
