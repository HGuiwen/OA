package com.demo.lms.notice.dao;



import java.util.List;
import java.util.Map;

import common.dao.BaseDao;

/**
 * @author CHUNLONG.LUO
 * @email 584614151@qq.com
 * @date 2017年10月26日
 * @version 1.0
 * 网站: <a href="http://www.crazyit.org">疯狂Java联盟</a>
 */
public interface NoticeTypeDao extends BaseDao{

	List<Map<Long, String>> ajaxLoadNoticeType();

}
