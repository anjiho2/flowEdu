package com.flowedu.dto;

import lombok.Data;

@Data
public class DriverHelperInfoDto {

    //  도우미 인덱스
    private Long driverHelperIdx;

    //  기사 인덱스
    private Long driverIdx;

    //  학원 관 인덱스
    private Long officeId;

    //  도우미 이름
    private String helperName;

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

    //  성범죄 조회일
    private String sexualAssultConfirmDate;

    //  재직여부
    private Boolean serveYn;

    //  생성일
    private String createDate;

    public DriverHelperInfoDto() {}

    public DriverHelperInfoDto(Long officeId, Long driverIdx, String helperName, String phoneNumber, String birthDay,
                               String regDate, String zipCode, String address, String addressDetail, String sexualAssultConfirmDate, boolean serveYn) {
        this.officeId = officeId;
        this.driverIdx = driverIdx;
        this.helperName = helperName;
        this.phoneNumber = phoneNumber;
        this.birthDay = birthDay;
        this.regDate = regDate;
        this.zipCode = zipCode;
        this.address = address;
        this.addressDetail = addressDetail;
        this.sexualAssultConfirmDate = sexualAssultConfirmDate;
        this.serveYn = serveYn;
    }

    public DriverHelperInfoDto(Long driverHelperIdx, Long officeId, Long driverIdx, String helperName, String phoneNumber, String birthDay,
                               String regDate, String zipCode, String address, String addressDetail, String sexualAssultConfirmDate, boolean serveYn) {
        this.driverHelperIdx = driverHelperIdx;
        this.officeId = officeId;
        this.driverIdx = driverIdx;
        this.helperName = helperName;
        this.phoneNumber = phoneNumber;
        this.birthDay = birthDay;
        this.regDate = regDate;
        this.zipCode = zipCode;
        this.address = address;
        this.addressDetail = addressDetail;
        this.sexualAssultConfirmDate = sexualAssultConfirmDate;
        this.serveYn = serveYn;
    }
}
