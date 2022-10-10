package com.minhyuk.base.to;

import java.util.List;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.annotation.Remove;
import com.minhyuk.common.to.BaseBean;

@Dataset(name="dsCode")
public class CodeBean extends BaseBean {
	private String distinctionCode, codeName, codeUse;

	private List<DetailCodeBean> detailCodeBeanList;
	@Remove
	public List<DetailCodeBean> getDetailCodeBeanList() {
		return detailCodeBeanList;
	}
	@Remove
	public void setDetailCodeBeanList(List<DetailCodeBean> detailCodeBeanList) {
		this.detailCodeBeanList = detailCodeBeanList;
	}

	public String getDistinctionCode() {
		return distinctionCode;
	}

	public void setDistinctionCode(String distinctionCode) {
		this.distinctionCode = distinctionCode;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public String getCodeUse() {
		return codeUse;
	}

	public void setCodeUse(String codeUse) {
		this.codeUse = codeUse;
	}


}
