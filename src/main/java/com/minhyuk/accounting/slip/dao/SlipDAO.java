package com.minhyuk.accounting.slip.dao;

import java.util.HashMap;
import java.util.List;

import com.minhyuk.accounting.slip.to.SlipBean;

public interface SlipDAO {

	public List<SlipBean> selectSlipList(HashMap<String, Object> slipmap);

	public void insertSlip(SlipBean slipBean);
	public void updateSlip(SlipBean slipBean);
	public void deleteSlip(SlipBean slipBean);

}
