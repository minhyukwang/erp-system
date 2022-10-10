package com.minhyuk.base.as;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.minhyuk.base.dao.CodeDAO;
import com.minhyuk.base.dao.DetailCodeDAO;
import com.minhyuk.base.dao.MenuDAO;
import com.minhyuk.base.dao.PermissionDAO;
import com.minhyuk.base.dao.PostDAO;
import com.minhyuk.base.to.AddressBean;
import com.minhyuk.base.to.CodeBean;
import com.minhyuk.base.to.DetailCodeBean;
import com.minhyuk.base.to.EmpPermissionBean;
import com.minhyuk.base.to.MenuBean;
import com.minhyuk.base.to.PermissionBean;
import com.minhyuk.base.to.SidoBean;
import com.minhyuk.base.to.SigunguBean;

@Component
public class BaseApplicationServiceImpl implements BaseApplicationService {
	@Autowired
    MenuDAO menuDAO;
	@Autowired
    CodeDAO codeDAO;
	@Autowired
    DetailCodeDAO detailCodeDAO;
	@Autowired
    PermissionDAO permissionDAO;
	@Autowired
    PostDAO postDAO;


	@Override
	public List<MenuBean> getMenuList() {
		return menuDAO.selectMenuList();
	}

	@Override
	public List<CodeBean> getCodeList() {
		return codeDAO.selectCodeList();
	}

	@Override
	public List<PermissionBean> getPermission() {
		return permissionDAO.selectPermission();
	}

	@Override
	public List<EmpPermissionBean> getEmpPermission() {
		return permissionDAO.selectEmpPermission();
	}

	@Override
	public List<SidoBean> getSido() {
		return postDAO.selectSido();
	}

	@Override
	public List<SigunguBean> getSiGunGuList(String sido) {
		return postDAO.selectSiGunGuList(sido);
	}

	@Override
	public List<AddressBean> getAddrList(Map<String, Object> addrList) {
		return postDAO.selectAddrList(addrList);
	}

	@Override
	public void batchCodeList(List<DetailCodeBean> codeList) {
		for (DetailCodeBean detailCodeBean : codeList) {
			if(detailCodeBean.getStatus().equals("inserted")){
				detailCodeDAO.insertDetailCode(detailCodeBean);
			}else if(detailCodeBean.getStatus().equals("updated")){
				detailCodeDAO.updateDetailCode(detailCodeBean);
			}else{
				detailCodeDAO.deleteDetailCode(detailCodeBean);
			}
		}
	}

	@Override
	public List<PermissionBean> getPermissionList(String permissionCode) {
		return permissionDAO.selectPermissionList(permissionCode);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void batchPermission(Map<String, Object> batchPerList) {
		List<PermissionBean> permissionList = (List<PermissionBean>) batchPerList.get("permissionList");
		List<EmpPermissionBean> empPermissionList = (List<EmpPermissionBean>) batchPerList.get("empPermissionList");
		for(PermissionBean permissionBean:permissionList){
			if(permissionBean.getStatus().equals("inserted")){
				permissionDAO.insertPermission(permissionBean);
			}else{
				permissionDAO.deletePermission(permissionBean);
			}
		}
		for(EmpPermissionBean empPerBean:empPermissionList){
			if(empPerBean.getStatus().equals("inserted")){
				permissionDAO.insertEmpPermission(empPerBean);
			}else{
				permissionDAO.deleteEmpPermission(empPerBean);
			}
		}
	}

}
