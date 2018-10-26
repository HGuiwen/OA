package com.demo.lms.identity.dao.impl;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import com.demo.lms.identity.bean.Module;
import com.demo.lms.identity.bean.User;
import com.demo.lms.identity.dao.ModuleDao;

import common.dao.impl.BaseDaoImpl;
import common.util.webTag.PageModel;

public class ModuleDaoImpl  extends BaseDaoImpl implements ModuleDao{
	//查询模块信息
	@Override
	public List<Module> getModulesByParent(String parentCode, PageModel pageModel) {
		// TODO Auto-generated method stub
		try {
			List<Object> params = new ArrayList<>();
			StringBuffer hql = new StringBuffer();
			
			hql.append("select m from Module m where code like ? and length(code)=?"); 
			params.add(StringUtils.isEmpty(parentCode)?"%%":parentCode+"%");
			params.add(StringUtils.isEmpty(parentCode)?4:parentCode.length()+4);
			
			return this.findByPage(hql.toString(), pageModel, params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//添加模块
	@Override
	public void addModule(Module module, String parentCode, HttpSession session) {
		try {
			//设置修改时间
			module.setCreateDate(new Date());
			//设置修改人
			module.setCreater((User)session.getAttribute("SESSION_USER"));
			
			StringBuffer hql=new StringBuffer();
			List<Object> params=new ArrayList<>();
			hql.append("SELECT MAX(code) FROM Module WHERE code LIKE ? AND LENGTH(CODE) =?");
			params.add(StringUtils.isEmpty(parentCode)?"%":parentCode+"%");
			params.add(StringUtils.isEmpty(parentCode)?4:parentCode.length()+4);
			//00010005   000100010005
			String maxCode = this.findUniqueEntity(hql.toString(), params.toArray());
			String newCode = parentCode==null?"":parentCode;//0001   00010001
			//如果maxCode可能为空
			if(StringUtils.isEmpty(maxCode)){
				//00010001
				newCode += "0001";
			}else{
				//00010005 -> 0005 		000100010005 ->  0005
				String sCode = maxCode.substring(maxCode.length()-4, maxCode.length());
				
				//0005 -> 6   需要补3个0	
				int code = Integer.valueOf(sCode)+1;
				
				for(int i=0;i<4-String.valueOf(code).length();i++){
					//0001000
					newCode += "0";
				}
				
				newCode= newCode+code;
			}
			module.setCode(newCode);
			this.save(module);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
