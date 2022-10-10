package com.minhyuk.insa.emp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minhyuk.insa.emp.as.EmpApplicationService;
import com.minhyuk.insa.emp.to.EmpBean;

@Service
public class EmpServiceFacadeImpl implements EmpServiceFacade {
	@Autowired
	EmpApplicationService empApplicationService;

	@Override
	public List<EmpBean> getEmpList() {
		return empApplicationService.getEmpList();
	}

	@Override
	public void batchEmp(List<EmpBean> empList) {
		empApplicationService.batchEmp(empList);
	}


}
