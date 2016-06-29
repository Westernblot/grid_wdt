package com.grid.wdt.application.vacate;

import com.grid.wdt.interceptor.LoginInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.core.ActionKey;
import com.jfinal.core.Controller;
@Before(LoginInterceptor.class)
public class VacateController extends Controller{

	/**
	 * 请假管理
	 */
	@ActionKey("vacate/")
	public void vacateMain(){
		// 选择出系统用户，而非所有成员:此处判断若用户名不为空，则认为是系统用户
				String key = getPara("name", "");
				String begintime = getPara("begintime", "");
				String endtime = getPara("endtime", "");
				String urlParas = "&name=" + key + "&begintime=" + begintime+"&endtime="+endtime;
				// 查询条件回显
				setAttr("name", key);
				setAttr("begintime", begintime);
				setAttr("endtime", endtime);
				setAttr("urlParas", urlParas);
				// 构造查询条件
				String condition = "1=1";
				if (!key.equals("")) {
					condition += " and ( name ='" + key + "' or idcard ='"+key+"')";
				}
				if (!begintime.equals("")) {
					condition += " and begintime >= '" + begintime +"'";
				}
				if (!endtime.equals("")) {
					condition += " and endtime <= '" + endtime +"'";
				}

				setAttr("page",
						Vacate.dao.paginate(getParaToInt("pageNumber", 1),
								getParaToInt("pageSize", 10), condition));
		
				render("vacateMain.jsp");
	}
	
	public void vacateUI(){
		render("vacateUI.jsp");
	}
	
	/**
	 * 新增
	 */
	public void insert() {
		Vacate vacate = getModel(Vacate.class);
		boolean status = vacate.save();
		if (status) {
			redirect("/success?toPage=vacate/", true);
		} else {
			redirect("/error", true);
		}
	}
	/**
	 * 删除
	 */
	public void delete() {
		String ids = getPara("ids");
		int flag = Vacate.dao.deleteByIds(ids);

		if (flag > 0) {
			redirect("/success", true);
		} else {
			redirect("/error", true);
		}
	}
}
