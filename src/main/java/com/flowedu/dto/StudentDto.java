package com.flowedu.dto;

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
    private String motherParentName;

    //  학부모(모)전화번호
    private String motherPhoneNumber;

    //  학부모(부)이름
    private String fatherParentName;

    //  학부모(부)전화번호
    private String fatherPhoneNumber;

    //  학부모 비밀번호
    private String parentPassword;

    //  생성일
    private String createDate;

}
