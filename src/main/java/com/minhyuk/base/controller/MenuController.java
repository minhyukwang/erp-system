package com.minhyuk.base.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.minhyuk.base.service.BaseServiceFacade;
import com.minhyuk.common.mapper.DatasetBeanMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.xapi.data.PlatformData;

import com.minhyuk.base.to.MenuBean;

@Controller
public class MenuController{
	@Autowired
	private BaseServiceFacade baseServiceFacade;
	@Autowired
	private DatasetBeanMapper datasetBeanMapper;

	@RequestMapping("base/getMenuList.do")
	public void getMenuList(HttpServletRequest request, HttpServletResponse response) throws Exception{

		PlatformData outData = (PlatformData) request.getAttribute("outData");

		List<MenuBean> menuList=baseServiceFacade.getMenuList();
		datasetBeanMapper.beansToDataset(outData, menuList, MenuBean.class);
	}
}