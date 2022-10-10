package com.minhyuk.insa.emp.controller;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.minhyuk.insa.emp.service.EmpServiceFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.xapi.data.DataSet;
import com.nexacro.xapi.data.PlatformData;

import com.minhyuk.common.mapper.DatasetBeanMapper;
import com.minhyuk.insa.emp.to.EmpBean;

@Controller
public class EmpController{
	@Autowired
	private EmpServiceFacade empServiceFacade;
	@Autowired
	private DatasetBeanMapper datasetBeanMapper;

	@RequestMapping("emp/getEmpList.do")
	public void getEmpList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData outData = (PlatformData)request.getAttribute("outData");

		List<EmpBean> empList = empServiceFacade.getEmpList();
		datasetBeanMapper.beansToDataset(outData, empList, EmpBean.class);
	}

	@RequestMapping("emp/saveEmpImg.do")
	public void saveEmpImg(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");

		DataSet dataset = inData.getDataSet("dsImg");
		FileOutputStream out = null;
		String fileName = dataset.getString(0, "emp_filename");

		try {
			if (fileName != null) {
				out = new FileOutputStream("C:\\dev\\Apache2.2\\htdocs\\project5th\\image\\" + fileName);

				byte[] file = dataset.getBlob(0, "img_file_data");

				BufferedOutputStream bufferedOut = new BufferedOutputStream(out);

				bufferedOut.write(file);// ������̱ⰳ�� ���ϻ�����
				bufferedOut.flush();// �ڿ�����
				bufferedOut.close(); // �ݱ�
				out.close();// �̰͵� �ڿ�����
				bufferedOut = null; // �ڿ�����
				out = null; // �ڿ�����
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	@RequestMapping("emp/batchEmpList.do")
	public void batchEmpList(HttpServletRequest request,HttpServletResponse response) throws Exception {

		PlatformData inData = (PlatformData)request.getAttribute("inData");

		List<EmpBean> empList = datasetBeanMapper.datasetToBeans(inData, EmpBean.class);
		empServiceFacade.batchEmp(empList);
	}


}