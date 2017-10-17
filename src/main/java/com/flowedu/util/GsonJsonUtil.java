package com.flowedu.util;

import com.amazonaws.Request;
import com.amazonaws.util.json.JSONException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.flowedu.config.FlowEduApiConfigHolder;
import com.flowedu.define.datasource.RequestMethod;
import com.flowedu.dto.LecturePaymentLogDto;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.apache.poi.ss.formula.functions.T;
import org.json.simple.JSONObject;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

/**
 * Created by jihoan on 2017. 8. 9..
 */
public class GsonJsonUtil {

    /**
     * URL GET방식 json 파싱
     * @param surl
     * @return
     * @throws IOException
     * @throws JSONException
     */
    public static JsonObject readJsonFromUrl(String surl) throws IOException, JSONException {
        URL url = new URL(surl);
        HttpURLConnection request = (HttpURLConnection) url.openConnection();
        request.connect();

        JsonParser parser = new JsonParser();
        JsonElement root = parser.parse(new InputStreamReader((InputStream) request.getContent()));
        JsonObject rootObj = root.getAsJsonObject();
        return rootObj;
    }

    /**
     * restful api 방식 url 콜 후 stringbody로 리턴값 받기
     * @param url
     * @param jsonStr
     * @param requestMethod
     * @return
     */
    public static String restfulApi(String url, String jsonStr, RequestMethod requestMethod) {
        String resultJsonStr = null;
        HttpPost post = null;
        HttpPut put = null;
        HttpDelete delete = null;
        HttpGet get = null;
        HttpResponse response = null;
        try (CloseableHttpClient httpClient = HttpClientBuilder.create().build()){
            if (requestMethod.equals(RequestMethod.REQUEST_METHOD_POST)) {
                post = new HttpPost(url);
                StringEntity entity = new StringEntity(jsonStr.toString());
                post.addHeader("content-type", "application/json");
                post.setEntity(entity);
                response = httpClient.execute(post);
            } else if (requestMethod.equals(RequestMethod.REQUEST_METHOD_PUT)) {
                put = new HttpPut(url);
                response = httpClient.execute(put);
            } else if (requestMethod.equals(RequestMethod.REQUEST_METHOD_DELETE)) {
                delete = new HttpDelete(url);
                response = httpClient.execute(delete);
            } else if (requestMethod.equals(RequestMethod.REQUEST_METHOD_GET)) {
                get = new HttpGet(url);
                response = httpClient.execute(get);
            }
            resultJsonStr = EntityUtils.toString(response.getEntity(), "UTF-8");

            if (response.getStatusLine().getStatusCode() != 200) {
                throw new FlowEduException(FlowEduErrorCode.INTERNAL_ERROR);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return resultJsonStr;
    }

    /**
     * flowdeu-api url 만들기
     * @param paths
     * @return
     */
    public static String concatURI(String... paths) {
        StringBuilder builder = new StringBuilder();
        builder.append(FlowEduApiConfigHolder.getFlowEduApiUrl());
        for (String path : paths) {
            if (path == null) continue;
            path = path.trim();
            path = "/" + path;
            builder.append(path);
        }
        return builder.toString();
    }

    public static<T> String convertToJsonString(T t) throws Exception {
        return new ObjectMapper().writeValueAsString(t);
    }

    public static void main(String[] args) {

    }

}
