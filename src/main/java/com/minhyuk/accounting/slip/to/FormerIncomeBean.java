package com.minhyuk.accounting.slip.to;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.to.BaseBean;

@Dataset(name="dsFormerIncome")
public class FormerIncomeBean extends BaseBean{
	private String accountCode, parentAccount, accountName, amt, totalAmt,
							incomeYear;
	public String getIncomeYear() {
		return incomeYear;
	}

	public void setIncomeYear(String incomeYear) {
		this.incomeYear = incomeYear;
	}

	public String getAccountCode() {
		return accountCode;
	}

	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	public String getParentAccount() {
		return parentAccount;
	}

	public void setParentAccount(String parentAccount) {
		this.parentAccount = parentAccount;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAmt() {
		return amt;
	}

	public void setAmt(String amt) {
		this.amt = amt;
	}

	public String getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}


}
