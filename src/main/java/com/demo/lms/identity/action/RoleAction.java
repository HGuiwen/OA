package com.demo.lms.identity.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.demo.lms.identity.bean.Role;
import com.demo.lms.identity.bean.User;
import com.demo.lms.identity.service.UserService;
import com.demo.lms.util.CookieUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.util.webTag.PageModel;

@Controller
@RequestMapping("/identity/role")
public class RoleAction {
	// 自动装配byType
	@Resource(name = "userService")
	private UserService userService;

	// 查询角色
	@RequestMapping(value = "/selectRole.jspx")
	public String selectRole(Role role, PageModel pageModel, Model model) {
		// 多条件查询
		List<Role> roles = userService.selectRoleByPage(role, pageModel);
		model.addAttribute("roles", roles);
		return "/identity/role/role";
	}

	// 展示添加角色页面
	@RequestMapping(value = "/showAddRole.jspx")
	public String showAddRole() {
		return "/identity/role/addRole";
	}

	// 添加角色
	@RequestMapping(value = "/addRole.jspx")
	public String addRole(Role role, Model model, HttpSession session) {
		try {
			userService.addRole(role, session);
			model.addAttribute("message", "添加成功！");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "添加失败！");
		}
		return "/identity/role/addRole";
	}

	// 删除角色
	@RequestMapping(value = "/deleteRole.jspx")
	public String deleteRole(@RequestParam("roleIds") String id, Model model) {

		try {
			userService.deleteRoleById(id);
			String msg = "删除成功";
			model.addAttribute("msg", msg);
		} catch (Exception e) {
			e.printStackTrace();
			String msg = "删除失败";
			model.addAttribute("msg", msg);
		}
		// request请求没有断开,所以用forward
		return "forward:/identity/role/selectRole.jspx";
	}

	
	// 展示修改角色页面
	@RequestMapping(value = "/showUpdateRole.jspx")
	public String showUpdateUser(@RequestParam("roleId") String roleId,
			Model model) {
		try {
			Role role = userService.getRoleById(roleId);
			model.addAttribute("role", role);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/identity/role/updateRole";
	}

	// 修改角色
	@RequestMapping(value = "/updateRole.jspx")
	public String updateRole(Role role, Model model, HttpSession session) {
		try {
			userService.updateRole(role, session);
			model.addAttribute("msg", "修改成功!");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "修改失败!");
		}

		return "/identity/role/updateRole";
	}

	// 根据角色ID展示用户信息
	@RequestMapping(value = "/selectRoleUser.jspx")
	public String selectRoleUser(Role role, Model model, PageModel pageModel) {
		try {
			List<User> users = userService.selectRoleUser(role, pageModel);
			model.addAttribute("users", users);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/identity/role/bindUser/roleUser";
	}

	// 展示仍未绑定用户页面
	@RequestMapping(value = "/showNotBindUser.jspx")
	public String showNotBindUser(Role role, Model model, PageModel pageModel) {
		try {
			List<User> users = userService.showNotBindUser(role, pageModel);
			model.addAttribute("users", users);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/identity/role/bindUser/bindUser";
	}
	
	//绑定指定角色给指定用户
	@RequestMapping(value = "/bindUser.jspx")
	public String bindUser(Role role,@RequestParam("userIds")String userIds, Model model, PageModel pageModel) {
		try {
			userService.bindUser(role, userIds,pageModel);
			model.addAttribute("msg","绑定成功");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg","绑定失败");
		}
		return "forward:/identity/role/showNotBindUser.jspx";
	}
	
	//解绑用户
	@RequestMapping(value = "/unbindUser.jspx")
	public String unbindUser(Role role,@RequestParam("userIds")String userIds, Model model, PageModel pageModel) {
		try {
			System.out.println("传过来:"+pageModel.getPageIndex());
			userService.unbindUser(role, userIds,pageModel);
			model.addAttribute("msg","解绑成功");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg","解绑失败");
		}
		return "forward:/identity/role/selectRoleUser.jspx";
	}
	
	
}
