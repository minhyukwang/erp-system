package com.minhyuk.base.dao;

import java.util.List;

import com.minhyuk.base.to.MenuBean;

public interface MenuDAO {
	List<MenuBean> selectMenuList();
}
