package com.minhyuk.base.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.minhyuk.base.service.BaseServiceFacade;
import com.minhyuk.common.mapper.DatasetBeanMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.xapi.data.PlatformData;

import com.minhyuk.base.to.AddressBean;
import com.minhyuk.base.to.SidoBean;
import com.minhyuk.base.to.SigunguBean;

@Controller
public class PostController{
	@Autowired
	private BaseServiceFacade baseServiceFacade;
	@Autowired
	private DatasetBeanMapper datasetBeanMapper;

	@RequestMapping("base/getSido.do")
	public void getSido(HttpServletRequest request,HttpServletResponse response) throws Exception{

		PlatformData outData = (PlatformData)request.getAttribute("outData");

		List<SidoBean> sidoList=baseServiceFacade.getSido();
		datasetBeanMapper.beansToDataset(outData, sidoList, SidoBean.class);
	}

	@RequestMapping("base/getSiGunGuList.do")
	public void getSiGunGuList(HttpServletRequest request,HttpServletResponse response) throws Exception{

		PlatformData inData = (PlatformData)request.getAttribute("inData");
		PlatformData outData = (PlatformData)request.getAttribute("outData");

		String sido = inData.getVariable("sido").getString();
		List<SigunguBean> sigunguList=baseServiceFacade.getSiGunGuList(sido);
		datasetBeanMapper.beansToDataset(outData, sigunguList, SigunguBean.class);
	}

	@RequestMapping("base/getAddrList.do")
	public void getAddrList(HttpServletRequest request,HttpServletResponse response) throws Exception{

		PlatformData inData = (PlatformData)request.getAttribute("inData");
		PlatformData outData = (PlatformData)request.getAttribute("outData");

		String sido = inData.getVariable("sido").getString();
		String sigungu = inData.getVariable("sigungu").getString();
		String roadName = inData.getVariable("roadName").getString();

		Map<String, Object> addrList=new HashMap<>();
		addrList.put("sido", sido);
		addrList.put("sigungu", sigungu);
		addrList.put("roadName", roadName);

		List<AddressBean> addressList=baseServiceFacade.getAddrList(addrList);
		datasetBeanMapper.beansToDataset(outData, addressList, AddressBean.class);
	}

}
