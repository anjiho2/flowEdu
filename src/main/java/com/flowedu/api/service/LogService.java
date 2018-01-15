package com.flowedu.api.service;

import com.flowedu.api.dto.MemberLoginLogDto;
import com.flowedu.define.datasource.KisPosAuthType;
import com.flowedu.define.datasource.RequestMethod;
import com.flowedu.domain.LecturePaymentLog;
import com.flowedu.domain.RequestApi;
import com.flowedu.dto.FlowEduMemberDto;
import com.flowedu.dto.LecturePaymentLogDto;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.util.GsonJsonUtil;
import com.flowedu.util.JsonParser;
import com.flowedu.util.Util;
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sun.misc.Request;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by jihoan on 2017. 9. 14..
 */
@Service
public class LogService extends ApiService {

    protected static final Logger logger = LoggerFactory.getLogger(LogService.class);

    @Autowired
    private HttpServletRequest request;

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
    public RequestApi memberLoginLog(FlowEduMemberDto flowEduMemberDto, String connectIp) throws Exception {
        MemberLoginLogDto memberLoginLogDto = new MemberLoginLogDto(
                flowEduMemberDto.getFlowMemberId(), flowEduMemberDto.getMemberName(), connectIp
        );
        String jsonStr = GsonJsonUtil.convertToJsonString(memberLoginLogDto);
        RequestApi requestApi = responseRestfulApi(
                concatURI("log", "login_log"),
                RequestMethod.REQUEST_METHOD_POST,
                jsonStr
        );
        return requestApi;
    }

    /**
     * 결재 로그 리스트 가져오기
     * @param lectureRelId
     * @return
     * @throws Exception
     */
    public List<LecturePaymentLog> getLecturePaymentLog(Long lectureRelId) {
        if (lectureRelId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        List<LecturePaymentLog> Arr = new ArrayList<>();

        RequestApi requestApi = responseRestfulApi(
                concatURI("log", "payment", "receipt_list", String.valueOf(lectureRelId)),
                RequestMethod.REQUEST_METHOD_GET,
                null
        );
        String resultJson = requestApi.getBody();
        if (resultJson == null) {
            return Arr;
        }
        JsonArray jsonArray = GsonJsonUtil.readJsonFromJsonString(resultJson);

        for (JsonElement element : jsonArray) {
            JsonObject object = element.getAsJsonObject();

            Gson gson = new Gson();
            LecturePaymentLog lecturePaymentLog = new LecturePaymentLog();
            lecturePaymentLog = gson.fromJson(object, LecturePaymentLog.class);
            Arr.add(lecturePaymentLog);
        }
        return Arr;
    }

    /**
     * 결재 로그 아이디에 따른 결재 로그 정보 가져오기
     * @param lecturePaymentLogId
     * @return
     * @throws Exception
     */
    public LecturePaymentLog getLecturePaymentLogInfo(Long lecturePaymentLogId) {
        if (lecturePaymentLogId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        RequestApi requestApi = responseRestfulApi(
                concatURI("log", "payment", "receipt_list_payment_log_id", String.valueOf(lecturePaymentLogId)),
                RequestMethod.REQUEST_METHOD_GET,
                null
        );
        String resultJson = requestApi.getBody();
        JsonArray jsonArray = GsonJsonUtil.readJsonFromJsonString(resultJson);

        LecturePaymentLog lecturePaymentLog = new LecturePaymentLog();
        for (JsonElement element : jsonArray) {
            JsonObject object = element.getAsJsonObject();

            Gson gson = new Gson();
            lecturePaymentLog = gson.fromJson(object, LecturePaymentLog.class);
        }
        return lecturePaymentLog;
    }

    /**
     *
     * @param lecturePaymentLogId
     * @return
     * @throws Exception
     */
    public int cancelPaymentLog(Long lecturePaymentLogId) {
        if (lecturePaymentLogId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        RequestApi requestApi = responseRestfulApi(
                concatURI("log", "payment", "cancel", String.valueOf(lecturePaymentLogId)),
                RequestMethod.REQUEST_METHOD_PUT,
                null
        );
        return requestApi.getHttpStatusCode();
    }
}
