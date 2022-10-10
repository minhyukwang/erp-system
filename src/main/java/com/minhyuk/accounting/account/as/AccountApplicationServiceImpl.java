package com.minhyuk.accounting.account.as;

import java.util.List;

import com.minhyuk.accounting.account.dao.AccountDAO;
import com.minhyuk.accounting.account.dao.AccountManagementDAO;
import com.minhyuk.accounting.account.to.AccountBean;
import com.minhyuk.accounting.account.to.AccountManagementBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AccountApplicationServiceImpl implements AccountApplicationService {
	@Autowired
    AccountDAO accountDAO;
	@Autowired
    AccountManagementDAO accountManagementDAO;

	@Override
	public List<AccountBean> getAccountList() {
		return accountDAO.selectAccountList();
	}


	@Override
	public void batchAccountManagement(List<AccountManagementBean> accountManagementList) {
		for (AccountManagementBean accountManagementBean : accountManagementList) {
			if(accountManagementBean.getStatus().equals("inserted")){
				accountManagementDAO.insertAccountManagement(accountManagementBean);
//			}else if(accountManagementBean.getStatus().equals("updated")){
//				accountManagementDAO.updateAccountManagement(accountManagementBean);
			}else{
				accountManagementDAO.deleteAccountManagement(accountManagementBean);
			}
		}
	}

	@Override
	public void batchAccount(List<AccountBean> accountList) {
		for (AccountBean accountBean : accountList) {
			if(accountBean.getStatus().equals("inserted")){
				accountDAO.insertAccount(accountBean);
			}else if(accountBean.getStatus().equals("updated")){
				accountDAO.updateAccount(accountBean);
			}else{
				accountDAO.deleteAccount(accountBean);
			}
		}
	}


}
