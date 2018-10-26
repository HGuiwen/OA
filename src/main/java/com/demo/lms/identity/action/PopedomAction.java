package com.demo.lms.identity.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.demo.lms.identity.bean.Module;
import com.demo.lms.identity.bean.Role;
import com.demo.lms.identity.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.util.webTag.PageModel;

@Controller
@RequestMapping("/identity/popedom")
public class PopedomAction {
	// 自动装配byType
	@Resource(name = "userService")
	private UserService userService;

	// 角色绑定操作主页面
	@RequestMapping(value = "/mgrPopedom.jspx")
	public String mgrPopedom(Role role) {

		return "/identity/role/bindPopedom/mgrPopedom";
	}

	// 获取权限信息
	@RequestMapping(value = "/getModulesByParent.jspx")
	public String getModulesByParent(String parentCode, String roleId,
			Model model) {
		try {
			model.addAttribute("parentCode", parentCode);
			// 根据父级ID查询子模块信息
			List<Module> modules = userService.getModulesByParent(parentCode);
			model.addAttribute("modules", modules);

			// 根据角色ID查询角色信息
			Role role = userService.getRoleById(roleId);
			model.addAttribute("role", role);

			// 根据父级ID查询自己信息
			Module module = userService.getModuleByCode(parentCode);
			model.addAttribute("module", module);

			// 根据父级ID和角色ID查询子模块(操作)的code
			List<String> oCode = userService.getPopedomByParentAndRole(
					parentCode, roleId);
			model.addAttribute("oCode", oCode);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "/identity/role/bindPopedom/operas";
	}

	// 绑定权限
	@RequestMapping(value = "/bindPopedom.jspx")
	public String bindPopedom(String parentCode, String roleId, String codes, HttpSession session, Model model) {
		
		try {
			System.out.println(parentCode+"--"+roleId+"--"+codes);
			userService.bindPopedom(parentCode,roleId,codes,session);
			model.addAttribute("msg", "绑定成功!");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "绑定失败!");
		}
		
		return "forward:/identity/popedom/getModulesByParent.jspx";
	}

}
