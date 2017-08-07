package com.flowedu.mapper;

import com.flowedu.dto.OfficeDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by jihoan on 2017. 8. 7..
 */
public interface OfficeMapper {

    /** SELECT **/
    List<OfficeDto> getAcademyList(@Param("officeId") Long officeId);

    /** INSERT **/
    void saveAcademy(OfficeDto officeDto);

    /** UPDATE **/
    void modifyAcademy(OfficeDto officeDto);

    /** DELETE **/
    void deleteAcademy(@Param("officeId") Long officeId);
}
