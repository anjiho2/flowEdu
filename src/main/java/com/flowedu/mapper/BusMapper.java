package com.flowedu.mapper;

import com.flowedu.dto.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 21..
 */
public interface BusMapper {

    DriverInfoDto selectDriverInfo(@Param("driverIdx") Long driverIdx);

    DriverHelperInfoDto selectDriverHelperInfo(@Param("driverHelperIdx") Long driverHelperIdx);

    /** INSERT **/
    void insertDriverInfo(DriverInfoDto driverInfoDto);

    void insertDriverHelperInfo(DriverHelperInfoDto driverHelperInfoDto);

    void insertBusInfo(BusInfoDto busInfoDto);

    void insertBusAttendTimeList(@Param("busAttendTimeList")List<BusAttendTimeDto>busAttendTimeDtoList);

    void insertBusDismissTimeInfo(BusDismissTimeDto busDismissTimeDto);

    /** UPDATE **/
    void updateDriverInfo(DriverInfoDto driverInfoDto);

    void updateDriverHelperInfo(DriverHelperInfoDto driverHelperInfoDto);

    void updateBusAttendTime(@Param("attendTimeList") List<BusAttendTimeDto> busAttendTimeDtoList);

    void updateBusDismissTime(BusDismissTimeDto busDismissTimeDto);
}
