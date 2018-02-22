package com.flowedu.service;

import com.flowedu.config.PagingSupport;
import com.flowedu.define.datasource.BusType;
import com.flowedu.domain.DriverHelper;
import com.flowedu.domain.DriverList;
import com.flowedu.domain.DriverRoute;
import com.flowedu.dto.*;
import com.flowedu.mapper.BusMapper;
import com.flowedu.util.Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class BusService extends PagingSupport {

    @Autowired
    private BusMapper busMapper;

    protected static Logger logger = LoggerFactory.getLogger(BusService.class);

    /**
     * <PRE>
     * 1. Comment : 기사정보 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .07
     * </PRE>
     * @param driverIdx
     * @return
     */
    @Transactional(readOnly = true)
    public DriverInfoDto getDriverInfo(Long driverIdx) {
        if (driverIdx == 0L || driverIdx == null) return null;
        return busMapper.selectDriverInfo(driverIdx);
    }

    /**
     * <PRE>
     * 1. Comment : 통학도우미 정보 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .07
     * </PRE>
     * @param driverHelperIdx
     * @return
     */
    @Transactional(readOnly = true)
    public DriverHelperInfoDto getDriverHelperInfo(Long driverHelperIdx) {
        if (driverHelperIdx == 0L || driverHelperIdx == null) return null;
        return busMapper.selectDriverHelperInfo(driverHelperIdx);
    }

    /**
     * <PRE>
     * 1. Comment : 노선 정보 가져오기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .21
     * </PRE>
     * @param busIdx
     * @return
     */
    @Transactional(readOnly = true)
    public BusDto getBusRouteInfo(Long busIdx) {
        if (busIdx == null || busIdx == 0L) return null;
        BusDto busDto = busMapper.selectBusRouteInfo(busIdx);
        return busDto;

    }

    /**
     * <PRE>
     * 1. Comment : 기사 정보 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .21
     * </PRE>
     * @param sPage
     * @param pageListCount
     * @param officeId
     * @param searchType
     * @param searchValue
     * @return
     */
    @Transactional(readOnly = true)
    public List<DriverList> getDriverList(int sPage, int pageListCount, Long officeId, String searchType, String searchValue) {
        PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        return busMapper.selectDriverList(
                pagingDto.getStart(),
                pageListCount,
                officeId,
                Util.isNullValue(searchType, ""),
                Util.isNullValue(searchValue, "")
        );
    }

    @Transactional(readOnly = true)
    public int getDriverListCount(Long officeId, String searchType, String searchValue) {
        return busMapper.selectDriverListCount(officeId, searchType, searchValue);
    }

    /**
     * <PRE>
     * 1. Comment : 통학 도우미 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .21
     * </PRE>
     * @param driverIdx
     * @return
     */
    @Transactional(readOnly = true)
    public DriverHelper getDriverHelperList(Long driverIdx) {
        if (driverIdx == null || driverIdx == 0L) return null;
        return busMapper.selectDriverHelperList(driverIdx);
    }

    /**
     * <PRE>
     * 1. Comment : 노선 정보 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .22
     * </PRE>
     * @param driverIdx
     * @return
     */
    @Transactional(readOnly = true)
    public List<DriverRoute> getDriverRouteList(Long driverIdx) {
        if (driverIdx == null || driverIdx == 0L) return null;
        return busMapper.selectDrivetRouteInfo(driverIdx);
    }

    /**
     * <PRE>
     * 1. Comment : 기사정보 저장하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .07
     * </PRE>
     * @param officeId
     * @param jobPositionId
     * @param driverName
     * @param phoneNumber
     * @param birthDay
     * @param regDate
     * @param zipCode
     * @param address
     * @param addressDetail
     * @param busNumber
     * @param safetyCertificateDate
     * @param serveYn
     * @param sexualAssultConfirmDate
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveDriverInfo(Long officeId, int jobPositionId, String driverName, String phoneNumber, String birthDay,
                                  String regDate, String zipCode, String address, String addressDetail, String busNumber,
                                  int passengersNumber, String safetyCertificateDate, boolean serveYn, String sexualAssultConfirmDate) {

        DriverInfoDto driverInfoDto = new DriverInfoDto(
                officeId, jobPositionId, driverName, phoneNumber, birthDay, regDate, zipCode, address,
                addressDetail, busNumber, passengersNumber, safetyCertificateDate, serveYn, sexualAssultConfirmDate
        );
        busMapper.insertDriverInfo(driverInfoDto);
    }

    /**
     * <PRE>
     * 1. Comment : 통학도우미 정보 저장하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .07
     * </PRE>
     * @param driverIdx
     * @param officeId
     * @param helperName
     * @param phoneNumber
     * @param birthDay
     * @param regDate
     * @param zipCode
     * @param address
     * @param addressDetail
     * @param sexualAssultConfirmDate
     * @param serveYn
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveDriverHelperInfo(Long driverIdx, Long officeId, String helperName, String phoneNumber, String birthDay, String regDate,
                                     String zipCode, String address, String addressDetail, String sexualAssultConfirmDate, boolean serveYn) {
        DriverHelperInfoDto helperInfoDto = new DriverHelperInfoDto(
                officeId, driverIdx, helperName, phoneNumber, birthDay, regDate,
                zipCode, address, addressDetail, sexualAssultConfirmDate, serveYn
        );
        busMapper.insertDriverHelperInfo(helperInfoDto);
    }

    /**
     * <PRE>
     * 1. Comment : 노선 기본정보 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .07
     * </PRE>
     * @param busInfoDto
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Long saveBusInfo(BusInfoDto busInfoDto) {
        if (busInfoDto == null) return null;
        busMapper.insertBusInfo(busInfoDto);
        return busInfoDto.getBusIdx();
    }

    /**
     * <PRE>
     * 1. Comment : 등교 노선 정보 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 . 20
     * </PRE>
     * @param busIdx
     * @param busAttendTimeDtoList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveBusAttendTimsList(Long busIdx, List<BusAttendTimeDto>busAttendTimeDtoList) {
        if (busIdx == 0L && busAttendTimeDtoList.size() == 0) return;
        busAttendTimeDtoList.forEach(dto -> dto.setBusIdx(busIdx));
        busMapper.insertBusAttendTimeList(busAttendTimeDtoList);
    }

    /**
     * <PRE>
     * 1. Comment : 하교 노선 정보 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 . 20
     * </PRE>
     * @param busIdx
     * @param busDismissTimeDto
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveBusDismissInfo(Long busIdx, BusDismissTimeDto busDismissTimeDto) {
        if (busIdx == 0L && busDismissTimeDto == null) return;
        busDismissTimeDto.setBusIdx(busIdx);
        busMapper.insertBusDismissTimeInfo(busDismissTimeDto);
    }

    /**
     *
     * @param busInfoDto
     * @param busAttendTimeDtoList
     * @param busDismissTimeDto
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveRouteList(BusInfoDto busInfoDto, List<BusAttendTimeDto>busAttendTimeDtoList, BusDismissTimeDto busDismissTimeDto) {
        if (busInfoDto == null) return;
        //노선 기본 정보 입력
        busMapper.insertBusInfo(busInfoDto);
        //노선의 인덱스값 추출
        Long busIdx = busInfoDto.getBusIdx();

        if (busIdx > 0L) {
            //등원 정보 입력
            if (busAttendTimeDtoList.size() > 0) {
                //버스 아이디 주입
                busAttendTimeDtoList.forEach(dto -> dto.setBusIdx(busIdx));
                busMapper.insertBusAttendTimeList(busAttendTimeDtoList);
            }
            //하원 정보 입력
            if (busDismissTimeDto != null) {
                busDismissTimeDto.setBusIdx(busIdx);
                busMapper.insertBusDismissTimeInfo(busDismissTimeDto);
            }
        }
    }

    public void test() {

        BusInfoDto busInfoDto = new BusInfoDto();
        busInfoDto.setRouteNumber("노선 01");
        busInfoDto.setStartRouteName("수내역");
        busInfoDto.setEndRouteName("서현역");
        busInfoDto.setBusType(BusType.TERM.name());
        busInfoDto.setBusStatus(true);
        busInfoDto.setApplyStartDate("2017-01-01");
        busInfoDto.setApplyEndDate("2017-01-30");
        busInfoDto.setBusMemo("버스 메모");
         busInfoDto.setDriverIdx(1L);

        List<BusAttendTimeDto> list = new ArrayList<>();
        for (int i=13; i<18; i++) {
            BusAttendTimeDto busAttendTimeDto = new BusAttendTimeDto();
            long l = Long.valueOf(i);

            busAttendTimeDto.setBusAttendTimeIdx(l);
            busAttendTimeDto.setStationName("정류소" + i);
            busAttendTimeDto.setFirstTime("11:00");
            busAttendTimeDto.setSecondTime("12:00");
            busAttendTimeDto.setThirdTime("13:00");
            busAttendTimeDto.setFourthTime("14:00");
            busAttendTimeDto.setFifthTime("15:00");
            busAttendTimeDto.setSixthTime("16:00");
            busAttendTimeDto.setSortNumber(i + 1);
            busAttendTimeDto.setBusIdx(5L);

            list.add(busAttendTimeDto);
        }
        BusDismissTimeDto dto = new BusDismissTimeDto();
        dto.setFirstTime("11:00");
        dto.setSecondTime("12:00");
        dto.setThirdTime("13:00");
        dto.setFourthTime("14:00");
        dto.setFifthTime("15:00");
        dto.setSixthTime("16:00");

        modifyBusAttendTime(list);
       // saveRouteList(busInfoDto, list, dto);

    }
    /**
     * <PRE>
     * 1. Comment : 기사정보 수정하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .07
     * </PRE>
     * @param driverIdx
     * @param officeId
     * @param jobPositionId
     * @param driverName
     * @param phoneNumber
     * @param birthDay
     * @param regDate
     * @param zipCode
     * @param address
     * @param addressDetail
     * @param busNumber
     * @param passengersNumber
     * @param safetyCertificateDate
     * @param serveYn
     * @param sexualAssultConfirmDate
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyDriverInfo(Long driverIdx, Long officeId, int jobPositionId, String driverName, String phoneNumber, String birthDay,
                                 String regDate, String zipCode, String address, String addressDetail, String busNumber,
                                 int passengersNumber, String safetyCertificateDate, boolean serveYn, String sexualAssultConfirmDate) {
        DriverInfoDto driverInfoDto = new DriverInfoDto(
                driverIdx, officeId, jobPositionId, driverName, phoneNumber, birthDay, regDate, zipCode, address,
                addressDetail, busNumber, passengersNumber, safetyCertificateDate, serveYn, sexualAssultConfirmDate
        );
        busMapper.updateDriverInfo(driverInfoDto);
    }

    /**
     * <PRE>
     * 1. Comment : 통학도우미 정보 수정하기
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .07
     * </PRE>
     * @param driverHelperIdx
     * @param driverIdx
     * @param officeId
     * @param helperName
     * @param phoneNumber
     * @param birthDay
     * @param regDate
     * @param zipCode
     * @param address
     * @param addressDetail
     * @param sexualAssultConfirmDate
     * @param serveYn
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyDriverHelperInfo(Long driverHelperIdx, Long driverIdx, Long officeId, String helperName, String phoneNumber,
                                       String birthDay, String regDate, String zipCode, String address, String addressDetail,
                                       String sexualAssultConfirmDate, boolean serveYn) {
        DriverHelperInfoDto helperInfoDto = new DriverHelperInfoDto(
                driverHelperIdx, officeId, driverIdx, helperName, phoneNumber, birthDay, regDate,
                zipCode, address, addressDetail, sexualAssultConfirmDate, serveYn
        );
        busMapper.updateDriverHelperInfo(helperInfoDto);
    }

    /**
     * <PRE>
     * 1. Comment : 버스 등교 시간 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .20
     * </PRE>
     * @param busAttendTimeDtoList
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyBusAttendTime(List<BusAttendTimeDto>busAttendTimeDtoList) {
        if (busAttendTimeDtoList.size() == 0) return;
        busMapper.updateBusAttendTime(busAttendTimeDtoList);
    }

    /**
     * <PRE>
     * 1. Comment : 버스 하교 시간 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2018. 02 .20
     * </PRE>
     * @param busDismissTimeIdx
     * @param busIdx
     * @param firstTime
     * @param secondTime
     * @param thirdTime
     * @param fourthTime
     * @param fifthTime
     * @param sixthTime
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyBusDismissTime(Long busDismissTimeIdx, Long busIdx, String firstTime, String secondTime,
                                     String thirdTime, String fourthTime, String fifthTime, String sixthTime) {
        BusDismissTimeDto busDismissTimeDto = new BusDismissTimeDto(
                busDismissTimeIdx,
                busIdx,
                Util.isNullValue(firstTime, ""),
                Util.isNullValue(secondTime, ""),
                Util.isNullValue(thirdTime, ""),
                Util.isNullValue(fourthTime, ""),
                Util.isNullValue(fifthTime, ""),
                Util.isNullValue(sixthTime, "")
        );
        busMapper.updateBusDismissTime(busDismissTimeDto);
    }
}
