package com.flowedu.mapper;

import com.amazonaws.services.dynamodbv2.xspec.L;
import com.flowedu.dto.AcademyGroupDto;
import com.flowedu.dto.FlowEduTeamDto;
import com.flowedu.dto.OfficeDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 7..
 */
public interface OfficeMapper {

    /** SELECT **/
    List<OfficeDto> getAcademyList(@Param("officeId") Long officeId);

    OfficeDto getAcademyInfo(@Param("officeId") Long officeId);

    List<FlowEduTeamDto> getFlowEduTeamList(@Param("teamId") Integer teamId);

    List<AcademyGroupDto> getAcademyGroup(@Param("academyGroupId") Integer academyGroupId);

    List<OfficeDto> getAcademyListByGourpId(@Param("academyGroupId") Long academyGroupId);

    int getAcademyListBySearchCount(@Param("academyGroupId") Long academyGroupId,
                                    @Param("officeId") Long officeId, @Param("startDate") String startDate,
                                    @Param("endDate") String endDate, @Param("regType") String regType, @Param("searchText") String searchText);

    List<OfficeDto> getAcademyListBySearch(@Param("start") int start, @Param("end") int end,  @Param("academyGroupId") Long academyGroupId,
                                           @Param("officeId") Long officeId, @Param("startDate") String startDate,
                                           @Param("endDate") String endDate, @Param("regType") String regType, @Param("searchText") String searchText);

    /** INSERT **/
    void saveAcademy(OfficeDto officeDto);

    /** UPDATE **/
    void modifyAcademy(OfficeDto officeDto);

    /** DELETE **/
    void deleteAcademy(@Param("officeId") Long officeId);
}
