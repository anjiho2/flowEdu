package com.flowedu.service;

import com.flowedu.dto.DriverHelperInfoDto;
import com.flowedu.dto.DriverInfoDto;
import com.flowedu.mapper.BusMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BusService {

    @Autowired
    private BusMapper busMapper;

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

    @Transactional(readOnly = true)
    public DriverHelperInfoDto getDriverHelperInfo(Long driverHelperIdx) {
        if (driverHelperIdx == 0L || driverHelperIdx == null) return null;
        return busMapper.selectDriverHelperInfo(driverHelperIdx);
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
     * @param passengersNumber
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
}
