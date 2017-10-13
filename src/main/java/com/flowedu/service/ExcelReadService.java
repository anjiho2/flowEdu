package com.flowedu.service;

import com.flowedu.dto.StudentDto;
import com.flowedu.mapper.StudentMapper;
import com.flowedu.util.ExcelRead;
import com.flowedu.util.ExcelReadOption;
import com.flowedu.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by jihoan on 2017. 10. 13..
 */
@Service
public class ExcelReadService {

    @Autowired
    private StudentMapper studentMapper;

    @Transactional(propagation = Propagation.REQUIRED)
    public String readStudentExcel(File destFile) throws Exception {
        ExcelReadOption excelReadOption = new ExcelReadOption();
        //엑셀 파일 담기
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P");
        excelReadOption.setStartRow(2);
        List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);

        List<StudentDto> studentDtoList = new ArrayList<>();
        for (Map<String, String> article : excelContent) {
            String studentNames = article.get("A");
            String genders = article.get("B");
            String birthDays = article.get("C");
            String homeTelNumbers = article.get("D");
            String studentPhoneNumbers = article.get("E");
            String studentEmails = article.get("F");
            String schoolNames = article.get("G");
            String schoolTypes = article.get("H");
            Integer studentGrades = Integer.parseInt(article.get("I"));
            String memos = article.get("J");
            String motherNames = article.get("K");
            String motherPhoneNumbers = article.get("L");
            String fatherNames = article.get("M");
            String fatherPhoneNumbers = article.get("N");
            String etcNames = article.get("O");
            String etcPhoneNumbers = article.get("P");

            if ("".equals(studentNames) || "".equals(genders) || "".equals(birthDays) || "".equals(schoolTypes)
                    || studentGrades == null || studentGrades == 0 || "".equals(motherNames) || "".equals(motherPhoneNumbers)) {
                return "VALUE_EMPTY";
            }
            int motherPhoneNumberCount = studentMapper.motherPhoneNumberCount(motherPhoneNumbers);
            if (motherPhoneNumberCount > 0) {
                return "MOTHER_" + motherPhoneNumbers;
            }
            String studentPaswords = StringUtil.leaveLastStrNum(motherPhoneNumbers, 4);

            StudentDto studentDto = new StudentDto(
                studentNames, studentPaswords, genders, birthDays, homeTelNumbers,
                studentPhoneNumbers, studentEmails, schoolNames, schoolTypes, studentGrades,
                "", "", memos, motherNames, motherPhoneNumbers,
                fatherNames, fatherPhoneNumbers, etcNames, etcPhoneNumbers
            );
            studentDtoList.add(studentDto);
        }
        studentMapper.saveStudentInfoList(studentDtoList);
        return "SUCCESS";
    }
}
