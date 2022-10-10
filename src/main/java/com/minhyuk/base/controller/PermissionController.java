package com.minhyuk.base.controller;

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

import com.minhyuk.base.service.BaseServiceFacade;
import com.minhyuk.base.to.EmpPermissionBean;
import com.minhyuk.base.to.PermissionBean;

@Controller
public class PermissionController{
	@Autowired
	private BaseServiceFacade baseServiceFacade;
	@Autowired
	private DatasetBeanMapper datasetBeanMapper;

	@RequestMapping("base/getPermission.do")
	public void getPermission(HttpServletRequest request,HttpServletResponse response) throws Exception{

		PlatformData outData = (PlatformData)request.getAttribute("outData");

		List<PermissionBean> permissionList=baseServiceFacade.getPermission();
		datasetBeanMapper.beansToDataset(outData, permissionList, PermissionBean.class);

		//System.out.println("permissionList: "+outData.toString());

	}

	@RequestMapping("base/getEmpPermission.do")
	public void getEmpPermission(HttpServletRequest request,HttpServletResponse response) throws Exception{

		PlatformData outData = (PlatformData)request.getAttribute("outData");

		List<EmpPermissionBean> empPermission=baseServiceFacade.getEmpPermission();
		datasetBeanMapper.beansToDataset(outData, empPermission, EmpPermissionBean.class);
	}

	@RequestMapping("base/getPermissionList.do")
	public void getPermissionList(HttpServletRequest request,HttpServletResponse response) throws Exception{

		PlatformData inData = (PlatformData)request.getAttribute("inData");
		PlatformData outData = (PlatformData)request.getAttribute("outData");

		String permissionCode = inData.getVariable("permission").getString();
		List<PermissionBean> permissionList=baseServiceFacade.getPermissionList(permissionCode);
		datasetBeanMapper.beansToDataset(outData, permissionList, PermissionBean.class);

		//System.out.println("permissionList: "+outData.toString());

	}

	@RequestMapping("base/batchPermission.do")
	public void batchPermission(HttpServletRequest request,HttpServletResponse response) throws Exception{

		PlatformData inData = (PlatformData)request.getAttribute("inData");

		List<PermissionBean> permissionList=datasetBeanMapper.datasetToBeans(inData, PermissionBean.class);
		List<EmpPermissionBean> empPermissionList=datasetBeanMapper.datasetToBeans(inData, EmpPermissionBean.class);

		System.out.println(" ----------------------- "+inData.toString());

		Map<String, Object> batchPerList = new HashMap<>();
		batchPerList.put("permissionList", permissionList);
		batchPerList.put("empPermissionList", empPermissionList);

		baseServiceFacade.batchPermission(batchPerList);
	}

}
