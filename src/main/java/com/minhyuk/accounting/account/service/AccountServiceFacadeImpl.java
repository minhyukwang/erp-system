package com.minhyuk.accounting.account.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minhyuk.accounting.account.as.AccountApplicationService;
import com.minhyuk.accounting.account.to.AccountBean;
import com.minhyuk.accounting.account.to.AccountManagementBean;

@Service
public class AccountServiceFacadeImpl implements AccountServiceFacade {
	@Autowired
	AccountApplicationService accountApplicationService;

	@Override
	public List<AccountBean> getAccountList() {
		return accountApplicationService.getAccountList();
	}

	@Override
	public void batchAccountManagement(List<AccountManagementBean> accountManagementList) {
		accountApplicationService.batchAccountManagement(accountManagementList);
	}

	@Override
	public void batchAccount(List<AccountBean> accountList) {
		accountApplicationService.batchAccount(accountList);
	}

}
