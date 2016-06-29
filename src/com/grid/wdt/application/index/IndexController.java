package com.grid.wdt.application.index;

import com.grid.wdt.interceptor.LoginInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;

@Before(LoginInterceptor.class)
public class IndexController extends Controller{
	
	
	/**
	 * 系统首页
	 */
	public void index(){
		render("index.jsp");
	}
	
}
