package com.flowedu.api.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.flowedu.api.dto.EmailSendReservationDto;
import com.flowedu.define.datasource.RequestMethod;
import com.flowedu.domain.RequestApi;
import com.flowedu.util.GsonJsonUtil;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class SendService extends ApiService {

    protected static final Logger logger = LoggerFactory.getLogger(SendService.class);

    /**
     * API서버에 이메일 예약 값 저장하기
     * @param emailAddress
     * @param name
     * @param phoneNumber
     * @param authKey
     * @return
     * @throws Exception
     */
    public RequestApi reserveEmail(String emailAddress, String name, String phoneNumber, String authKey) throws Exception {
        EmailSendReservationDto reservationDto = new EmailSendReservationDto(
                emailAddress, name, phoneNumber, authKey
        );
        List<EmailSendReservationDto>reservationList = new ArrayList<>(Arrays.asList(reservationDto));
        String jsonStr = GsonJsonUtil.convertToJsonString(reservationList);
        RequestApi requestApi = responseRestfulApi(concatURI("message", "save_email"), RequestMethod.REQUEST_METHOD_POST, jsonStr);
        return requestApi;
    }

}
