package com.demo.lms.identity.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.demo.lms.hrm.dao.DeptDao;
import com.demo.lms.hrm.dao.JobDao;
import com.demo.lms.identity.bean.Module;
import com.demo.lms.identity.bean.Popedom;
import com.demo.lms.identity.bean.Role;
import com.demo.lms.identity.bean.User;
import com.demo.lms.identity.dao.ModuleDao;
import com.demo.lms.identity.dao.PopedomDao;
import com.demo.lms.identity.dao.RoleDao;
import com.demo.lms.identity.dao.UserDao;
import com.demo.lms.identity.service.UserService;
import com.demo.lms.util.CookieUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import common.util.webTag.PageModel;

@Service("userService")
@Transactional(rollbackFor=Exception.class)
public class UserServiceImpl implements UserService{
	
	@Resource(name="userDao")
	private UserDao userDao;
	@Resource(name="deptDao")
	private DeptDao deptDao;
	@Resource(name="jobDao")
	private JobDao jobDao;
	@Resource(name="roleDao")
	private RoleDao roleDao;
	@Resource(name="moduleDao")
	private ModuleDao moduleDao;
	@Resource(name="popedomDao")
	private PopedomDao popedomDao;

	@Override
	public String userLogin(String session_code, User user, String code, Boolean check, HttpServletRequest request, HttpServletResponse response) {
		return null;
	}

	@Override
	public User getUserById(String userId) {
		return null;
	}

	@Override
	public List<User> selectUserByPage(User user, PageModel pageModel) {
		return null;
	}

	@Override
	public String ajaxLoadDeptAndJob() {
		return null;
	}

	@Override
	public void deleteUserById(String id) {

	}

	@Override
	public void addUser(User user, HttpSession session) {

	}

	@Override
	public void updateUser(User user, HttpSession session) {

	}

	@Override
	public void activeUser(User user, HttpSession session) {

	}

	@Override
	public void updateSelf(User user, HttpSession session) {

	}

	@Override
	public List<Role> selectRoleByPage(Role role, PageModel pageModel) {
		return null;
	}

	@Override
	public void addRole(Role role, HttpSession session) {

	}

	@Override
	public void deleteRoleById(String id) {

	}

	@Override
	public void updateRole(Role role, HttpSession session) {

	}

	@Override
	public Role getRoleById(String roleId) {
		return null;
	}

	@Override
	public List<User> selectRoleUser(Role role, PageModel pageModel) {
		return null;
	}

	@Override
	public List<User> showNotBindUser(Role role, PageModel pageModel) {
		return null;
	}

	@Override
	public void bindUser(Role role, String userIds, PageModel pageModel) {

	}

	@Override
	public void unbindUser(Role role, String userIds, PageModel pageModel) {

	}

	@Override
	public String ajaxModule() {
		return null;
	}

	@Override
	public List<Module> getModulesByParent(String parentCode, PageModel pageModel) {
		return null;
	}

	@Override
	public void addModule(Module module, String parentCode, HttpSession session) {

	}

	@Override
	public void deleteModuleById(String id) {

	}

	@Override
	public Module getModuleByCode(String code) {
		return null;
	}

	@Override
	public void updateModule(Module module, HttpSession session) {

	}

	@Override
	public List<String> getPopedomByParentAndRole(String parentCode, String roleId) {
		return null;
	}

	@Override
	public void bindPopedom(String parentCode, String roleId, String codes, HttpSession session) {

	}

	@Override
	public List<Module> getModulesByParent(String parentCode) {
		return null;
	}

	@Override
	public Map<Module, List<Module>> findUserAllOpeas(HttpSession session) {
		return null;
	}

	@Override
	public List<String> findUserOpeas(HttpSession session) {
		return null;
	}
}
