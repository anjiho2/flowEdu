package com.flowedu.error;

public enum FlowEduErrorCode {

	 	NOT_AUTHENTICATE(401, "Not authenticated"),
		NOT_AUTHORIZED(403, "Not authorized"),
		INTERNAL_ERROR(500, "Internal server error"),
		BAD_REQUEST(400, "Bad request, parameter not accepted"),
	 	NOT_ALLOW_FILE_NAME_KOREAN(901, "not allow korean name"),
	 	CUSTOM_DATA_LIST_NULL(902, "data list is null!"),
		CUSTOM_PAYMENT_ACCESS_CODE_NULL(911, "payment access code is null!!");

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
