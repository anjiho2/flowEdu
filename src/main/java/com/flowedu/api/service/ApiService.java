package com.flowedu.api.service;

import com.flowedu.config.ConfigHolder;
import com.flowedu.define.datasource.RequestMethod;
import com.flowedu.domain.RequestApi;
import com.flowedu.error.FlowEduException;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by jihoan on 2017. 10. 17..
 */
public abstract class ApiService {

    protected static final Logger logger = LoggerFactory.getLogger(ApiService.class);

    /**
     * restful url response
     * @param url
     * @param requestMethod
     * @param jsonBody
     * @return
     */
    public RequestApi responseRestfulApi(String url, RequestMethod requestMethod, String jsonBody) {
        RequestApi requestApi = null;
        HttpResponse response = null;
        HttpPost httpPost;
        HttpPut httpPut;
        HttpDelete httpDelete;
        HttpGet httpGet;

        logger.info("call url ------------> " + url);

        try (CloseableHttpClient httpClient = HttpClientBuilder.create().build()) {
            if (requestMethod.equals(RequestMethod.REQUEST_METHOD_POST)) {
                httpPost = new HttpPost(url);
                StringEntity entity = new StringEntity(jsonBody.toString(), "UTF-8");
                httpPost.addHeader("content-type", "application/json");
                httpPost.setEntity(entity);
                response = httpClient.execute(httpPost);
            } else if (requestMethod.equals(RequestMethod.REQUEST_METHOD_PUT)) {
                httpPut = new HttpPut(url);
                response = httpClient.execute(httpPut);
            } else if (requestMethod.equals(RequestMethod.REQUEST_METHOD_DELETE)) {
                httpDelete = new HttpDelete(url);
                response = httpClient.execute(httpDelete);
            } else if (requestMethod.equals(RequestMethod.REQUEST_METHOD_GET)) {
                httpGet = new HttpGet(url);
                response = httpClient.execute(httpGet);
            }
            String requestBody = EntityUtils.toString(response.getEntity(), "UTF-8");
            int httpStatusCode = response.getStatusLine().getStatusCode();

            logger.info("http status code -----------------> " + httpStatusCode);

            if (httpStatusCode != 200) {
                throw new FlowEduException(response.getStatusLine().getStatusCode());
            }
            requestApi = new RequestApi(requestBody, httpStatusCode);
            logger.info("response result -----------------> " + requestApi.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return requestApi;
    }

    /**
     * url 만들기
     * @param paths
     * @return
     */
    public String concatURI(String... paths) {
        StringBuilder builder = new StringBuilder();
        builder.append(ConfigHolder.getFlowEduApiUrl());
        for (String path : paths) {
            if (path == null) continue;
            path = path.trim();
            path = "/" + path;
            builder.append(path);
        }
        return builder.toString();
    }
}
