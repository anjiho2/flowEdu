package com.flowedu.dto;

import lombok.Data;

/**
 * Created by jihoan on 2017. 8. 7..
 */
@Data
public class OfficeDto {
    //  자동증가값
    private Long officeId;

    //  관명
    private String officeName;

    //  원장이름
    private String officeDirectorName;

    //  관 전화번호
    private String officeTelNumber;

    //  주소
    private String officeAddress;

    //  팩스번호
    private String officeFaxNumber;

    //  생성일
    private String createDate;

    private int academyGroupId;

    private String academyGroupName;

    public OfficeDto() {}

    public OfficeDto(String officeName, String officeDirectorName, String officeTelNumber, String officeAddress,
                     String officeFaxNumber, int academyGroupId) {
        this.officeName = officeName;
        this.officeDirectorName = officeDirectorName;
        this.officeTelNumber = officeTelNumber;
        this.officeAddress = officeAddress;
        this.officeFaxNumber = officeFaxNumber;
        this.academyGroupId = academyGroupId;
    }

    public OfficeDto(Long officeId, String officeName, String officeDirectorName, String officeTelNumber,
        String officeAddress, String officeFaxNumber, int academyGroupId) {
        this.officeId = officeId;
        this.officeName = officeName;
        this.officeDirectorName = officeDirectorName;
        this.officeTelNumber = officeTelNumber;
        this.officeAddress = officeAddress;
        this.officeFaxNumber = officeFaxNumber;
        this.academyGroupId = academyGroupId;
    }
}
