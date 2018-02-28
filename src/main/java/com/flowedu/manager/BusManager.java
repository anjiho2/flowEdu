package com.flowedu.manager;

import com.flowedu.define.datasource.BusType;
import com.flowedu.dto.BusAttendTimeDto;
import com.flowedu.dto.BusDismissTimeDto;
import com.flowedu.dto.BusInfoDto;
import com.flowedu.service.BusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Repository
public class BusManager {

    @Autowired
    private BusService busService;

    @Transactional(propagation = Propagation.REQUIRED)
    public Long saveRoute(BusInfoDto busInfoDto, List<BusAttendTimeDto> busAttendTimeDtoList, BusDismissTimeDto busDismissTimeDto) {
        if (busInfoDto == null) return null;
        //노선 기본 정보 입력(노선의 인덱스값 추출)
        Long busIdx = busService.saveBusInfo(busInfoDto);
        if (busIdx > 0L) {
            //등원 정보 입력
            if (busAttendTimeDtoList.size() > 0) {
                busService.saveBusAttendTimeList(busIdx, busAttendTimeDtoList);
            }
            //하원 정보 입력
            if (busDismissTimeDto != null) {
                busService.saveBusDismissInfo(busIdx, busDismissTimeDto);
            }
        }
        return busIdx;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyRoute(BusInfoDto busInfoDto, List<BusAttendTimeDto> busAttendTimeDtoList, BusDismissTimeDto busDismissTimeDto) {
        if (busInfoDto == null) return;
        //버스 기본정보 수정
        busService.modifyBusInfo(busInfoDto);
        //등원 시간정보 입력 및 수정
        if (busAttendTimeDtoList.size() > 0) {
            for (BusAttendTimeDto attendTimeDto : busAttendTimeDtoList) {
                if (attendTimeDto.getBusAttendTimeIdx() == null) {
                    busService.saveBusAttendTime(busInfoDto.getBusIdx(), attendTimeDto);
                }
            }
            busService.modifyBusAttendTime(busAttendTimeDtoList);
        }
        //하원 시간정보 입력 및 수정
        if (busDismissTimeDto.getBusDismissTimeIdx() == null) {
            busService.saveBusDismissInfo(busInfoDto.getBusIdx(), busDismissTimeDto);
        } else {
            busService.modifyBusDismissTime(busDismissTimeDto);
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
        for (int i=0; i<6; i++) {
            BusAttendTimeDto busAttendTimeDto = new BusAttendTimeDto();
            busAttendTimeDto.setStationName("정류소" + i);
            busAttendTimeDto.setFirstTime("11:00");
            busAttendTimeDto.setSecondTime("12:00");
            busAttendTimeDto.setThirdTime("13:00");
            busAttendTimeDto.setFourthTime("14:00");
            busAttendTimeDto.setFifthTime("15:00");
            busAttendTimeDto.setSixthTime("16:00");
            busAttendTimeDto.setBusIdx(5L);
            busAttendTimeDto.setSortNumber(i + 1);

            list.add(busAttendTimeDto);
        }
        BusDismissTimeDto dto = new BusDismissTimeDto();
        dto.setFirstTime("11:00");
        dto.setSecondTime("12:00");
        dto.setThirdTime("13:00");
        dto.setFourthTime("14:00");
        dto.setFifthTime("15:00");
        dto.setSixthTime("16:00");

        saveRoute(busInfoDto, list, dto);
    }
}
