package com.minhyuk.base.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minhyuk.base.as.BaseApplicationService;
import com.minhyuk.base.to.AddressBean;
import com.minhyuk.base.to.CodeBean;
import com.minhyuk.base.to.DetailCodeBean;
import com.minhyuk.base.to.EmpPermissionBean;
import com.minhyuk.base.to.MenuBean;
import com.minhyuk.base.to.PermissionBean;
import com.minhyuk.base.to.SidoBean;
import com.minhyuk.base.to.SigunguBean;

@Service
public class BaseServiceFacadeImpl implements BaseServiceFacade {
	@Autowired
	BaseApplicationService baseApplicationService;

	@Override
	public List<MenuBean> getMenuList() {
		return baseApplicationService.getMenuList();
	}

	@Override
	public List<CodeBean> getCodeList() {
		return baseApplicationService.getCodeList();
	}

	@Override
	public List<PermissionBean> getPermission() {
		return baseApplicationService.getPermission();
	}

	@Override
	public List<EmpPermissionBean> getEmpPermission() {
		return baseApplicationService.getEmpPermission();
	}

	@Override
	public List<SidoBean> getSido() {
		return baseApplicationService.getSido();
	}

	@Override
	public List<SigunguBean> getSiGunGuList(String sido) {
		return baseApplicationService.getSiGunGuList(sido);
	}

	@Override
	public List<AddressBean> getAddrList(Map<String, Object> addrList) {
		return baseApplicationService.getAddrList(addrList);
	}

	@Override
	public void batchCodeList(List<DetailCodeBean> codeList) {
		baseApplicationService.batchCodeList(codeList);
	}

	@Override
	public List<PermissionBean> getPermissionList(String permissionCode) {
		return baseApplicationService.getPermissionList(permissionCode);
	}

	@Override
	public <T> void batchPermission(Map<String, Object> batchPerList) {
		baseApplicationService.batchPermission(batchPerList);
	}

}
