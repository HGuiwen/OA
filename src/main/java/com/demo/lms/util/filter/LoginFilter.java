package com.demo.lms.util.filter;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demo.lms.identity.bean.User;
import com.demo.lms.identity.service.UserService;
import com.demo.lms.util.CookieUtil;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginFilter extends HandlerInterceptorAdapter{

	@Resource(name="userService")
	private UserService userService;
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		
		User user = (User) request.getSession().getAttribute("SESSION_USER");
		
		//session失效
		if(user==null){
			Cookie cookie = CookieUtil.getCookieByName("COOKIE_USER", request);
			//存在cookies将user放入session
			if(cookie!=null){
				//cookie没有失效但是session的User已失效,所以需要将user放进session中
				String userId = cookie.getValue();
				//根据帐号找到user
				User u = userService.getUserById(userId);
				//放进session
				request.getSession().setAttribute("SESSION_USER", u);
			}
		}
		//如果session存在就放行,如果cookies失效session也失效就拦截,没激活也拦截
		if(user==null){
			//说明session中没有用户信息，并且cookie中也没有用户信息，跳转至登录页面
			request.setAttribute("message", "您尚未登录，请登录后在进行相关操作！");
			request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
			return false;
		}else if(user.getStatus()==0){
			request.setAttribute("message", "您的帐号没激活,请联系管理员!");
			request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
			return false;
		}
		else{
			//放行
			return true	;
		}
		
		
	}
	
	
}
