package com.flowedu.service;

import com.flowedu.define.datasource.DataSource;
import com.flowedu.define.datasource.DataSourceType;
import com.flowedu.dto.LecturePaymentLogDto;
import com.flowedu.dto.LectureStudentRelByIdDto;
import com.flowedu.mapper.LectureMapper;
import com.flowedu.mapper.LogMapper;
import com.flowedu.session.UserSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by jihoan on 2017. 9. 14..
 */
@Service
public class LogService {

    @Autowired
    private LectureMapper lectureMapper;

    @Autowired
    private LogMapper logMapper;

    @DataSource(DataSourceType.LOG)
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void lecturePaymentLog(LecturePaymentLogDto lecturePaymentLogDto) {
        if (lecturePaymentLogDto == null) return;
        logMapper.saveLecturePaymentLog(lecturePaymentLogDto);
    }
}
