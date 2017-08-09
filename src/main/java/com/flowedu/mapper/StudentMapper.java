package com.flowedu.mapper;

import com.flowedu.dto.StudentDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 8..
 */
public interface StudentMapper {

    StudentDto getStudentInfo(@Param("studentId") Long studentId);

    int getSudentListCount();

    List<StudentDto> getSudentList(@Param("start") int start, @Param("end") int end);

    void saveStudentInfo(StudentDto studentDto);

    void modifyStudentInfo(StudentDto studentDto);
}
