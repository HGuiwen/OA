package com.demo.lms.notice.action;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.demo.lms.notice.service.NoticeTypeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.util.webTag.PageModel;

@Controller
@RequestMapping("/notice/noticeType")
public class NoticeAction {
	// 自动装配byType
		@Resource(name = "noticeTypeService")
		private NoticeTypeService noticeTypeService;
	
	@RequestMapping("/selectNoticeType.jspx")
	public String main(PageModel pageModel){
		
		return "/notice/noticeType/list";
	}
	
	
	@RequestMapping("/showAddNoticeType.jspx")
	public String showAddNoticeType(PageModel pageModel){
		
		return "/notice/noticeType/add_noticeType";
	}
}