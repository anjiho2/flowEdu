package com.flowedu.util;

import com.amazonaws.util.json.JSONException;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * Created by jihoan on 2017. 8. 9..
 */
public class GsonJsonReader {

    /**
     * GET방식 json 파싱
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

    public static void main(String[] args) {
        try {
            JsonObject obj = readJsonFromUrl("http://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=e72f78b94377a9f6c7d56a69ef44bf80&svcType=api&svcCode=SCHOOL&contentType=json&gubun=elem_list&region=100276&searchSchulNm=%ED%9D%AC%EB%A7%9D%EB%8C%80");
            JsonObject obj2 = obj.getAsJsonObject("dataSearch");
            JsonArray jArr = obj2.getAsJsonArray("content");
            System.out.println("arr >>>>>>>>>>>> " + jArr);
            JsonObject obj3 = jArr.get(0).getAsJsonObject();
            System.out.println("data >>>>>>>>>>>> " + obj3);
            String schoolName = obj3.get("schoolName").toString();
            System.out.println("result >>>>>>>>>>>> " + schoolName);


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
