package com.flowedu.error;

public class FlowEduException extends RuntimeException {
	public FlowEduException(int errorCode)
    {
        this.errorCode = errorCode;
        message = null;
    }

    public FlowEduException(int errorCode, String message)
    {
        this(errorCode);
        this.message = message;
    }

    public FlowEduException(FlowEduErrorCode flowEduErrorCode)
    {
        errorCode = flowEduErrorCode.code();
        message = flowEduErrorCode.msg();
    }

    public FlowEduException(FlowEduErrorCode flowEduErrorCode, String message)
    {
        errorCode = flowEduErrorCode.code();
    }

    public int getErrorCode()
    {
        return errorCode;
    }

    public String getMessage()
    {
        return message;
    }

    private final int errorCode;
    private String message;
}
