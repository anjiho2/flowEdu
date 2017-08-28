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

    void saveStudentMemo(@Param("studentId") Long studentId, @Param("flowMemberId") Long flowMemberId, @Param("memoContent") String memoContent);

    void modifyStudentInfo(StudentDto studentDto);
}
