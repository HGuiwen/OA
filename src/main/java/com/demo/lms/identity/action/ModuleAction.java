package com.demo.lms.identity.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.demo.lms.identity.bean.Module;
import com.demo.lms.identity.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.util.webTag.PageModel;

@Controller
@RequestMapping("/identity/module")
public class ModuleAction {
	// 自动装配byType
	@Resource(name = "userService")
	private UserService userService;

	// 展示菜单管理
	@RequestMapping(value = "/mgrModule.jspx")
	public String mgrModule() {
		return "/identity/module/mgrModule";
	}

	// 通过ajax异步请求获取模块
	@RequestMapping(value = "/ajaxModule.jspx", produces = { "application/json;charset=utf-8" })
	@ResponseBody
	public String ajaxModule() {
		String data = userService.ajaxModule();
		return data;
	}

	// 根据父级code获取子模块页面
	@RequestMapping(value = "/getModulesByParent.jspx")
	public String getModulesByParent(String parentCode, Model model,
			PageModel pageModel) {
		try {

			List<Module> modules = userService.getModulesByParent(parentCode,
					pageModel);
			model.addAttribute("modules", modules);
			model.addAttribute("parentCode", parentCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/identity/module/module";
	}

	// 展示添加菜单页面
	@RequestMapping(value = "/showAddModule.jspx")
	public String showAddModule(String parentCode, Model model) {
		model.addAttribute("parentCode", parentCode);
		return "/identity/module/addModule";
	}

	// 添加模块
	@RequestMapping(value = "/addModule.jspx")
	public String addModule(String parentCode, Model model, Module module,
			HttpSession session) {
		try {
			model.addAttribute("parentCode", parentCode);
			userService.addModule(module, parentCode, session);
			model.addAttribute("msg", "添加成功!");
			return "/identity/module/addModule";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "添加失败!");
		}
		return null;
	}

	// 删除模块
	@RequestMapping(value = "/deleteModuleById.jspx")
	public String deleteModuleById(String parentCode,
			@RequestParam("id") String id, Model model) {
		try {
			userService.deleteModuleById(id);
			model.addAttribute("msg", "删除成功!");
			return "forward:/identity/module/getModulesByParent.jspx";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "删除失败!");
		}
		return null;
	}

	// 展示修改模块页面
	@RequestMapping(value = "/showUpdateModule.jspx")
	public String showUpdateModule(Module module, Model model) {
		try {
			module = userService.getModuleByCode(module.getCode());
			model.addAttribute("module", module);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "identity/module/updateModule";
	}

	// 修改模块
	@RequestMapping(value = "/updateModule.jspx")
	public String updateModule(Module module, Model model,HttpSession session) {
		try {
			userService.updateModule(module,session);
			model.addAttribute("msg", "修改成功!");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "修改失败!");
		}
		return "/identity/module/updateModule";
	}

}
