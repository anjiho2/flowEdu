package com.flowedu.mapper;

import com.flowedu.dto.StudentDto;
import com.flowedu.dto.StudentMemoDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 8..
 */
public interface StudentMapper {

    StudentDto getStudentInfo(@Param("studentId") Long studentId);

    int getSudentListCount(@Param("gubun") String gubun, @Param("studentName") String studentName);

    List<StudentDto> getSudentList(@Param("start") int start, @Param("end") int end, @Param("gubun") String gubun, @Param("studentName") String studentName);

    int getStudentMemoListCount(@Param("studentId") Long studentId);

    List<StudentMemoDto> getStudentMemoList(@Param("start") int start, @Param("end") int end, @Param("studentId") Long studentId);

    void saveStudentInfo(StudentDto studentDto);

    void saveStudentMemo(@Param("studentId") Long studentId, @Param("flowMemberId") Long flowMemberId, @Param("memoContent") String memoContent);

    void modifyStudentInfo(StudentDto studentDto);
}
