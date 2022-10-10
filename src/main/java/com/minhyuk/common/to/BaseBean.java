package com.minhyuk.common.to;

public class BaseBean{
	protected String status,errorCode,errorMsg;

	public String getStatus() {
		return status;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}