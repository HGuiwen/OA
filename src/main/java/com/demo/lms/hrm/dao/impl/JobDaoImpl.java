package com.demo.lms.hrm.dao.impl;

import java.util.List;
import java.util.Map;

import com.demo.lms.hrm.dao.JobDao;

import common.dao.impl.BaseDaoImpl;

public class JobDaoImpl extends BaseDaoImpl implements JobDao{

	@Override
	public List<Map<Long, String>> getAllJob() {
		String hql = "select new Map(j.code as code,j.name as name) from Job j order by code desc";
		
		return this.find(hql);
	}

}
