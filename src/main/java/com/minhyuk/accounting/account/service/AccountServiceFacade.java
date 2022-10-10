package com.minhyuk.accounting.account.service;

import java.util.List;

import com.minhyuk.accounting.account.to.AccountBean;
import com.minhyuk.accounting.account.to.AccountManagementBean;

public interface AccountServiceFacade {

	public List<AccountBean> getAccountList();
	public void batchAccountManagement(List<AccountManagementBean> accountManagementList);
	public void batchAccount(List<AccountBean> accountList);

}
