package com.flowedu.mapper;

import org.apache.ibatis.annotations.Param;

/**
 * Created by jihoan on 2017. 9. 14..
 */
public interface PaymentMapper {

    void paymentLecture(@Param("lectureRelId") Long lectureRelId);

}
