package com.flowedu.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.flowedu.config.FlowEduApiConfigHolder;
import com.flowedu.define.datasource.DataSource;
import com.flowedu.define.datasource.DataSourceType;
import com.flowedu.define.datasource.RequestMethod;
import com.flowedu.dto.LecturePaymentLogDto;
import com.flowedu.mapper.LectureMapper;
import com.flowedu.mapper.LogMapper;
import com.flowedu.util.GsonJsonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;

/**
 * Created by jihoan on 2017. 9. 14..
 */
@Service
public class LogService {

    protected static final Logger logger = LoggerFactory.getLogger(LogService.class);

    public String lecturePaymentLog(LecturePaymentLogDto lecturePaymentLogDto) throws Exception {
        String json = GsonJsonUtil.convertToJsonString(lecturePaymentLogDto);
        String resultStr = GsonJsonUtil.restfulApi(GsonJsonUtil.concatURI("log", "payment"), json, RequestMethod.REQUEST_METHOD_POST);
        return resultStr;
    }
}
