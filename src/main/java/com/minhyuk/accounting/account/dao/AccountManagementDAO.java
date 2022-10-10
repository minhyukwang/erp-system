package com.minhyuk.accounting.account.dao;

import java.util.List;

import com.minhyuk.accounting.account.to.AccountManagementBean;

public interface AccountManagementDAO {
	public List<AccountManagementBean> selectAccountManagementList();
	void insertAccountManagement(AccountManagementBean accountManagementBean);
	//void updateAccountManagement(AccountManagementBean accountManagementBean);
	void deleteAccountManagement(AccountManagementBean accountManagementBean);

}
