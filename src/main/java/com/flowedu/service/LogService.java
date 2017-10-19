package com.flowedu.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.flowedu.config.FlowEduApiConfigHolder;
import com.flowedu.define.datasource.DataSource;
import com.flowedu.define.datasource.DataSourceType;
import com.flowedu.define.datasource.RequestMethod;
import com.flowedu.domain.RequestApi;
import com.flowedu.dto.FlowEduMemberDto;
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
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;

/**
 * Created by jihoan on 2017. 9. 14..
 */
@Service
public class LogService extends ApiService {

    protected static final Logger logger = LoggerFactory.getLogger(LogService.class);

    /**
     * 결재 로그 저장
     * @param lecturePaymentLogDto
     * @return
     * @throws Exception
     */
    public RequestApi lecturePaymentLog(LecturePaymentLogDto lecturePaymentLogDto) throws Exception {
        String jsonStr = GsonJsonUtil.convertToJsonString(lecturePaymentLogDto);
        RequestApi requestApi = responseRestfulApi(concatURI("log", "payment"), RequestMethod.REQUEST_METHOD_POST, jsonStr);
        return requestApi;
    }

    /**
     * 회원 로그인 로그 저장
     * @param flowEduMemberDto
     * @return
     * @throws Exception
     */
    public RequestApi memberLoginLog(FlowEduMemberDto flowEduMemberDto) throws Exception {
        String jsonStr = GsonJsonUtil.convertToJsonString(flowEduMemberDto);
        RequestApi requestApi = responseRestfulApi(concatURI("log", "login_log"), RequestMethod.REQUEST_METHOD_POST, jsonStr);
        return requestApi;
    }
}
