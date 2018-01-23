package com.flowedu.api.service;

import com.flowedu.define.datasource.RequestMethod;
import com.flowedu.domain.RequestApi;
import com.flowedu.util.GsonJsonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SendService extends ApiService {

    protected static final Logger logger = LoggerFactory.getLogger(SendService.class);

    /**
     * API서버에 이메일 예약 값 저장하기
     * @param emailList
     * @return
     * @throws Exception
     */
    public RequestApi reserveEmail(List<String>emailList) throws Exception {
        String jsonStr = GsonJsonUtil.convertToJsonString(emailList);
        RequestApi requestApi = responseRestfulApi(concatURI("send", "reserve_email"), RequestMethod.REQUEST_METHOD_POST, jsonStr);
        return requestApi;
    }


}
