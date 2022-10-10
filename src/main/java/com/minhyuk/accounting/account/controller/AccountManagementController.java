package com.minhyuk.accounting.account.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.minhyuk.common.mapper.DatasetBeanMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.xapi.data.PlatformData;

import com.minhyuk.accounting.account.service.AccountServiceFacade;
import com.minhyuk.accounting.account.to.AccountManagementBean;

@Controller
public class AccountManagementController{
	@Autowired
	private AccountServiceFacade accountServiceFacade;
	@Autowired
	private DatasetBeanMapper datasetBeanMapper;

	@RequestMapping("accountManagement/batchAccountManagement.do")
	public void batchAccountManagement(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");

		List<AccountManagementBean> accountManagementList=datasetBeanMapper.datasetToBeans(inData, AccountManagementBean.class);
		accountServiceFacade.batchAccountManagement(accountManagementList);
	}

}