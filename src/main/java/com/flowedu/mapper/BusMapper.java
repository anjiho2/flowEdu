package com.flowedu.mapper;

import com.flowedu.domain.DriverHelper;
import com.flowedu.domain.DriverList;
import com.flowedu.domain.DriverRoute;
import com.flowedu.dto.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 21..
 */
public interface BusMapper {

    DriverInfoDto selectDriverInfo(@Param("driverIdx") Long driverIdx);

    DriverHelperInfoDto selectDriverHelperInfo(@Param("driverHelperIdx") Long driverHelperIdx);

    BusDto selectBusRouteInfo(@Param("busIdx") Long busIdx);

    List<DriverList> selectDriverList(@Param("start") int start, @Param("end") int end, @Param("officeId") Long officeId,
                                      @Param("searchType") String searchType, @Param("searchValue") String searchValue);

    int selectDriverListCount(@Param("officeId") Long officeId, @Param("searchType") String searchType, @Param("searchValue") String searchValue);

    DriverHelper selectDriverHelperList(@Param("driverIdx") Long driverIdx);

    List<DriverRoute> selectDrivetRouteInfo(@Param("driverIdx") Long driverIdx);

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
