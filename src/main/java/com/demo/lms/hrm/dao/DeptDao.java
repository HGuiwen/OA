package com.demo.lms.hrm.dao;

import java.util.List;
import java.util.Map;

import common.dao.BaseDao;

public interface DeptDao extends BaseDao{
	//查询所有的部门
	List<Map<Long, String>> getAllDept();

}
