package com.minhyuk.accounting.slip.to;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.to.BaseBean;

@Dataset(name="dsTotalIncome")
public class TotalIncomeBean extends BaseBean{
	private String incomeYear, netProfit;

	public String getIncomeYear() {
		return incomeYear;
	}

	public void setIncomeYear(String incomeYear) {
		this.incomeYear = incomeYear;
	}

	public String getNetProfit() {
		return netProfit;
	}

	public void setNetProfit(String netProfit) {
		this.netProfit = netProfit;
	}


}
