package com.minhyuk.base.to;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.to.BaseBean;

@Dataset(name="dsDetailCode")
public class DetailCodeBean extends BaseBean {
	private String detailCode, detailCodename, detailUse, memo, distinctionCode;

	public String getDetailCode() {
		return detailCode;
	}

	public void setDetailCode(String detailCode) {
		this.detailCode = detailCode;
	}

	public String getDetailCodename() {
		return detailCodename;
	}

	public void setDetailCodename(String detailCodename) {
		this.detailCodename = detailCodename;
	}

	public String getDetailUse() {
		return detailUse;
	}

	public void setDetailUse(String detailUse) {
		this.detailUse = detailUse;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getDistinctionCode() {
		return distinctionCode;
	}

	public void setDistinctionCode(String distinctionCode) {
		this.distinctionCode = distinctionCode;
	}



}
