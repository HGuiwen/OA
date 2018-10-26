package com.demo.lms.identity.action;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.demo.lms.identity.bean.Module;
import com.demo.lms.identity.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainAction {
	// 自动装配byType
		@Resource(name = "userService")
		private UserService userService;
	
	@RequestMapping("/main.jspx")
	public String main(Model model,HttpSession session){
		//根据登录用户的用户id获取角色,再根据角色ID获取权限信息
		//key:一级模块
		//value:二级模块(操作)
		Map<Module,List<Module>> datas = userService.findUserAllOpeas(session);
		model.addAttribute("datas", datas);
		
		//根据登录用户的用户id获取角色,再根据角色ID获取权限信息
		List<String> urls= userService.findUserOpeas(session);
		session.setAttribute("urls", urls);
		
		return "main";
	}
}
