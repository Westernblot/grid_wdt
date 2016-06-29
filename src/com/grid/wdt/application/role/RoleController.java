package com.grid.wdt.application.role;

import java.util.List;

import com.grid.wdt.application.user.User;
import com.grid.wdt.util.StringUtil;
import com.jfinal.aop.Before;
import com.jfinal.core.ActionKey;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.tx.Tx;

public class RoleController extends Controller {

	/**
	 * 用户列表
	 */
	@ActionKey("role/")
	public void roleMain() {
		setAttr("page",
				Role.dao.paginate(getParaToInt("pageNumber", 1),
						getParaToInt("pageSize", 10)));
		render("roleMain.jsp");
	}

	/**
	 * 编辑UI页面
	 */
	public void roleUI() {
		int id = getParaToInt("id", 0);
		
		Role role= Role.dao.findById(id);
		
		System.out.println(role);
		
		if(role!=null){
			
			//查找此角色下的所有用户
			String name = role.get("name");
			List<User> list = Role.dao.queryByRoleName(name);
//			
//			for (User user : list) {
//				System.out.println(user.get("cnname"));
//			}
 			setAttr("list", list);
		}
		
		setAttr("mo", role);
		
		render("roleUI.jsp");
	}

	// ===================基本CRUD==========================

	/**
	 * 新增
	 */
	@Before(Tx.class)
	public void insert() {

		Role role = getModel(Role.class);
		// 对字符串的处理
		String[] powerArr = getParaValues("role.power");
		if (powerArr != null) {
			String power = StringUtil.explode(powerArr);
			// System.out.println(power);
			role.set("power", power);
		}

		// 修改用户 角色
		String name = getPara("role.name", "");
		String[] useridArr = getParaValues("userid");
		System.out.println(useridArr);
		if (useridArr != null) {
			String userids = StringUtil.explode(useridArr);
			Role.dao.updateUserRole(name, userids);
		}

		boolean status = role.save();
		if (status) {
			redirect("/success?toPage=role/", true);
		} else {
			redirect("/error", true);
		}
	}

	/**
	 * 修改
	 */
	@Before(Tx.class)
	public void update() {
		Role role = getModel(Role.class);
		// 对字符串的处理
		String[] powerArr = getParaValues("role.power");
		if (powerArr != null) {
			String power = StringUtil.explode(powerArr);
			// System.out.println(power);
			role.set("power", power);
		}

		//先清除user角色
		String id = getPara("role.id","");
		Role.dao.syncDelRole(id);
		
		// 修改用户 角色
		String name = getPara("role.name", "");
		String[] useridArr = getParaValues("userid");
		System.out.println(useridArr);
		if (useridArr != null) {
			String userids = StringUtil.explode(useridArr);
			Role.dao.updateUserRole(name, userids);
		}

		boolean status = role.update();
		if (status) {
			redirect("/success?toPage=role/", true);
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
		
		//同步清除user的角色
		Role.dao.syncDelRole(ids);
		
		int flag = Role.dao.deleteByIds(ids);
		if (flag > 0) {
			redirect("/success", true);
		} else {
			redirect("/error", true);
		}
	}

}
