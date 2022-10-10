package com.minhyuk.accounting.account.to;

import java.util.List;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.annotation.Remove;
import com.minhyuk.common.to.BaseBean;

@Dataset(name="dsAccount")
public class AccountBean extends BaseBean {
	private String level, accountCode, parentAccount, accountName, accountBalance, accountChange, accountUse;
	private List<AccountManagementBean> accountManagementBeanList;

	@Remove
	public List<AccountManagementBean> getAccountManagementBeanList() {
		return accountManagementBeanList;
	}

	@Remove
	public void setAccountManagementBeanList(List<AccountManagementBean> accountManagementBeanList) {
		this.accountManagementBeanList = accountManagementBeanList;
	}

	public String getParentAccount() {
		return parentAccount;
	}

	public void setParentAccount(String parentAccount) {
		this.parentAccount = parentAccount;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getAccountCode() {
		return accountCode;
	}

	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAccountBalance() {
		return accountBalance;
	}

	public void setAccountBalance(String accountBalance) {
		this.accountBalance = accountBalance;
	}

	public String getAccountChange() {
		return accountChange;
	}

	public void setAccountChange(String accountChange) {
		this.accountChange = accountChange;
	}

	public String getAccountUse() {
		return accountUse;
	}

	public void setAccountUse(String accountUse) {
		this.accountUse = accountUse;
	}
}
