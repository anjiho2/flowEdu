package com.flowedu.service;

import com.flowedu.define.datasource.SchoolType;
import com.flowedu.dto.StudentDto;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.StudentMapper;
import com.flowedu.util.JsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by jihoan on 2017. 8. 8..
 */
@Service
public class StudentService {

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
}
