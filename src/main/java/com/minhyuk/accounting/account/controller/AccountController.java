package com.minhyuk.accounting.account.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.minhyuk.common.mapper.DatasetBeanMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.xapi.data.PlatformData;

import com.minhyuk.accounting.account.service.AccountServiceFacade;
import com.minhyuk.accounting.account.to.AccountBean;
import com.minhyuk.accounting.account.to.AccountManagementBean;

@Controller
public class AccountController{
	@Autowired
	private AccountServiceFacade accountServiceFacade;
	@Autowired
	private DatasetBeanMapper datasetBeanMapper;


	@RequestMapping("account/getAccountList.do")
	public void getAccountList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData outData = (PlatformData)request.getAttribute("outData");

		List<AccountBean> accountList=accountServiceFacade.getAccountList();
		List<AccountManagementBean> accountManagementList=new ArrayList<AccountManagementBean>();

		for(AccountBean accountBean : accountList){
			List<AccountManagementBean> accountManagementBeanList=accountBean.getAccountManagementBeanList();
			accountManagementList.addAll(accountManagementBeanList);
		}

		datasetBeanMapper.beansToDataset(outData, accountList, AccountBean.class);
		datasetBeanMapper.beansToDataset(outData, accountManagementList, AccountManagementBean.class);

	}

	@RequestMapping("account/batchAccount.do")
	public void batchAccount(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");

		List<AccountBean> accountList=datasetBeanMapper.datasetToBeans(inData, AccountBean.class);
		accountServiceFacade.batchAccount(accountList);
	}


}