package com.minhyuk.base.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.minhyuk.common.mapper.DatasetBeanMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.xapi.data.PlatformData;

import com.minhyuk.base.service.BaseServiceFacade;
import com.minhyuk.base.to.CodeBean;
import com.minhyuk.base.to.DetailCodeBean;

@Controller
public class CodeController{
	@Autowired
	private BaseServiceFacade baseServiceFacade;
	@Autowired
	private DatasetBeanMapper datasetBeanMapper;

	@RequestMapping("base/getCodeList.do")
	public void getCodeList(HttpServletRequest request, HttpServletResponse response) throws Exception{

		PlatformData outData = (PlatformData) request.getAttribute("outData");

		List<CodeBean> codeList=baseServiceFacade.getCodeList();
		List<DetailCodeBean> detailCodeList=new ArrayList<>();
		for(CodeBean codeBean : codeList){
			List<DetailCodeBean> detailCodeBeanList=codeBean.getDetailCodeBeanList();
			detailCodeList.addAll(detailCodeBeanList);
		}
		datasetBeanMapper.beansToDataset(outData, codeList, CodeBean.class);
		datasetBeanMapper.beansToDataset(outData, detailCodeList, DetailCodeBean.class);
	}

	@RequestMapping("base/batchCodeList.do")
	public void batchCodeList(HttpServletRequest request, HttpServletResponse response) throws Exception{

		PlatformData inData = (PlatformData) request.getAttribute("inData");

		List<DetailCodeBean> codeList = datasetBeanMapper.datasetToBeans(inData, DetailCodeBean.class);
		baseServiceFacade.batchCodeList(codeList);
	}


}