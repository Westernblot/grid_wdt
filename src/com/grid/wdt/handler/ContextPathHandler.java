package com.grid.wdt.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jfinal.core.Action;
import com.jfinal.core.Controller;
import com.jfinal.handler.Handler;
import com.jfinal.render.Render;

public class ContextPathHandler extends Handler {

	@Override
	public void handle(String target, HttpServletRequest request,
			HttpServletResponse response, boolean[] isHandled) {
		// TODO Auto-generated method stub
		request.setAttribute("CONTEXT_PATH", request.getContextPath()); //添加项目根路径配置

		nextHandler.handle(target, request, response, isHandled);
	}

}
