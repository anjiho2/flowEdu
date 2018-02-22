package com.flowedu.domain;

import lombok.Data;

@Data
public class DriverRoute {

    private Long busIdx;

    private String routeNumber;

    private String startRouteName;

    private String endRouteName;

    private String busType;

    private Boolean busStatus;

    private int attendCount;

    private int dismissCount;
}
