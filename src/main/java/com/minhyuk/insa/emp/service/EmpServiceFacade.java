package com.minhyuk.insa.emp.service;

import java.util.List;

import com.minhyuk.insa.emp.to.EmpBean;

public interface EmpServiceFacade {

	public List<EmpBean> getEmpList();
	public void batchEmp(List<EmpBean> empList);


}
