package com.demo.lms.identity.dao;

import java.util.List;

import common.dao.BaseDao;

public interface UserDao extends BaseDao{

	List<String> findUserOpea(String userId);

}
