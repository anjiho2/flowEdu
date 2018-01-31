package com.flowedu.api.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.flowedu.api.dto.EmailSendReservationDto;
import com.flowedu.api.dto.SmsSendInfoDto;
import com.flowedu.define.datasource.RequestMethod;
import com.flowedu.define.datasource.SmsSendData;
import com.flowedu.domain.RequestApi;
import com.flowedu.dto.LectureAttendDto;
import com.flowedu.dto.StudentDto;
import com.flowedu.mapper.StudentMapper;
import com.flowedu.util.GsonJsonUtil;
import com.flowedu.util.StringUtil;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class SendService extends ApiService {

    protected static final Logger logger = LoggerFactory.getLogger(SendService.class);

    @Autowired
    private StudentMapper studentMapper;

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

    public RequestApi sendAttendSms(List<LectureAttendDto>lectureAttendDtoList, String smsSendCode) {
        if (lectureAttendDtoList.size() == 0) return null;
        List<String>phoneNumbers = new ArrayList<>();
        for (LectureAttendDto dto : lectureAttendDtoList) {
            StudentDto studentDto = studentMapper.getStudentInfo(dto.getStudentId());
            phoneNumbers.add(studentDto.getMotherPhoneNumber());
        }
        String[] stringPhoneNumbers = StringUtil.listToStringArray(phoneNumbers);
        String motherPhoneNumbers = StringUtil.stringJoin(stringPhoneNumbers, ",");
        SmsSendInfoDto smsSendInfoDto = new SmsSendInfoDto(motherPhoneNumbers, smsSendCode);

        RequestApi requestApi = responseRestfulApi(concatURI("message", "send_sms"), RequestMethod.REQUEST_METHOD_POST, smsSendInfoDto.toString());
        return requestApi;

    }

}
