package com.flowedu.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

public class CreateSESSION {
	
	final static Logger logger = LoggerFactory.getLogger(CreateSESSION.class);

	public static HashMap<String, Object> sessionCF(HttpServletRequest request) throws Exception {
		String userId = request.getParameter("user_id");
		String userPass = request.getParameter("user_pass");
		
		logger.info("userId : " + userId);
		logger.info("userPass : " + userPass);

		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("userId", userId);
		resultMap.put("userPass", userPass);
		request.setAttribute("loginInfo", resultMap);

		return resultMap;
	}
}
