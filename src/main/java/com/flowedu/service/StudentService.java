package com.flowedu.service;

import com.flowedu.config.ConfigHolder;
import com.flowedu.config.PagingSupport;
import com.flowedu.define.datasource.SchoolType;
import com.flowedu.define.datasource.StudentMemoType;
import com.flowedu.domain.StudentMemo;
import com.flowedu.domain.StudentSimpleMemo;
import com.flowedu.dto.*;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.StudentMapper;
import com.flowedu.session.UserSession;
import com.flowedu.util.GsonJsonUtil;
import com.flowedu.util.JsonParser;
import com.flowedu.util.Util;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by jihoan on 2017. 8. 8..
 */
@Service
public class StudentService extends PagingSupport {

    private final Logger logger = LoggerFactory.getLogger(StudentService.class);

    @Autowired
    private StudentMapper studentMapper;

    /**
     * <PRE>
     * 1. Comment : 학교 타입 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .04
     * </PRE>
     * @return [ {schoolTypeCode:"ELEMENT", schoolTypeName:"초등학교"}, .....]
     */
    public List<HashMap<String, Object>> getSchoolTypeList() {
        List<HashMap<String, Object>> Arr = new ArrayList<>();

        for (int i=0; i<SchoolType.size(); i++) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("id", SchoolType.getSchoolTypeCode(i).toString());
            map.put("name", SchoolType.getSchoolTypeName(i));
            Arr.add(map);
        }
        return Arr;
    }

    /**
     * <PRE>
     * 1. Comment : 메모 타입 정보 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 09 .12
     * </PRE>
     * @return
     */
    public List<HashMap<String, Object>> getStudentMemoTypeList() {
        List<HashMap<String, Object>> Arr = new ArrayList<>();

        for (int i = 0; i < StudentMemoType.values().length; i++) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("memoCode", StudentMemoType.getStudentMemoTypeCode(i).toString());
            map.put("memoName", StudentMemoType.getStudentMemoTypeName(i));
            Arr.add(map);
        }
        return Arr;
    }

    /**
     * <PRE>
     * 1. Comment : 학생 정보 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .08
     * </PRE>
     * @param studentId
     * @return
     */
    @Transactional(readOnly = true)
    public StudentDto getStudentInfo(Long studentId) {
        if (studentId == null || studentId < 1L) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        return studentMapper.getStudentInfo(studentId);
    }

    /**
     * <PRE>
     * 1. Comment : 학생 리스트 개수 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .08
     * </PRE>
     * @return
     */
    @Transactional(readOnly = true)
    public int getSudentListCount(String searchType, String searchValue) {
        return studentMapper.getSudentListCount(
                UserSession.officeId(),
                Util.isNullValue(searchType, ""),
                Util.isNullValue(searchValue, "")
        );
    }

    /**
     * <PRE>
     * 1. Comment : 학생 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .08
     * </PRE>
     * @param sPage
     * @param pageListCount
     * @return
     */
    @Transactional(readOnly = true)
    public List<StudentDto> getSudentList(int sPage, int pageListCount, String searchType, String searchValue) {
        PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        List<StudentDto> list = studentMapper.getSudentList(
                pagingDto.getStart(),
                pageListCount,
                UserSession.officeId(),
                Util.isNullValue(searchType, ""),
                Util.isNullValue(searchValue, "")
        );
        return list;
    }

    /**
     * <PRE>
     * 1. Comment : 학교 검색 API
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .08
     * </PRE>
     * @param gubun
     * @param region
     * @param searchScoolName
     * @return
     * @throws Exception
     */
    public String getApiSchoolName(String gubun, Integer region, String searchScoolName) throws Exception {
        if (gubun == null || region == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        String schoolSearchApikey = ConfigHolder.getSchoolSearchApiKey();
        String schoolSearchApiUrl = ConfigHolder.getSchoolSearchApiUrl();
        String url = schoolSearchApiUrl + "?apiKey=" + schoolSearchApikey + "&svcType=api&svcCode=SCHOOL&contentType=json&gubun="
                + gubun + "&region=" + region + "&searchSchulNm=" + URLEncoder.encode(searchScoolName, "UTF-8");

        JsonObject jsonStr = GsonJsonUtil.readJsonFromUrl(url);
        JsonObject firstJsonObjet = jsonStr.getAsJsonObject("dataSearch");
        JsonArray jsonArray = firstJsonObjet.getAsJsonArray("content");
        if (jsonArray.size() == 0) {
            return null;
        }
        JsonObject contentJsonObj = jsonArray.get(0).getAsJsonObject();
        JsonParser jsonParser = new JsonParser(contentJsonObj.toString());
        return  (String)jsonParser.val("schoolName");
    }

    /**
     * <PRE>
     * 1. Comment : 학생 메모 리스트 개수
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .28
     * </PRE>
     * @param studentId
     * @return
     */
    @Transactional(readOnly = true)
    public int getStudentMemoListCount(Long studentId, String searchDate, String memoType, String memberName, String memoContent, Boolean processYn) {
        return studentMapper.getStudentMemoListCount(
                studentId, Util.isNullValue(searchDate, ""), Util.isNullValue(memoType, ""),
                Util.isNullValue(memberName, ""), Util.isNullValue(memoContent, ""), processYn
        );
    }

    /**
     * <PRE>
     * 1. Comment : 학생 메모 리스트 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .28
     * </PRE>
     * @param sPage
     * @param pageListCount
     * @param studentId
     * @return
     */
    @Transactional(readOnly = true)
    public List<StudentMemoDto> getStudentMemoList(int sPage, int pageListCount, Long studentId, String searchDate,
                                                   String memoType, String memberName, String memoContent, Boolean processYn) {
        PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        List<StudentMemoDto> list = studentMapper.getStudentMemoList(
                pagingDto.getStart(), pageListCount, studentId, Util.isNullValue(searchDate, ""),
                Util.isNullValue(memoType, ""), Util.isNullValue(memberName, ""),
                Util.isNullValue(memoContent, ""), processYn
        );
        return list;
    }

    /**
     * <PRE>
     * 1. Comment : 학생 메모 리스트 가져오기(최근 3건)
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .28
     * </PRE>
     * @param studentId
     * @return
     */
    @Transactional(readOnly = true)
    public List<StudentMemoDto> getStudentMemoLastThree(Long studentId) {
        return studentMapper.getStudentMemoList(0, 5, studentId, "", "", "", "", null);
    }

    /**
     * <PRE>
     * 1. Comment : 메모상세정보와 상제 정보의 댓글 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 09 .11
     * </PRE>
     * @param sPage
     * @param pageListCount
     * @param studentMemoId
     * @return
     */
    @Transactional(readOnly = true)
    public StudentMemo getStudentMemoReplyList(int sPage, int pageListCount, Long studentMemoId) {
        PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        StudentMemoDto studentMemoDto = studentMapper.getStudentMemoByStudentMemoId(studentMemoId);
        List<StudentMemoReplyDto> list = studentMapper.getStudentMemoReplyList(pagingDto.getStart(), pageListCount, studentMemoId);
        StudentMemo studentMemo = new StudentMemo(studentMemoDto, list);

        return studentMemo;
    }

    /**
     * <PRE>
     * 1. Comment : 특정 전화번호로 학생, 엄마, 아빠, 기타 전화번호중 존재하는 번호인지 확인하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 09 .11
     * </PRE>
     * @param phoneNumber
     * @return
     */
    @Transactional(readOnly = true)
    public boolean isStudentByPhoneNumber(String phoneNumber) {
        if ("".equals(phoneNumber)) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        int result = studentMapper.getStudentByPhoneNumber(phoneNumber);
        if (result == 0) {
            return false;
        }
        return true;
    }

    /**
     * <PRE>
     * 1. Comment : 강의에 등록가능한 학생 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 03 .13
     * </PRE>
     * @param schoolType
     * @param searchType
     * @param searchValue
     * @return
     */
    @Transactional(readOnly = true)
    public List<StudentDto> getStudentListByLectureRegSearch(String schoolType, String searchType, String searchValue) {
        //PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        List<StudentDto> Arr = studentMapper.selectStudentListByLectureRegSearch(
                Util.isNullValue(schoolType, ""),
                Util.isNullValue(searchType, ""),
                Util.isNullValue(searchValue, "")
        );
        return Arr;
    }

    /**
     * <PRE>
     * 1. Comment : 강의에 등록가능한 학생 리스트 개수
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 03 .13
     * </PRE>
     * @param schoolType
     * @param searchType
     * @param searchValue
     * @return
     */
    @Transactional(readOnly = true)
    public Integer getStudentListByLectureRegSearchCount(String schoolType, String searchType, String searchValue) {
        return studentMapper.selectStudentListByLectureRegSearchCount(
                Util.isNullValue(schoolType, ""),
                Util.isNullValue(searchType, ""),
                Util.isNullValue(searchValue, "")
        );
    }

    /**
     * <PRE>
     * 1. Comment : 학생의 형제 정보 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 04 .01
     * </PRE>
     * @param studentId
     * @return
     */
    @Transactional(readOnly = true)
    public List<StudentDto>getStudentBrother(Long studentId) {
        return studentMapper.selectStudentBrotherList(studentId);
    }

    /**
     * <PRE>
     * 1. Comment : 학생의 간단 메모 정보 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 04 .01
     * </PRE>
     * @param studentId
     * @return
     */
    @Transactional(readOnly = true)
    public List<StudentSimpleMemo>getStudentSimpleMemo(Long studentId) {
        if (studentId == null) return null;
        return studentMapper.selectStudentSimpleMemo(studentId);
    }

    /**
     * <PRE>
     * 1. Comment : 학생정보 입력하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .08
     * </PRE>
     * @param studentDto
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Long saveStudentInfo(StudentDto studentDto, List<StudentBrotherDto>studentBrotherDtoList) throws Exception {
        if (studentDto == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        StudentDto dto = new StudentDto(
            studentDto.getStudentName(), studentDto.getStudentPassword(), studentDto.getStudentGender(),
            studentDto.getStudentBirthday(), studentDto.getHomeTelNumber(), studentDto.getStudentPhoneNumber(),
            studentDto.getStudentEmail(), studentDto.getSchoolName(), studentDto.getSchoolType(),
            studentDto.getStudentGrade(), studentDto.getStudentPhotoFile(), studentDto.getStudentPhotoUrl(),
            studentDto.getStudentMemo(), studentDto.getMotherName(), studentDto.getMotherPhoneNumber(),
            studentDto.getFatherName(), studentDto.getFatherPhoneNumber(), studentDto.getEtcName(), studentDto.getEtcPhoneNumber(),
            studentDto.getOfficeId(), studentDto.isBusBoardYn(), studentDto.getStudentStatus()
        );
        studentMapper.saveStudentInfo(dto);
        //메모내용이 있을때 메모 테이블에 내용추가 (2018. 04. 01 안지호)
        if (!"".equals(studentDto.getStudentMemo())) {
            studentMapper.insertStudentSimpleMemo(
                    studentDto.getStudentId(),
                    UserSession.flowMemberId(),
                    studentDto.getStudentMemo()
            );
        }
        //형제 정보가 있을때 입력
        if (studentBrotherDtoList.size() > 0) {
            for (StudentBrotherDto brotherDto : studentBrotherDtoList) {
                if (brotherDto.getBrotherId() != null) {
                    brotherDto.setStudentId(dto.getStudentId());
                    studentMapper.insertStudentBrother(brotherDto);
                }
            }
        }
        return dto.getStudentId();
    }

    /**
     * <PRE>
     * 1. Comment : 학생 메모 저장하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .28
     * </PRE>
     * @param studentId
     * @param memoContent
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveStudentMemo(Long studentId, String memoContent, String memoType, String memoTitle) {
        if (studentId < 1L) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        Long flowMemberId = UserSession.flowMemberId();
        studentMapper.saveStudentMemo(studentId, flowMemberId, memoContent, memoType, memoTitle);
    }

    /**
     * <PRE>
     * 1. Comment : 학생 메모 댓글 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 09 .11
     * </PRE>
     * @param studentMemoId
     * @param replyContent
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveStudentMemoReply(Long studentMemoId, String replyContent) {
        if (studentMemoId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        studentMapper.saveStudentMemoReply(studentMemoId, UserSession.flowMemberId(), replyContent);
    }

    /**
     * <PRE>
     * 1. Comment : 학생 형제 저장하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 04 .01
     * </PRE>
     * @param studentId
     * @param brotherIds
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveStudentBrothers(Long studentId, List<Long>brotherIds) {
        if (brotherIds.size() == 0) return;
        List<StudentBrotherDto>Arr = new ArrayList<>();
        for (Long brotherId : brotherIds) {
            StudentBrotherDto brotherDto = new StudentBrotherDto(brotherId, studentId);
            Arr.add(brotherDto);
        }
        studentMapper.saveStudentBrothers(Arr);
    }

    /**
     * <PRE>
     * 1. Comment : 학생 간단 메모 저장히기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 04 .01
     * </PRE>
     * @param studentId
     * @param memoContent
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveStudentSimpleMemo(Long studentId, String memoContent) {
        if (studentId == null) return;
        studentMapper.insertStudentSimpleMemo(studentId, UserSession.flowMemberId(), memoContent);
    }

    /**
     * <PRE>
     * 1. Comment : 학생정보 수정하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .08
     * </PRE>
     * @param studentDto
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyStudentInfo(StudentDto studentDto, List<StudentBrotherDto>studentBrotherDtoList) throws Exception {
        if (studentDto == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        StudentDto dto = new StudentDto(
                studentDto.getStudentId(), studentDto.getStudentPassword(), studentDto.getStudentName(), studentDto.getStudentGender(),
                studentDto.getStudentBirthday(), studentDto.getHomeTelNumber(), studentDto.getStudentPhoneNumber(),
                studentDto.getStudentEmail(), studentDto.getSchoolName(), studentDto.getSchoolType(),
                studentDto.getStudentGrade(), studentDto.getStudentPhotoFile(), studentDto.getStudentPhotoUrl(),
                studentDto.getStudentMemo(), studentDto.getMotherName(), studentDto.getMotherPhoneNumber(),
                studentDto.getFatherName(), studentDto.getFatherPhoneNumber(), studentDto.getEtcName(), studentDto.getEtcPhoneNumber(),
                studentDto.getStudentStatus(), studentDto.isBusBoardYn()
        );
        studentMapper.modifyStudentInfo(dto);
        //메모내용이 있을때 메모 테이블에 내용추가 (2018. 04. 01 안지호)
        if (!"".equals(studentDto.getStudentMemo())) {
            studentMapper.insertStudentSimpleMemo(
                    studentDto.getStudentId(),
                    UserSession.flowMemberId(),
                    studentDto.getStudentMemo()
            );
        }
        if (studentBrotherDtoList.size() == 0) return;
        for (StudentBrotherDto brotherDto : studentBrotherDtoList) {
            if (brotherDto.getStudentBrotherId() != null) {
                studentMapper.updateStudentBrother(brotherDto);
            } else {
                if (brotherDto.getBrotherId() == null) return;
                studentMapper.insertStudentBrother(brotherDto);
            }
        }
    }

    /**
     * <PRE>
     * 1. Comment : 메모 상태 변경
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 09 .12
     * </PRE>
     * @param studentMemoId
     * @param processYn
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyMemoProcessYn(Long studentMemoId, boolean processYn) {
        studentMapper.modifyMemoProcessYn(studentMemoId, processYn);
    }

    /**
     * <PRE>
     * 1. Comment : 메모 댓글 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 09 .11
     * </PRE>
     * @param studentMemoReplyId
     * @param replyContent
     * @param deleteYn
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyStudentMemoReply(Long studentMemoReplyId, String replyContent, boolean deleteYn) {
        if (studentMemoReplyId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        studentMapper.modifyStudentMemoReply(studentMemoReplyId, replyContent, deleteYn);
    }

}
