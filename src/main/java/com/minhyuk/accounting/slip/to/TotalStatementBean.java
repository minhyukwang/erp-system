package com.minhyuk.accounting.slip.to;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.to.BaseBean;

@Dataset(name="dsTotalStatement")
public class TotalStatementBean extends BaseBean{
	private String statementYear, assetTotal, capitalTotal, debtTotal;

	public String getStatementYear() {
		return statementYear;
	}

	public void setStatementYear(String statementYear) {
		this.statementYear = statementYear;
	}

	public String getAssetTotal() {
		return assetTotal;
	}

	public void setAssetTotal(String assetTotal) {
		this.assetTotal = assetTotal;
	}

	public String getCapitalTotal() {
		return capitalTotal;
	}

	public void setCapitalTotal(String capitalTotal) {
		this.capitalTotal = capitalTotal;
	}

	public String getDebtTotal() {
		return debtTotal;
	}

	public void setDebtTotal(String debtTotal) {
		this.debtTotal = debtTotal;
	}


}
