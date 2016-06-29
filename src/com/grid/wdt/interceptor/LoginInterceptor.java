package com.grid.wdt.interceptor;


import com.grid.wdt.application.user.User;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

/**
 * 系统登录拦截器
 * 
 * @author PC
 * 
 */
public class LoginInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation inv) {
		// TODO Auto-generated method stub
		Controller controller = inv.getController();
		User user = controller.getSessionAttr("user");
		// &&loginUser.canVisit(ai.getActionKey();
		//System.out.println("inv.getActionKey()=="+inv.getActionKey());
		
		if (user != null) {
			inv.invoke();
		} else {
			controller.redirect("/login");
		}
	}

}
