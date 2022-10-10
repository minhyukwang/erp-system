package com.minhyuk.insa.emp.as;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.minhyuk.insa.emp.dao.EmpDAO;
import com.minhyuk.insa.emp.to.EmpBean;

@Component
public class EmpApplicationServiceImpl implements EmpApplicationService {
	@Autowired
	EmpDAO empDAO;

	@Override
	public List<EmpBean> getEmpList() {
		return empDAO.selectEmpList();
	}

	@Override
	public void batchEmp(List<EmpBean> empList) {
		for (EmpBean empBean : empList) {
			if(empBean.getStatus().equals("inserted")){
				empDAO.insertEmp(empBean);
			}else if(empBean.getStatus().equals("updated")){
				empDAO.updateEmp(empBean);
			}else{
				empDAO.deleteEmp(empBean);
			}
		}
	}


}
