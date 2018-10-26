package com.demo.lms.notice.dao.impl;

import java.util.List;
import java.util.Map;

import com.demo.lms.identity.dao.UserDao;
import com.demo.lms.notice.dao.NoticeTypeDao;

import common.dao.impl.BaseDaoImpl;

/**
 * @author CHUNLONG.LUO
 * @email 584614151@qq.com
 * @date 2017年10月26日
 * @version 1.0
 * 网站: <a href="http://www.crazyit.org">疯狂Java联盟</a>
 */

public class NoticeTypeDaoImpl extends BaseDaoImpl implements NoticeTypeDao{

	/* (non-Javadoc)
	 */
	@Override
	public List<Map<Long, String>> ajaxLoadNoticeType() {
		// TODO Auto-generated method stub
		
		String hql = "select new Map(t.id as id,t.typeName as name) from NoticeType t";
		return this.find(hql);
	}

}
