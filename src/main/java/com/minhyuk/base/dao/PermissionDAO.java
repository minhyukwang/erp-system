package com.minhyuk.base.dao;

import java.util.List;

import com.minhyuk.base.to.EmpPermissionBean;
import com.minhyuk.base.to.PermissionBean;

public interface PermissionDAO {

	public List<PermissionBean> selectPermission();
	public List<EmpPermissionBean> selectEmpPermission();

	public List<PermissionBean> selectPermissionList(String permissionCode);

	public void insertPermission(PermissionBean permissionBean);
	public void deletePermission(PermissionBean permissionBean);

	public void insertEmpPermission(EmpPermissionBean empPermissionBean);
	public void deleteEmpPermission(EmpPermissionBean empPermissionBean);


}
