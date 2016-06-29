package com.grid.wdt.application.user;

import java.util.List;

import com.grid.wdt.application.dept.Dept;
import com.grid.wdt.application.menu.Menu;
import com.grid.wdt.application.role.Role;
import com.grid.wdt.interceptor.LoginInterceptor;
import com.grid.wdt.util.DateUtil;
import com.grid.wdt.util.MD5;
import com.grid.wdt.util.StringUtil;
import com.jfinal.aop.Before;
import com.jfinal.core.ActionKey;
import com.jfinal.core.Controller;

@Before(LoginInterceptor.class)
public class UserController extends Controller {

	/**
	 * 用户列表
	 */
	@ActionKey("user/")
	public void userMain() {
		// 选择出系统用户，而非所有成员:此处判断若用户名不为空，则认为是系统用户
		String dept = getPara("dept", "");
		String cnname = getPara("cnname", "");
		String urlParas = "&dept=" + dept + "&cnname=" + cnname;

		// 查询条件回显
		setAttr("dept", dept);
		setAttr("cnname", cnname);
		setAttr("urlParas", urlParas);

		// 构造查询条件
		String condition = "username !=''";
		if (!dept.equals("")) {
			condition += " and dept ='" + dept + "'";
		}
		if (!cnname.equals("")) {
			condition += " and cnname like '%" + cnname + "%'";
		}

		setAttr("page",
				User.dao.paginate(getParaToInt("pageNumber", 1),
						getParaToInt("pageSize", 10), condition));
		render("userMain.jsp");
	}

	/**
	 * 用户选择页面
	 */
	public void userSelect() {
		// 选择出系统用户，而非所有成员:此处判断若用户名不为空，则认为是系统用户
		String dept = getPara("dept", "");
		String cnname = getPara("cnname", "");
		String urlParas = "&dept=" + dept + "&cnname=" + cnname;

		// 查询条件回显
		setAttr("dept", dept);
		setAttr("cnname", cnname);
		setAttr("urlParas", urlParas);

		// 构造查询条件
		String condition = "username !=''";
		if (!dept.equals("")) {
			condition += " and dept ='" + dept + "'";
		}
		if (!cnname.equals("")) {
			condition += " and cnname like '%" + cnname + "%'";
		}

		setAttr("page",
				User.dao.paginate(getParaToInt("pageNumber", 1),
						getParaToInt("pageSize", 10), condition));
		render("userSelect.jsp");
	}

	/**
	 * 编辑UI页面
	 */
	public void userUI() {
		int id = getParaToInt("id", 0);
		setAttr("mo", User.dao.findById(id));

		// 查找系统的角色
		List<Role> roleList = User.dao.queryRoles();
		setAttr("roleList", roleList);
		render("userUI.jsp");
	}

	/**
	 * 设置权限页面
	 */
	public void setPowerUI() {

		// 菜单树
		List<Menu> baseMenuList = Menu.dao.selectBaseMenuList();
		List<Menu> subMenuList = Menu.dao.selectSubMenuList();
		setAttr("baseMenuList", baseMenuList);
		setAttr("subMenuList", subMenuList);

		int id = getParaToInt("id", 0);
		User user = User.dao.findById(id);
		setAttr("user", user);

		render("setPowerUI.jsp");
	}

	/**
	 * 修改个人密码
	 */
	public void setPwdUI() {
		int id = getParaToInt("id", 0);
		setAttr("mo", User.dao.findById(id));
		render("setPwdUI.jsp");
	}

	// ===================基本CRUD==========================

	/**
	 * 新增
	 */
	public void insert() {
		String username = getPara("user.username");
		// String password = getPara("user.password");
		// 检查用户是否存在
		boolean flag = User.dao.checkIsExist(username);
		if (flag) {
			User user = getModel(User.class);
			user.set("password", MD5.md5("1")); // 注册时设置初始密码为1
			user.set("add_time", DateUtil.getTime());
			// renderJson(user.save());// 注册用户，1表示成功，0表示不成功

			if (user.save()) {
				redirect("/success?toPage=user/", true);
			} else {
				redirect("/error", true);
			}

		} else {
			redirect("/error", true);
		}
	}

	/**
	 * 修改
	 */
	public void update() {
		User user = getModel(User.class);
		// 对字符串的处理
		String[] powerArr = getParaValues("user.power");
		if (powerArr != null) {
			String power = StringUtil.explode(powerArr);
			// System.out.println(power);
			user.set("power", power);
		}
		// renderJson(user.update());

		boolean status = user.update();
		if (status) {
			redirect("/success?toPage=user/", true);
		} else {
			redirect("/error", true);
		}
	}

	/**
	 * 删除
	 */
	public void delete() {
		String ids = getPara("ids");

		int flag = User.dao.deleteByIds(ids);

		if (flag > 0) {
			redirect("/success", true);
		} else {
			redirect("/error", true);
		}
	}

	/**
	 * 重置密码
	 */
	public void resetPwd() {
		String ids = getPara("ids");
		// renderJson(User.dao.resetUserPwd(ids));
		int flag = User.dao.resetUserPwd(ids);
		if (flag > 0) {
			redirect("/success", true);
		} else {
			redirect("/error", true);
		}
	}

	/**
	 * 个人修改密码
	 */
	public void setPwd() {
		int id = getParaToInt("id", 0);
		String password = getPara("password");
		// renderJson(User.dao.setUserPwd(id, password));
		int flag = User.dao.setUserPwd(id, password);
		if (flag > 0) {
			redirect("/success", true);
		} else {
			redirect("/error", true);
		}
	}

	/**
	 * 根据部门查找用户
	 */
	public void findUserByDept(){
		String dept = getPara("dept");
		renderJson(User.dao.findUserByDept(dept));
	}
	
}
