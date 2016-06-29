package com.grid.wdt.application.role;


import java.util.List;

import com.grid.wdt.application.user.User;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

@SuppressWarnings("serial")
public class Role extends Model<Role> {

	public static final Role dao = new Role();

	/**
	 * 所有 sql 与业务逻辑写在 Model 或 Service 中，不要写在 Controller 中，养成好习惯，有利于大型项目的开发与维护
	 */
	public Page<Role> paginate(int pageNumber, int pageSize) {

		return paginate(pageNumber, pageSize, "select *",
				"from jf_role order by id desc");
	}

	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	public int deleteByIds(String ids) {
		// TODO Auto-generated method stub
		return Db.update("delete from jf_role where id in (" + ids + ")");
	}
     
	/**
	 * 修改用户的role
	 * @param name
	 * @param userids
	 */
	public void updateUserRole(String name, String userids) {
		// TODO Auto-generated method stub
		Db.update("update jf_user set role='"+name+"' where id in ("+userids+")");
	}

	/**
	 * 查询该角色下的所有用户
	 * @param name
	 * @return
	 */
	public List<User> queryByRoleName(String name) {
		// TODO Auto-generated method stub
		return User.dao.find("select * from jf_user where role = '"+name+"'");
	}

	/**
	 * 同步清除user表的role字段
	 * @param ids
	 */
	public void syncDelRole(String ids) {
		// TODO Auto-generated method stub
		Db.update("update jf_user set role = ' ' where role in (select name from jf_role where id in (" + ids + "))");
	}



}
