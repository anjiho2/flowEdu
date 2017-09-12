package com.flowedu.service;

import com.flowedu.config.PagingSupport;
import com.flowedu.config.SchoolSearchConfigHoler;
import com.flowedu.define.datasource.SchoolType;
import com.flowedu.define.datasource.StudentMemoType;
import com.flowedu.domain.StudentMemo;
import com.flowedu.dto.PagingDto;
import com.flowedu.dto.StudentDto;
import com.flowedu.dto.StudentMemoDto;
import com.flowedu.dto.StudentMemoReplyDto;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.StudentMapper;
import com.flowedu.session.UserSession;
import com.flowedu.util.GsonJsonReader;
import com.flowedu.util.JsonBuilder;
import com.flowedu.util.JsonParser;
import com.flowedu.util.Util;
import com.google.api.client.json.Json;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.simple.JSONObject;
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
            map.put("schoolTypeCode", SchoolType.getSchoolTypeCode(i).toString());
            map.put("schoolTypeName", SchoolType.getSchoolTypeName(i));
            Arr.add(map);
        }
        return Arr;
    }

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
    public int getSudentListCount(String gubun, String studentName) {
        return studentMapper.getSudentListCount(Util.isNullValue(gubun, ""), Util.isNullValue(studentName, ""));
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
    public List<StudentDto> getSudentList(int sPage, int pageListCount, String gubun, String studentName) {
        PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        List<StudentDto> list = studentMapper.getSudentList(pagingDto.getStart(), pageListCount, Util.isNullValue(gubun, ""), Util.isNullValue(studentName, ""));
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
        if ("".equals(gubun) && region == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        String schoolSearchApikey = SchoolSearchConfigHoler.getSchoolSearchApiKey();
        String schoolSearchApiUrl = SchoolSearchConfigHoler.getSchoolSearchApiUrl();
        String url = schoolSearchApiUrl + "?apiKey=" + schoolSearchApikey + "&svcType=api&svcCode=SCHOOL&contentType=json&gubun="
                + gubun + "&region=" + region + "&searchSchulNm=" + URLEncoder.encode(searchScoolName, "UTF-8");

        JsonObject jsonStr = GsonJsonReader.readJsonFromUrl(url);
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
    public int getStudentMemoListCount(Long studentId, String searchDate, String memoType, String memberName, String memoContent) {
        return studentMapper.getStudentMemoListCount(
                studentId, Util.isNullValue(searchDate, ""), Util.isNullValue(memoType, ""),
                Util.isNullValue(memberName, ""), Util.isNullValue(memoContent, "")
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
                                                   String memoType, String memberName, String memoContent) {
        PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        List<StudentMemoDto> list = studentMapper.getStudentMemoList(
                pagingDto.getStart(), pageListCount, studentId, Util.isNullValue(searchDate, ""),
                Util.isNullValue(memoType, ""), Util.isNullValue(memberName, ""), Util.isNullValue(memoContent, "")
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
        return studentMapper.getStudentMemoList(0, 3, studentId, "", "", "", "");
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
     * 1. Comment : 학생정보 입력하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .08
     * </PRE>
     * @param studentDto
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveStudentInfo(StudentDto studentDto) throws Exception {
        if (studentDto == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        StudentDto dto = new StudentDto(
            studentDto.getStudentName(), studentDto.getStudentPassword(), studentDto.getStudentGender(),
            studentDto.getStudentBirthday(), studentDto.getHomeTelNumber(), studentDto.getStudentPhoneNumber(),
            studentDto.getStudentEmail(), studentDto.getSchoolName(), studentDto.getSchoolType(),
            studentDto.getStudentGrade(), studentDto.getStudentPhotoFile(), studentDto.getStudentPhotoUrl(),
            studentDto.getStudentMemo(), studentDto.getMotherName(), studentDto.getMotherPhoneNumber(),
            studentDto.getFatherName(), studentDto.getFatherPhoneNumber()
        );
        studentMapper.saveStudentInfo(dto);
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
    public void saveStudentMemo(Long studentId, String memoContent, String memoType) {
        if (studentId < 1L) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        Long flowMemberId = UserSession.flowMemberId();
        studentMapper.saveStudentMemo(studentId, flowMemberId, memoContent, memoType);
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
     * 1. Comment : 학생정보 수정하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .08
     * </PRE>
     * @param studentDto
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyStudentInfo(StudentDto studentDto) throws Exception {
        if (studentDto == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        StudentDto dto = new StudentDto(
                studentDto.getStudentId(), studentDto.getStudentPassword(), studentDto.getStudentName(), studentDto.getStudentGender(),
                studentDto.getStudentBirthday(), studentDto.getHomeTelNumber(), studentDto.getStudentPhoneNumber(),
                studentDto.getStudentEmail(), studentDto.getSchoolName(), studentDto.getSchoolType(),
                studentDto.getStudentGrade(), studentDto.getStudentPhotoFile(), studentDto.getStudentPhotoUrl(),
                studentDto.getStudentMemo(), studentDto.getMotherName(), studentDto.getMotherPhoneNumber(),
                studentDto.getFatherName(), studentDto.getFatherPhoneNumber()
        );
        studentMapper.modifyStudentInfo(dto);
    }

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
