package com.demo.lms.identity.dao.impl;

import java.util.List;

import com.demo.lms.identity.dao.PopedomDao;
import com.demo.lms.identity.dao.UserDao;

import common.dao.impl.BaseDaoImpl;

public class PopedomDaoImpl extends BaseDaoImpl implements PopedomDao {

	@Override
	public List<String> findAllOpea(String userId) {
		
		StringBuffer hql = new StringBuffer();
		//查询所有角色对应的权限
		hql.append("select distinct p.module.code from Popedom p where p.role.id in(");
		 hql.append("select r.id from Role r inner join r.users u where u.userId ='"+userId+"') order by p.module.code asc");
		 
		return this.find(hql.toString());
	}

}
