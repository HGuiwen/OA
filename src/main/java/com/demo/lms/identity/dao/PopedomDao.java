package com.demo.lms.identity.dao;

import java.util.List;

import common.dao.BaseDao;

public interface PopedomDao extends BaseDao{

	List<String> findAllOpea(String userId);

}
