package com.demo.lms.identity.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.demo.lms.identity.bean.Module;

import common.dao.BaseDao;
import common.util.webTag.PageModel;

public interface ModuleDao extends BaseDao{
	
	List<Module> getModulesByParent(String parentCode, PageModel pageModel);

	void addModule(Module module, String parentCode, HttpSession session);
	
	
}
