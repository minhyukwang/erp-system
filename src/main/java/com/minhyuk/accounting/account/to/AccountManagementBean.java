package com.minhyuk.accounting.account.to;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.to.BaseBean;

@Dataset(name="dsAcountManagement")
public class AccountManagementBean extends BaseBean {
	private String managementCode, accountCode, accountManagementName, managementType, accountChange, accountUse;

	public String getManagementType() {
		return managementType;
	}

	public void setManagementType(String managementType) {
		this.managementType = managementType;
	}

	public String getManagementCode() {
		return managementCode;
	}

	public String getAccountChange() {
		return accountChange;
	}

	public void setAccountChange(String accountChange) {
		this.accountChange = accountChange;
	}

	public String getAccountManagementName() {
		return accountManagementName;
	}

	public void setAccountManagementName(String accountManagementName) {
		this.accountManagementName = accountManagementName;
	}

	public String getAccountUse() {
		return accountUse;
	}

	public void setAccountUse(String accountUse) {
		this.accountUse = accountUse;
	}

	public void setManagementCode(String managementCode) {
		this.managementCode = managementCode;
	}

	public String getAccountCode() {
		return accountCode;
	}

	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

}
