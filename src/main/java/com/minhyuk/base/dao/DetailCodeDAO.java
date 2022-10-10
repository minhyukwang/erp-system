package com.minhyuk.base.dao;

import java.util.List;

import com.minhyuk.base.to.DetailCodeBean;

public interface DetailCodeDAO {

	public List<DetailCodeBean> selectDetailCodeList();

	public void insertDetailCode(DetailCodeBean detailCodeBean);
	public void updateDetailCode(DetailCodeBean detailCodeBean);
	public void deleteDetailCode(DetailCodeBean detailCodeBean);

}
