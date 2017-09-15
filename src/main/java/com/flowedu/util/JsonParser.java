package com.flowedu.util;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Json 파싱 유틸.
 *
 * @author <a href="mailto:pyeonzi20c@challabros.com">안영수</a>
 * @since 2015. 07. 15.
 */
public class JsonParser<T> {

    private final JSONObject jsonObject;

    public JsonParser(String json) throws ParseException {
        JSONParser jsonParser = new JSONParser();
        jsonObject = (JSONObject)jsonParser.parse(json);
    }

	/**
	 * <p>json string 으로부터 하나의 값을 파싱한다.</p>
	 * <p>{"name":1} ---> Long value = (Long)new JsonParser(jsonString).val("name");</p>
	 *
	 * @param param
	 * @return
	 */
    public T val(String param) {
        return (T)jsonObject.get(param);
    }

	/**
	 * <p>json string 으로부터 list 를 추출한다.</p>
	 *
	 * <p>사용예&gt;</p><br/>
	 * <p>{"arr":[1,2,3]} 에서 arr 프로퍼티에 해당하는 리스트를 추출.</p><br/>
	 * <p>List<Long> resultList = new JsonParser<Long>(jsonString).arr("arr");</p>
	 *
	 * @param param
	 * @return
	 * @throws IOException
	 */
	public List<T> arr(String param) throws IOException {
		JSONArray jsonArr = (JSONArray)this.val(param);
		T[] arr = (T[]) jsonArr.toArray();
		ArrayList<T> result = new ArrayList<>();
		Collections.addAll(result, arr);
		return result;
	}

}
