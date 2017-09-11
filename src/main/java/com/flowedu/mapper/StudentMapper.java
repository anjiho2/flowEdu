package com.flowedu.mapper;

import com.flowedu.dto.StudentDto;
import com.flowedu.dto.StudentMemoDto;
import com.flowedu.dto.StudentMemoReplyDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 8..
 */
public interface StudentMapper {

    StudentDto getStudentInfo(@Param("studentId") Long studentId);

    int getSudentListCount(@Param("gubun") String gubun, @Param("studentName") String studentName);

    List<StudentDto> getSudentList(@Param("start") int start, @Param("end") int end, @Param("gubun") String gubun, @Param("studentName") String studentName);

    int getStudentMemoListCount(@Param("studentId") Long studentId, @Param("searchDate") String searchDate, @Param("memoType") String memoType,
                                @Param("memberName") String memberName, @Param("memoContent") String memoContent);

    List<StudentMemoDto> getStudentMemoList(@Param("start") int start, @Param("end") int end, @Param("studentId") Long studentId, @Param("searchDate") String searchDate,
                                            @Param("memoType") String memoType, @Param("memberName") String memberName, @Param("memoContent") String memoContent);

    List<StudentMemoReplyDto> getStudentMemoReplyList(@Param("start") int start, @Param("end") int end, @Param("studentMemoId") Long studentMemoId);

    void saveStudentInfo(StudentDto studentDto);

    void saveStudentMemo(@Param("studentId") Long studentId, @Param("flowMemberId") Long flowMemberId, @Param("memoContent") String memoContent, @Param("memoType") String memoType);

    void modifyStudentInfo(StudentDto studentDto);

    void modifyMemoProcessYn(@Param("studentMemoId") Long studentMemoId, @Param("processYn") boolean processYn);
}
