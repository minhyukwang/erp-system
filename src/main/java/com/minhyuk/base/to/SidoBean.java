package com.minhyuk.base.to;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.to.BaseBean;

@Dataset(name="dsSido")
public class SidoBean extends BaseBean {
	private String sidoCode, sidoValue;

	public String getSidoCode() {
		return sidoCode;
	}

	public void setSidoCode(String sidoCode) {
		this.sidoCode = sidoCode;
	}

	public String getSidoValue() {
		return sidoValue;
	}

	public void setSidoValue(String sidoValue) {
		this.sidoValue = sidoValue;
	}

}
