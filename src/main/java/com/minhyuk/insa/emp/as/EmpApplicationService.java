package com.minhyuk.insa.emp.as;

import java.util.List;

import com.minhyuk.insa.emp.to.EmpBean;

public interface EmpApplicationService {

	List<EmpBean> getEmpList();
	public void batchEmp(List<EmpBean> empList);

}
