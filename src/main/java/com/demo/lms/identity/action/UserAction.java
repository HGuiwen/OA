package com.demo.lms.identity.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
@RequestMapping("/identity/user")
public class UserAction {
	// 自动装配byType
	@Resource(name = "userService")
	private UserService userService;

	// 登录
	@RequestMapping(value = "/login.jspx", produces = { "application/text;charset=utf-8" })
	@ResponseBody
	public String login(User user, String code, Boolean check,
			HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {

		// 验证码通过Session里的验证码比较
		String session_code = (String) session.getAttribute("VCODE");
		String msg = userService.userLogin(session_code, user, code, check,
				request, response);

		return msg;
	}

	// 退出
	@RequestMapping(value = "/logout.jspx")
	public String logout(HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		// 让session失效
		session.invalidate();
		// 清除cookie
		CookieUtil.removeCookie("COOKIE_USER", request, response);
		// /WEB-INF/jsp/ login .jsp
		return "login";
	}

	// 用户管理
	@RequestMapping(value = "/selectUser.jspx")
	public String selectUser(User user, PageModel pageModel, Model model) {
		// 多条件查询
		List<User> users = userService.selectUserByPage(user, pageModel);
		model.addAttribute("users", users);
		return "/identity/user/user";
	}

	// 通过ajax获取部门与职业的json数据
	@RequestMapping(value = "/ajaxPost.jspx", produces = { "application/json;charset=utf-8" })
	@ResponseBody
	public String ajaxPost() {
		String data = userService.ajaxLoadDeptAndJob();
		return data;
	}

	@RequestMapping(value = "/showAddUser.jspx")
	public String showAddUser() {
		return "/identity/user/addUser";
	}

	@RequestMapping(value = "/deleteUserById.jspx")
	public String deleteUserById(@RequestParam("id") String id, Model model) {

		try {
			userService.deleteUserById(id);
			String msg = "删除成功";
			model.addAttribute("msg", msg);
		} catch (Exception e) {
			e.printStackTrace();
			String msg = "删除失败";
			model.addAttribute("msg", msg);
		}
		// request请求没有断开,所以用forward
		return "forward:/identity/user/selectUser.jspx";
	}

	// 验证用户名是否已存在
	@RequestMapping(value = "/validUserId.jspx", produces = { "application/text;charset=utf-8" })
	@ResponseBody
	public String validUserId(String userId, HttpServletResponse response) {
		try {

			User user = userService.getUserById(userId);

			return user == null ? "" : "用户名已存在";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 添加用户
	@RequestMapping(value = "/addUser.jspx")
	public String addUser(User user, Model model, HttpSession session) {
		try {
			userService.addUser(user, session);
			model.addAttribute("message", "添加成功！");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "添加失败！");
		}
		return "/identity/user/addUser";
	}

	// 展示修改用户页面
	@RequestMapping(value = "/showUpdateUser.jspx")
	public String showUpdateUser(@RequestParam("userId") String userId,
			Model model) {
		try {
			User user = userService.getUserById(userId);
			model.addAttribute("user", user);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/identity/user/updateUser";
	}

	// 修改用户
	@RequestMapping(value = "/updateUser.jspx")
	public String updateUser(User user, Model model, HttpSession session) {
		try {
			userService.updateUser(user, session);
			model.addAttribute("msg", "修改成功!");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "修改失败!");
		}

		return "/identity/user/updateUser";
	}

	// 预览用户
	@RequestMapping(value = "/preUser.jspx")
	public String preUser(String userId, Model model) {
		// 根据用户账号获取用户信息
		User user = userService.getUserById(userId);
		// 将用户信息存放在model中
		model.addAttribute("user", user);

		return "/identity/user/preUser";
	}

	// 激活用户

	@RequestMapping(value = "/activeUser.jspx")
	public String activeUser(User user, PageModel pageModel, Model model,
			HttpSession session) {
		try {
			userService.activeUser(user, session);
			return "forward:/identity/user/selectUser.jspx";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//修改个人信息
	@RequestMapping(value = "/updateSelf.jspx")
	public String updateSelf(User user, PageModel pageModel, Model model,
			HttpSession session) {
		try {
			userService.updateSelf(user, session);
			model.addAttribute("msg","修改成功!");
			return "home";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg","修改失败!");
		}
		return null;
	}

}
