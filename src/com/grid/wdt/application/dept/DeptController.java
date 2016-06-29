package com.grid.wdt.application.dept;

import com.jfinal.aop.Before;
import com.jfinal.core.ActionKey;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.tx.Tx;

public class DeptController extends Controller {

	/**
	 * 部门管理
	 */
	@ActionKey("dept/")
	public void deptMain() {
		// render("deptMain.jsp");
		renderJsp("deptMain.jsp");
	}

	/**
	 * 查询部门树JSON
	 */
	public void deptJson() {
		renderJson(Dept.dao.selectTreeJson());
	}

	/**
	 * 部门编辑页面
	 */
	public void deptUI() {
		int id = getParaToInt("id", 0);
		Dept dept = Dept.dao.findById(id);
		setAttr("mo", dept);

		// ====查找父级部门====
		if (id != 0) {
			int pid = dept.get("pid");
			// System.out.println(pid);
			String pname = Dept.dao.findParentName(pid);
			//System.out.println(pname);
			setAttr("pname", pname);
		}
		render("deptUI.jsp");
	}
	
	/**
	 * 计算部门人数
	 */
	public void deptNum(){
		String dept=getPara("dept");
		int num = Dept.dao.countUserNum(dept);
		renderJson(num);
	}

	// ==================CRUD======================

	/**
	 * 新增
	 */
	public void insert() {

		Dept dept = getModel(Dept.class);
		boolean status = dept.save();
		if (status) {
			redirect("/success?toPage=dept/", true);
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
