package com.flowedu.dto;

import com.flowedu.util.Aes256;
import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 8..
 */
@Data
public class StudentDto {

    //  학생 아이디
    private Long studentId;

    //  학생 이름
    private String studentName;

    //  학생 비밀번호
    private String studentPassword;

    //  학생 성별
    private String studentGender;

    //  학생 생일
    private String studentBirthday;

    //  집 전화번호
    private String homeTelNumber;

    //  학생 전화번호
    private String studentPhoneNumber;

    //  학생 이메일
    private String studentEmail;

    //  학교 이름
    private String schoolName;

    //  학교 타입(초,중,고)
    private String schoolType;

    //  학생 학년
    private Integer studentGrade;

    //  학생 사진 파일명
    private String studentPhotoFile;

    //  학생 사진 파일 경로명
    private String studentPhotoUrl;

    //  학생 관련 메모
    private String studentMemo;

    //  학부모(모)이름
    private String motherName;

    //  학부모(모)전화번호
    private String motherPhoneNumber;

    //  학부모(부)이름
    private String fatherName;

    //  학부모(부)전화번호
    private String fatherPhoneNumber;

    //  학부모 비밀번호
    private String parentPassword;

    //  생성일
    private String createDate;

    public StudentDto() {}

    public StudentDto(String studentName, String studentPassword, String studentGender, String studentBirthday, String homeTelNumber,
                      String studentPhoneNumber, String studentEmail, String schoolName, String schoolType, int studentGrade,
                      String studentPhotoFile, String studentPhotoUrl, String studentMemo, String motherName, String motherPhoneNumber,
                      String fatherName, String fatherPhoneNumber) throws Exception {
        this.studentName = studentName;
        this.studentPassword = Aes256.encrypt(studentPassword);
        this.studentGender = studentGender;
        this.studentBirthday = studentBirthday;
        this.homeTelNumber = homeTelNumber;
        this.studentPhoneNumber = studentPhoneNumber;
        this.studentEmail = studentEmail;
        this.schoolName = schoolName;
        this.schoolType = schoolType;
        this.studentGrade = studentGrade;
        this.studentPhotoFile = studentPhotoFile;
        this.studentPhotoUrl = studentPhotoUrl;
        this.studentMemo = studentMemo;
        this.motherName = motherName;
        this.motherPhoneNumber = motherPhoneNumber;
        this.fatherName = fatherName;
        this.fatherPhoneNumber = fatherPhoneNumber;
    }

    public StudentDto(Long studentId, String studentName, String studentGender, String studentBirthday, String homeTelNumber,
                      String studentPhoneNumber, String studentEmail, String schoolName, String schoolType, int studentGrade,
                      String studentPhotoFile, String studentPhotoUrl, String studentMemo, String motherName, String motherPhoneNumber,
                      String fatherName, String fatherPhoneNumber) throws Exception {
        this.studentId = studentId;
        this.studentName = studentName;
        this.studentGender = studentGender;
        this.studentBirthday = studentBirthday;
        this.homeTelNumber = homeTelNumber;
        this.studentPhoneNumber = studentPhoneNumber;
        this.studentEmail = studentEmail;
        this.schoolName = schoolName;
        this.schoolType = schoolType;
        this.studentGrade = studentGrade;
        this.studentPhotoFile = studentPhotoFile;
        this.studentPhotoUrl = studentPhotoUrl;
        this.studentMemo = studentMemo;
        this.motherName = motherName;
        this.motherPhoneNumber = motherPhoneNumber;
        this.fatherName = fatherName;
        this.fatherPhoneNumber = fatherPhoneNumber;
    }

}
