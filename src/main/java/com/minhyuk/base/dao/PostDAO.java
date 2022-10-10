package com.minhyuk.base.dao;

import java.util.List;
import java.util.Map;

import com.minhyuk.base.to.AddressBean;
import com.minhyuk.base.to.SidoBean;
import com.minhyuk.base.to.SigunguBean;

public interface PostDAO {

	public List<SidoBean> selectSido();
	public List<SigunguBean> selectSiGunGuList(String sido);
	public List<AddressBean> selectAddrList(Map<String, Object> addrList);

}
