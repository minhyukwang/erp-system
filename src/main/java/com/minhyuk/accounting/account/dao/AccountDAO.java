package com.minhyuk.accounting.account.dao;

import java.util.List;

import com.minhyuk.accounting.account.to.AccountBean;

public interface AccountDAO {
	public List<AccountBean> selectAccountList();
	public void insertAccount(AccountBean accountBean);
	public void updateAccount(AccountBean accountBean);
	public void deleteAccount(AccountBean accountBean);

}
