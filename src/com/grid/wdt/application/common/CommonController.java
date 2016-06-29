package com.grid.wdt.application.common;



import com.jfinal.core.ActionKey;
import com.jfinal.core.Controller;

public class CommonController extends Controller{

	
	
	/**
	 * 成功跳转页面
	 */
	@ActionKey("success")
	public void success(){
		String toPage = getPara("toPage");
		setAttr("toPage", toPage);
		renderJsp("success.jsp");
	}
	
	
	/**
	 * 错误返回页面
	 */
	@ActionKey("error")
	public void error(){
		renderJsp("error.jsp");
	}
	
	
}
