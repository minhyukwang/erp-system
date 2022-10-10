package com.minhyuk.insa.emp.dao;

import java.util.List;

import com.minhyuk.insa.emp.to.EmpBean;

public interface EmpDAO {
	public List<EmpBean> selectEmpList();
	public void insertEmp(EmpBean empbean);
	public void updateEmp(EmpBean empbean);
	public void deleteEmp(EmpBean empbean);
}
