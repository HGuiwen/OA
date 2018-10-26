package com.demo.lms.hrm.dao.impl;

import java.util.List;
import java.util.Map;

import com.demo.lms.hrm.dao.DeptDao;

import common.dao.impl.BaseDaoImpl;

public class DeptDaoImpl extends BaseDaoImpl implements DeptDao{

	@Override
	public List<Map<Long, String>> getAllDept() {
		
		String hql = "select new Map(d.id as id,d.name as name) from Dept d order by id desc";
		
		return this.find(hql);
	}

}
