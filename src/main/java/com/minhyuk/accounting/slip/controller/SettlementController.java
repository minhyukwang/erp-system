package com.minhyuk.accounting.slip.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.minhyuk.common.mapper.DatasetBeanMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.xapi.data.PlatformData;

import com.minhyuk.accounting.slip.service.SlipServiceFacade;
import com.minhyuk.accounting.slip.to.CreditorBalanceBean;
import com.minhyuk.accounting.slip.to.DebtorBalanceBean;
import com.minhyuk.accounting.slip.to.FormerIncomeBean;
import com.minhyuk.accounting.slip.to.FormerStatementPositionBean;
import com.minhyuk.accounting.slip.to.IncomeStatementBean;
import com.minhyuk.accounting.slip.to.StatementPositionBean;
import com.minhyuk.accounting.slip.to.TotalIncomeBean;
import com.minhyuk.accounting.slip.to.TotalStatementBean;

@Controller
public class SettlementController{
	@Autowired
	private SlipServiceFacade slipServiceFacade;
	@Autowired
	private DatasetBeanMapper datasetBeanMapper;

	@RequestMapping("slip/getTotalTrialBalanceList.do")
	public void getTotalTrialBalanceList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");
		PlatformData outData = (PlatformData)request.getAttribute("outData");

		HashMap<String, Object> trialBalanceMap=new HashMap<>();
			String sDate = inData.getVariable("sDate").getString();
			String eDate = inData.getVariable("eDate").getString();
			trialBalanceMap.put("sDate", sDate);
			trialBalanceMap.put("eDate", eDate);

		List<DebtorBalanceBean> debtorList = slipServiceFacade.getDebtorList(trialBalanceMap);
		List<CreditorBalanceBean> creditorList = slipServiceFacade.getCreditorList(trialBalanceMap);

		datasetBeanMapper.beansToDataset(outData, debtorList, DebtorBalanceBean.class);
		datasetBeanMapper.beansToDataset(outData, creditorList, CreditorBalanceBean.class);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("slip/getIncomeStatementList.do")
	public void getIncomeStatementList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");
		PlatformData outData = (PlatformData)request.getAttribute("outData");

		HashMap<String, Object> incomeMap=new HashMap<>();
			String sDate = inData.getVariable("sDate").getString();
			String eDate = inData.getVariable("eDate").getString();
			incomeMap.put("sDate", sDate);
			incomeMap.put("eDate", eDate);
			String strYear = sDate.substring(0,4);
			String year = Integer.toString(Integer.parseInt(strYear)-1);

		slipServiceFacade.getIncomeList(incomeMap);
		List<IncomeStatementBean> incomeStatementList=(List<IncomeStatementBean>) incomeMap.get("result");
		List<FormerIncomeBean> formerIncomeList = slipServiceFacade.getFormerIncomeList(year);
		System.out.println(incomeStatementList);
		datasetBeanMapper.beansToDataset(outData, incomeStatementList, IncomeStatementBean.class);
		datasetBeanMapper.beansToDataset(outData, formerIncomeList, FormerIncomeBean.class);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("slip/getStatementPositionList.do")
	public void getStatementPositionList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");
		PlatformData outData = (PlatformData)request.getAttribute("outData");

		HashMap<String, Object> statementMap=new HashMap<>();
			String sDate = inData.getVariable("sDate").getString();
			String eDate = inData.getVariable("eDate").getString();
			statementMap.put("sDate", sDate);
			statementMap.put("eDate", eDate);
			String strYear = sDate.substring(0,4);
			String year = Integer.toString(Integer.parseInt(strYear)-1);

		slipServiceFacade.getStatementList(statementMap);
		List<StatementPositionBean> statementPositionList=(List<StatementPositionBean>) statementMap.get("result");
		List<FormerStatementPositionBean> formerStatementList = slipServiceFacade.getFormerStatementList(year);

		datasetBeanMapper.beansToDataset(outData, statementPositionList, StatementPositionBean.class);
		datasetBeanMapper.beansToDataset(outData, formerStatementList, FormerStatementPositionBean.class);
	}

	@RequestMapping("slip/batchIncomeStatementList.do")
	public void batchIncomeStatementList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");

		List<IncomeStatementBean> incomeStateBeanList = datasetBeanMapper.datasetToBeans(inData, IncomeStatementBean.class);
		List<TotalIncomeBean> totalIncomeBeanList = datasetBeanMapper.datasetToBeans(inData, TotalIncomeBean.class);

		Map<String, Object> batchIncomeMap = new HashMap<>();
		batchIncomeMap.put("incomeStateBeanList", incomeStateBeanList);
		batchIncomeMap.put("totalIncomeBeanList", totalIncomeBeanList);

		slipServiceFacade.batchIncomeList(batchIncomeMap);
	}

	@RequestMapping("slip/batchStatementPositionList.do")
	public void batchStatementPositionList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");

		List<StatementPositionBean> statementPositionBeanList = datasetBeanMapper.datasetToBeans(inData, StatementPositionBean.class);
		List<TotalStatementBean> totalStatementBeanList = datasetBeanMapper.datasetToBeans(inData, TotalStatementBean.class);

		Map<String, Object> batchStatementMap = new HashMap<>();
		batchStatementMap.put("statementPositionBeanList", statementPositionBeanList);
		batchStatementMap.put("totalStatementBeanList", totalStatementBeanList);

		slipServiceFacade.batchStatementPositionList(batchStatementMap);
	}

}