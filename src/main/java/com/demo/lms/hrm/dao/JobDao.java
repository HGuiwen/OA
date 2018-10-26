package com.demo.lms.hrm.dao;

import java.util.List;
import java.util.Map;

import common.dao.BaseDao;

public interface JobDao extends BaseDao{
	//查询所有职位
	List<Map<Long, String>> getAllJob();

}
