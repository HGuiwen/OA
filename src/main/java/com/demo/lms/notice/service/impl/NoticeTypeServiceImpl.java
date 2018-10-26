package com.demo.lms.notice.service.impl;

import javax.annotation.Resource;

import com.demo.lms.notice.dao.NoticeTypeDao;
import com.demo.lms.notice.service.NoticeTypeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service(value="noticeTypeService")
@Transactional(rollbackFor=Exception.class)
public class NoticeTypeServiceImpl implements NoticeTypeService{
	
	@Resource(name="noticeTypeDao")
	private NoticeTypeDao noticeTypeDao;
	
}
