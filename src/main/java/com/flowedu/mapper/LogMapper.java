package com.flowedu.mapper;

import com.flowedu.dto.LecturePaymentLogDto;
import org.apache.ibatis.annotations.Param;

/**
 * Created by jihoan on 2017. 9. 14..
 */
public interface LogMapper {

    void saveLecturePaymentLog(LecturePaymentLogDto lecturePaymentLogDto);

}
