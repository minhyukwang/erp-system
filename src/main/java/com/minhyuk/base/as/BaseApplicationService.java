package com.minhyuk.base.as;

import java.util.List;
import java.util.Map;

import com.minhyuk.base.to.AddressBean;
import com.minhyuk.base.to.CodeBean;
import com.minhyuk.base.to.DetailCodeBean;
import com.minhyuk.base.to.EmpPermissionBean;
import com.minhyuk.base.to.MenuBean;
import com.minhyuk.base.to.PermissionBean;
import com.minhyuk.base.to.SidoBean;
import com.minhyuk.base.to.SigunguBean;

public interface BaseApplicationService {

	public List<MenuBean> getMenuList();

	public List<CodeBean> getCodeList();

	public List<PermissionBean> getPermission();
	public List<EmpPermissionBean> getEmpPermission();

	public List<SidoBean> getSido();
	public List<SigunguBean> getSiGunGuList(String sido);
	public List<AddressBean> getAddrList(Map<String, Object> addrList);

	public void batchCodeList(List<DetailCodeBean> codeList);

	public List<PermissionBean> getPermissionList(String permissionCode);
	public void batchPermission(Map<String, Object> batchPerList);

}
