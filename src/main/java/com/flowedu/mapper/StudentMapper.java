package com.flowedu.mapper;

import com.flowedu.domain.StudentSimpleMemo;
import com.flowedu.dto.StudentBrotherDto;
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

    int getSudentListCount(@Param("officeId") Long officeId, @Param("searchType") String searchType, @Param("searchValue") String searchValue);

    List<StudentDto> getSudentList(@Param("start") int start, @Param("end") int end,@Param("officeId") Long officeId, @Param("searchType") String searchType, @Param("searchValue") String searchValue);

    int getStudentMemoListCount(@Param("studentId") Long studentId, @Param("searchDate") String searchDate, @Param("memoType") String memoType,
                                @Param("memberName") String memberName, @Param("memoContent") String memoContent, @Param("processYn") Boolean processYn);

    List<StudentMemoDto> getStudentMemoList(@Param("start") int start, @Param("end") int end, @Param("studentId") Long studentId, @Param("searchDate") String searchDate,
                                            @Param("memoType") String memoType, @Param("memberName") String memberName, @Param("memoContent") String memoContent, @Param("processYn") Boolean processYn);

    List<StudentMemoReplyDto> getStudentMemoReplyList(@Param("start") int start, @Param("end") int end, @Param("studentMemoId") Long studentMemoId);

    StudentMemoDto getStudentMemoByStudentMemoId(@Param("studentMemoId") Long studentMemoId);

    int getStudentByPhoneNumber(@Param("phoneNumber") String phoneNumber);

    List<StudentDto> selectStudentListByLectureRegSearch(@Param("schoolType") String schoolType, @Param("searchType") String searchType, @Param("searchValue") String searchValue);

    Integer selectStudentListByLectureRegSearchCount(@Param("schoolType") String schoolType, @Param("searchType") String searchType, @Param("searchValue") String searchValue);

    int motherPhoneNumberCount(@Param("motherPhoneNumber") String motherPhoneNumber);

    Long test1(@Param("mediaKey") String mediaKey);

    List<StudentDto>selectStudentBrotherList(@Param("studentId") Long studentId);

    List<StudentSimpleMemo>selectStudentSimpleMemo(@Param("studentId") Long studentId);

    void test2(@Param("mediaKey") String mediaKey, @Param("t") String t, @Param("m") String m);

    void saveStudentInfo(StudentDto studentDto);

    void saveStudentInfoList(@Param("studentList") List<StudentDto> studentDtoList);

    void saveStudentMemo(@Param("studentId") Long studentId, @Param("flowMemberId") Long flowMemberId, @Param("memoContent") String memoContent,
                         @Param("memoType") String memoType, @Param("memoTitle") String memoTitle);

    void saveStudentMemoReply(@Param("studentMemoId") Long studentMemoId, @Param("flowMemberId") Long flowMemberId, @Param("replyContent") String replyContent);

    void saveStudentBrothers(@Param("brotherIdList") List<StudentBrotherDto>studentBrotherDtoList);

    void insertStudentBrother(StudentBrotherDto studentBrotherDto);

    void insertStudentSimpleMemo(@Param("studentId") Long studentId, @Param("flowMemberId") Long flowMemberId, @Param("memoContent") String memoContent);

    void modifyStudentInfo(StudentDto studentDto);

    void modifyMemoProcessYn(@Param("studentMemoId") Long studentMemoId, @Param("processYn") boolean processYn);

    void modifyStudentMemoReply(@Param("studentMemoReplyId") Long studentMemoReplyId, @Param("replyContent") String replyContent, @Param("deleteYn") boolean deleteYn);

    void updateStudentBrother(StudentBrotherDto studentBrotherDto);
}
