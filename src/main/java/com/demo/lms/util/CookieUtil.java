package com.demo.lms.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {
	
	private CookieUtil(){
	}
	
	public static void addCookie(String userId, int time, String cookieName, HttpServletRequest request, HttpServletResponse response){
		//根据cookieName获取cookie,需要根据request获取浏览器发送过来的所有cookie
		Cookie cookie = getCookieByName(cookieName,request);
		//如果没有cookie
		if(cookie == null){
			cookie = new Cookie(cookieName,userId);
		}
		//已找个对应的cookie,但需要修改回以当前用户为帐号的cookie
		cookie.setValue(userId);
		//设置时间
		cookie.setMaxAge(time);
		//设置在当前项目生效
		cookie.setPath("/");
		//响应回浏览器
		response.addCookie(cookie);
	}

	public static Cookie getCookieByName(String cookieName,
			HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if(cookies!=null){
			for(Cookie cookie:cookies){
				//找到对应名字的cookie
				if(cookie.getName().equals(cookieName)){
					return cookie;
				}
			}
		}
		
		return null;
	}

	public static void removeCookie(String cookieName, HttpServletRequest request,
			HttpServletResponse response) {
		
		//根据名字获取Cookie
		Cookie cookie = getCookieByName(cookieName, request);
		if(cookie!=null){
			cookie.setMaxAge(0);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
	}
}
