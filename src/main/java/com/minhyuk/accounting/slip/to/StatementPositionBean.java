package com.minhyuk.accounting.slip.to;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.to.BaseBean;

@Dataset(name="dsStatementPosition")
public class StatementPositionBean extends BaseBean{
	private String accountCode, parentAccount, accountName, amt, totalAmt,
							statementYear;

	public String getStatementYear() {
		return statementYear;
	}

	public void setStatementYear(String statementYear) {
		this.statementYear = statementYear;
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
