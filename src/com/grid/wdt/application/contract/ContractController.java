package com.grid.wdt.application.contract;

import com.grid.wdt.application.dept.Dept;
import com.grid.wdt.application.vacate.Vacate;
import com.grid.wdt.interceptor.LoginInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.core.ActionKey;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.tx.Tx;


@Before(LoginInterceptor.class)
public class ContractController extends Controller{
	//合同管理列表
	@ActionKey("contract/")
	public void contractMain(){
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
			condition += " and ( name ='" + key + "' or number  ='"+key+"')";
		}
		if (!begintime.equals("")) {
			condition += " and begintime >= '" + begintime +"'";
		}
		if (!endtime.equals("")) {
			condition += " and endtime <= '" + endtime +"'";
		}

		setAttr("page",
				Contract.dao.paginate(getParaToInt("pageNumber", 1),
						getParaToInt("pageSize", 10), condition));

		render("contractMain.jsp");
	}
	
	public void contractUI(){
		render("contract.jsp");
	}
	public void contractDepartment(){
		render("contractDepartment.jsp");
	}
	public void contractPersonnel(){
		render("contractPersonnel.jsp");
	}
	public void celfareDistribution(){
		render("celfareDistribution.jsp");
	}
	
	/**
	 * 新增
	 */
	public void insert() {

		Contract contract = getModel(Contract.class);
		boolean status = contract.save();
		if (status) {
			redirect("/success?toPage=contract/", true);
		} else {
			redirect("/error", true);
		}
	}

	/**
	 * 修改
	 */
	@Before(Tx.class)
	public void update() {
		
		//同步修改User的所属部门
		int id = getParaToInt("dept.id");
		String newName = getPara("dept.name");
		Dept.dao.syncUpdateUserDept(id,newName);
		
		Dept dept = getModel(Dept.class);
		boolean status = dept.update();
		if (status) {
			redirect("/success?toPage=dept/", true);
		} else {
			redirect("/error", true);
		}
	}

	/**
	 * 删除
	 */
	@Before(Tx.class)
	public void delete() {
		String ids = getPara("ids");
		
		//同步清除User的所属部门
		Dept.dao.syncDelUserDept(ids);
		
		int flag = Dept.dao.deleteByIds(ids);
		if (flag > 0) {
			redirect("/success", true);
		} else {
			redirect("/error", true);
		}
	}
}
