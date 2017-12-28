package com.flowedu.service;

import com.flowedu.dto.StudentDto;
import com.flowedu.mapper.StudentMapper;
import com.flowedu.util.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

    protected static final Logger logger = LoggerFactory.getLogger(ExcelReadService.class);

    @Autowired
    private StudentMapper studentMapper;

    /**
     * <PRE>
     * 1. Comment : 학생 정보 엑셀 추출 후 저장하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 10 .16
     * </PRE>
     * @param destFile
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public String readStudentExcel(File destFile) throws Exception {
        ExcelReadOption excelReadOption = new ExcelReadOption();
        //엑셀 파일 담기
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        excelReadOption.setOutputColumns("A", "B", "C", "E", "F", "G", "H", "I");
        excelReadOption.setStartRow(2);
        List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);

        List<StudentDto> studentDtoList = new ArrayList<>();
        for (Map<String, String> article : excelContent) {
            String studentNames = article.get("A");
            String genders = article.get("B");
            String birthDays = article.get("C");
            String studentPhoneNumbers = article.get("D");
            String schoolNames = article.get("E");
            String schoolTypes = article.get("F");
            Integer studentGrades = Integer.parseInt(article.get("G"));
            String motherNames = article.get("H");
            String motherPhoneNumbers = article.get("I");

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
                    studentNames, studentPaswords, genders, birthDays, studentPhoneNumbers,
                    schoolNames, schoolTypes, studentGrades, motherNames, motherPhoneNumbers
            );
            studentDtoList.add(studentDto);
        }
        studentMapper.saveStudentInfoList(studentDtoList);
        FileUtil.fileDelete(destFile.toString());
        return "SUCCESS";
    }

    public String readExcel(File destFile) throws Exception {
        //VideoUtils.getImageFromFrame(destFile);

        ExcelReadOption excelReadOption = new ExcelReadOption();
        //엑셀 파일 담기
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        excelReadOption.setOutputColumns("C", "F");
        excelReadOption.setStartRow(2);
        List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);

        List<StudentDto> studentDtoList = new ArrayList<>();
        for (Map<String, String> article : excelContent) {
            //logger.info("C....." + article.get("C"));
            String mediaKey = article.get("C");
            if (!"".equals(mediaKey)) {
                Long idx = studentMapper.test1(article.get("C"));
                if (idx != null) {
                    String thumbnail = null;
                    String fileName = article.get("F");
                    if (!"".equals(article.get("F")) || article.get("F") != null) {
                        thumbnail = FileUtil.removeFileExtension(article.get("F")) + "_preview.jpg";
                    }
                    studentMapper.test2(article.get("C"), thumbnail, fileName);
                }
            }
            //String studentEmails = article.get("F");



           // studentDtoList.add(studentDto);
        }
        //studentMapper.saveStudentInfoList(studentDtoList);
        return "SUCCESS";
    }
}
