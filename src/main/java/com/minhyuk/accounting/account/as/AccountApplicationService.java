package com.minhyuk.accounting.account.as;

import java.util.List;

import com.minhyuk.accounting.account.to.AccountBean;
import com.minhyuk.accounting.account.to.AccountManagementBean;

public interface AccountApplicationService {

	public List<AccountBean> getAccountList();
	public void batchAccountManagement(List<AccountManagementBean> accountManagementList);
	public void batchAccount(List<AccountBean> accountList);

}
