package com.flowedu.domain;

import lombok.Data;

@Data
public class DriverList {

    private Long driverIdx;

    private String officeName;

    private String startRouteName;

    private String endRouteName;

    private String driverName;

    private String busNumber;

    private String phoneNumber;

    private String applyStartDate;

    private String applyEndDate;
}
