package com.flowedu.dto;

import lombok.Data;

@Data
public class DriverInfoDto {

    //  기사 인덱스
    private Long driverIdx;

    //  학원 관 인덱스
    private Long officeId;

    //  직책 인덱스
    private Integer jobPositionId;

    //  기사 이름
    private String driverName;

    //  핸드폰 번호
    private String phoneNumber;

    //  생일
    private String birthDay;

    //  등록일
    private String regDate;

    //  우편번호
    private String zipCode;

    //  주소
    private String address;

    //  상세주소
    private String addressDetail;

    //  차량번호
    private String busNumber;

    //  승차정원
    private Integer passengersNumber;

    //  안전필증
    private String safetyCertificateDate;

    //  재직여부
    private Boolean serveYn;

    //  성범죄조회일
    private String sexualAssultConfirmDate;

    //  생성일
    private String createDate;

    public DriverInfoDto() {}

    public DriverInfoDto(Long officeId, Integer jobPositionId, String driverName, String phoneNumber, String birthDay,
                         String regDate, String zipCode, String address, String addressDetail, String busNumber,
                         Integer passengersNumber, String safetyCertificateDate, boolean serveYn, String sexualAssultConfirmDate) {
        this.officeId = officeId;
        this.jobPositionId = jobPositionId;
        this.driverName = driverName;
        this.phoneNumber = phoneNumber;
        this.birthDay = birthDay.equals("") ? null : birthDay;
        this.regDate = regDate;
        this.zipCode = zipCode;
        this.address = address;
        this.addressDetail = addressDetail;
        this.busNumber = busNumber;
        this.passengersNumber = passengersNumber;
        this.safetyCertificateDate = safetyCertificateDate;
        this.serveYn = serveYn;
        this.sexualAssultConfirmDate = sexualAssultConfirmDate;
    }

    public DriverInfoDto(Long driverIdx, Long officeId, Integer jobPositionId, String driverName, String phoneNumber, String birthDay,
                         String regDate, String zipCode, String address, String addressDetail, String busNumber,
                         Integer passengersNumber, String safetyCertificateDate, boolean serveYn, String sexualAssultConfirmDate) {
        this.driverIdx = driverIdx;
        this.officeId = officeId;
        this.jobPositionId = jobPositionId;
        this.driverName = driverName;
        this.phoneNumber = phoneNumber;
        this.birthDay = birthDay;
        this.regDate = regDate;
        this.zipCode = zipCode;
        this.address = address;
        this.addressDetail = addressDetail;
        this.busNumber = busNumber;
        this.passengersNumber = passengersNumber;
        this.safetyCertificateDate = safetyCertificateDate;
        this.serveYn = serveYn;
        this.sexualAssultConfirmDate = sexualAssultConfirmDate;
    }

}
