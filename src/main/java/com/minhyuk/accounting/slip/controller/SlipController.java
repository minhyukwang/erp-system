package com.minhyuk.accounting.slip.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.minhyuk.accounting.slip.to.JournalBean;
import com.minhyuk.accounting.slip.to.JournalListBean;
import com.minhyuk.accounting.slip.to.JournalManagementBean;
import com.minhyuk.accounting.slip.to.SlipBean;
import com.minhyuk.common.mapper.DatasetBeanMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.xapi.data.PlatformData;

import com.minhyuk.accounting.slip.service.SlipServiceFacade;

@Controller
public class SlipController{
	@Autowired
	private SlipServiceFacade slipServiceFacade;
	@Autowired
	private DatasetBeanMapper datasetBeanMapper;


	@RequestMapping("slip/getSlipList.do")
	public void getSlipList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");
		PlatformData outData = (PlatformData)request.getAttribute("outData");

		HashMap<String, Object> slipmap=new HashMap<>();
			String deptName = inData.getVariable("deptName").getString();
			String sDate = inData.getVariable("sDate").getString();
			String eDate = inData.getVariable("eDate").getString();
			slipmap.put("deptName", deptName);
			slipmap.put("sDate", sDate);
			slipmap.put("eDate", eDate);

		List<SlipBean> slipList = slipServiceFacade.getSlipList(slipmap);
		List<JournalBean> journalBeanList = new ArrayList<>();
		List<JournalManagementBean> journalManagementBeanList = new ArrayList<>();

		for (SlipBean slipBean : slipList) {
			List<JournalBean> journal = slipBean.getJournalBeanList();
			for (JournalBean journalBean : journal) {
				List<JournalManagementBean> journalManagement = journalBean.getJournalManagementBeanList();
				journalManagementBeanList.addAll(journalManagement);
			}
			journalBeanList.addAll(journal);
		}

		datasetBeanMapper.beansToDataset(outData, slipList, SlipBean.class);
		datasetBeanMapper.beansToDataset(outData, journalBeanList, JournalBean.class);
		datasetBeanMapper.beansToDataset(outData, journalManagementBeanList, JournalManagementBean.class);
	}

	@RequestMapping("slip/getSlipApproveList.do")
	public void getSlipApproveList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");
		PlatformData outData = (PlatformData)request.getAttribute("outData");

		HashMap<String, Object> slipmap=new HashMap<>();
			String sDate = inData.getVariable("sDate").getString();
			String eDate = inData.getVariable("eDate").getString();
			String slipStatus = inData.getVariable("slipStatus").getString();
			String slipType = inData.getVariable("slipType").getString();
			String deptName = inData.getVariable("deptName").getString();
			slipmap.put("sDate", sDate);
			slipmap.put("eDate", eDate);
			slipmap.put("slipStatus", slipStatus);
			slipmap.put("slipType", slipType);
			slipmap.put("deptName", deptName);

		List<SlipBean> slipList = slipServiceFacade.getSlipList(slipmap);
		List<JournalBean> journalBeanList = new ArrayList<>();
		List<JournalManagementBean> journalManagementBeanList = new ArrayList<>();

		for (SlipBean slipBean : slipList) {
			List<JournalBean> journal = slipBean.getJournalBeanList();
			for (JournalBean journalBean : journal) {
				List<JournalManagementBean> journalManagement = journalBean.getJournalManagementBeanList();
				journalManagementBeanList.addAll(journalManagement);
			}
			journalBeanList.addAll(journal);
		}

		datasetBeanMapper.beansToDataset(outData, slipList, SlipBean.class);
		datasetBeanMapper.beansToDataset(outData, journalBeanList, JournalBean.class);
		datasetBeanMapper.beansToDataset(outData, journalManagementBeanList, JournalManagementBean.class);
	}

	@RequestMapping("slip/batchSlipList.do")
	public void batchSlipList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");

		List<SlipBean> slipList = datasetBeanMapper.datasetToBeans(inData, SlipBean.class);
		List<JournalBean> journalList = datasetBeanMapper.datasetToBeans(inData, JournalBean.class);
		List<JournalManagementBean> journalmanagementList = datasetBeanMapper.datasetToBeans(inData,
				JournalManagementBean.class);

		System.out.println(inData.toString());

		Map<String, Object> batchSlipList = new HashMap<>();
		batchSlipList.put("slipList", slipList);
		batchSlipList.put("journalList", journalList);
		batchSlipList.put("journalmanagementList", journalmanagementList);

		slipServiceFacade.batchSlipList(batchSlipList);
	}

	@RequestMapping("slip/getJournalList.do")
	public void getJournalList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");
		PlatformData outData = (PlatformData)request.getAttribute("outData");

		HashMap<String, Object> journalListmap=new HashMap<>();
			String sDate = inData.getVariable("sDate").getString();
			String eDate = inData.getVariable("eDate").getString();
			String slipType = inData.getVariable("slipType").getString();
			String deptName = inData.getVariable("deptName").getString();
			journalListmap.put("sDate", sDate);
			journalListmap.put("eDate", eDate);
			journalListmap.put("slipType", slipType);
			journalListmap.put("deptName", deptName);

			List<JournalListBean> journalListBean = slipServiceFacade.getJournalList(journalListmap);


		datasetBeanMapper.beansToDataset(outData, journalListBean, JournalListBean.class);
	}

}