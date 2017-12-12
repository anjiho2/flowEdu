package com.flowedu.error;

public enum FlowEduErrorCode {

	 	NOT_AUTHENTICATE(401, "Not authenticated"),
		NOT_AUTHORIZED(403, "Not authorized"),
		INTERNAL_ERROR(500, "Internal server error"),
		BAD_REQUEST(400, "Bad request, parameter not accepted"),
	 	NOT_ALLOW_FILE_NAME_KOREAN(901, "not allow korean name"),
	 	CUSTOM_DATA_LIST_NULL(902, "data list is null!"),
		CUSTOM_IMAGE_FILE_NAME_KOREAN(903, "image file name is Korean!"),
		CUSTOM_IMAGE_FILE_EXTENSION_NOT_ALLOW(904, "image file extension not allow!"),
		CUSTOM_IMAGE_FILE_SIZE_LIMIT(905, "image file size limit error 300kb!"),
		CUSTOM_PAYMENT_ACCESS_CODE_NULL(911, "payment access code is null!");

		int code;
		String msg;
		
		FlowEduErrorCode(int code, String msg){
			this.msg = msg;
			this.code = code;
		}

	    public int code()
	    {
	        return code;
	    }

	    public String msg()
	    {
	        return msg;
	    }
}
