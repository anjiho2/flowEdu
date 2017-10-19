package com.flowedu.service;

import com.flowedu.dto.AcademyGroupDto;
import com.flowedu.dto.FlowEduTeamDto;
import com.flowedu.dto.OfficeDto;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.OfficeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 7..
 */
@Service
public class AcademyService {

    @Autowired
    private OfficeMapper officeMapper;

    /**
     * <PRE>
     * 1. Comment : 학원정보 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @param officeId
     * @return
     */
    @Transactional(readOnly = true)
    public List<OfficeDto> getAcademyList(Long officeId) {
        return officeMapper.getAcademyList(officeId);
    } 

    /**
     * <PRE>
     * 1. Comment : 학원 그룹 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 09. 12
     * </PRE>
     * @return
     */
    @Transactional(readOnly = true)
    public List<AcademyGroupDto> getAcademyGroup() {
        return officeMapper.getAcademyGroup();
    }

    /**
     * <PRE>
     * 1. Comment : 학원정보 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @param officeName
     * @param officeDirectorName
     * @param officeAddress
     * @param officeTelNumber
     * @param officeFaxNumber
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveAcademy(String officeName, String officeDirectorName, String officeAddress,
        String officeTelNumber, String officeFaxNumber, int academyGroupId) {

        OfficeDto officeDto = new OfficeDto(
            officeName, officeDirectorName, officeTelNumber, officeAddress, officeFaxNumber, academyGroupId
        );
        officeMapper.saveAcademy(officeDto);
    }

    /**
     * <PRE>
     * 1. Comment : 학원정보 수정
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @param officeId
     * @param officeName
     * @param officeDirectorName
     * @param officeAddress
     * @param officeTelNumber
     * @param officeFaxNumber
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void modifyAcademy(Long officeId, String officeName, String officeDirectorName, String officeAddress,
        String officeTelNumber, String officeFaxNumber, int academyGroupId) {
        if (officeId == null || officeId < 1L) {
            throw new FlowEduException(FlowEduErrorCode.INTERNAL_ERROR);
        }
        OfficeDto officeDto = new OfficeDto(
            officeId, officeName, officeDirectorName, officeTelNumber, officeAddress, officeFaxNumber, academyGroupId
        );
        officeMapper.modifyAcademy(officeDto);
    }

    /**
     * <PRE>
     * 1. Comment : 학원정보 삭제
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 08 .07
     * </PRE>
     * @param officeId
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteAcademy(Long officeId) {
        if (officeId == null || officeId < 1L) {
            throw new FlowEduException(FlowEduErrorCode.INTERNAL_ERROR);
        }
        officeMapper.deleteAcademy(officeId);
    }

}
