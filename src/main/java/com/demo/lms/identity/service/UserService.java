package com.demo.lms.identity.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.demo.lms.identity.bean.Module;
import com.demo.lms.identity.bean.Role;
import com.demo.lms.identity.bean.User;

import common.util.webTag.PageModel;

public interface UserService {
	//登录验证
	String userLogin(String session_code, User user, String code, Boolean check,
                     HttpServletRequest request, HttpServletResponse response);
	//根据用户ID查询
	User getUserById(String userId);
	//多条件查询
	List<User> selectUserByPage(User user, PageModel pageModel);
	//获取部门与职业的json格式字符串
	String ajaxLoadDeptAndJob();
	//根据ID删除用户
	void deleteUserById(String id);
	//添加用户
	void addUser(User user, HttpSession session);
	//修改用户
	void updateUser(User user, HttpSession session);
	//激活用户
	void activeUser(User user, HttpSession session);
	//修改个人信息
	void updateSelf(User user, HttpSession session);
	
	//************************角色管理********************************
	//查询角色
	List<Role> selectRoleByPage(Role role, PageModel pageModel);
	//添加角色
	void addRole(Role role, HttpSession session);
	//删除角色
	void deleteRoleById(String id);
	//修改角色
	void updateRole(Role role, HttpSession session);
	//查询单个角色
	Role getRoleById(String roleId);
	//根据角色id查询用户信息
	List<User> selectRoleUser(Role role, PageModel pageModel);
	//展示未绑定指定角色的用户信息
	List<User> showNotBindUser(Role role, PageModel pageModel);
	//绑定指定角色给指定用户
	void bindUser(Role role, String userIds, PageModel pageModel);
	//解绑用户
	void unbindUser(Role role, String userIds, PageModel pageModel);
	
	//************************模块管理********************************
	//通过ajax异步请求获取模块
	String ajaxModule();
	//根据父级code获取子模块页面
	List<Module> getModulesByParent(String parentCode, PageModel pageModel);
	//添加模块
	void addModule(Module module, String parentCode, HttpSession session);
	//删除指定模块
	void deleteModuleById(String id);
	//根据ID得到模块
	Module getModuleByCode(String code);
	//修改模块
	void updateModule(Module module, HttpSession session);
	
	//**************************权限管理**************************************
	//根据父级ID和角色ID查询子模块(操作)的code
	List<String> getPopedomByParentAndRole(String parentCode, String roleId);
	//绑定操作
	void bindPopedom(String parentCode, String roleId, String codes,
                     HttpSession session);
	List<Module> getModulesByParent(String parentCode);
	//根据登录用户的用户id获取角色,再根据角色ID获取权限信息
	Map<Module, List<Module>> findUserAllOpeas(HttpSession session);
	//根据登录用户的用户id获取角色,再根据角色ID获取权限信息
	List<String> findUserOpeas(HttpSession session);
}
