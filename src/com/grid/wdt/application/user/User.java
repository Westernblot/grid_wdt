package com.grid.wdt.application.user;

import java.util.List;

import com.grid.wdt.application.role.Role;
import com.grid.wdt.util.MD5;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

@SuppressWarnings("serial")
public class User extends Model<User> {

	public static final User dao = new User();

	/**
	 * 所有 sql 与业务逻辑写在 Model 或 Service 中，不要写在 Controller 中，养成好习惯，有利于大型项目的开发与维护
	 */
	public Page<User> paginate(int pageNumber, int pageSize,String condition) {
		
		String select = "select *";
		
		String sqlExceptSelect = "from jf_user";
		if(!condition.equals("")){
			sqlExceptSelect+=" where "+condition;
		}
		sqlExceptSelect += " order by id desc";
		
		return paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}

	/**
	 * 查找登陆用户的信息
	 * 
	 * @param username
	 * @param password
	 */
	public User findUserInfo(String username, String password) {
		// TODO Auto-generated method stub
		User user = null;
		String md5Pwd = MD5.md5(password);
		if(username.equalsIgnoreCase("admin")){
			user = dao.findFirst("select * from jf_user where username=? and password = ?", username, md5Pwd);
		}else{
			user = dao.findFirst("select * from jf_user where username=? and password = ? and flag = ?", username, md5Pwd,"启用");
		}
		return user;
	}

	/**
	 * 批量删除
	 * 
	 * @param ids
	 * @return
	 */
	public int deleteByIds(String ids) {
		// TODO Auto-generated method stub
		return Db.update("delete from jf_user where id in (" + ids + ")");
	}

	/**
	 * 重置用户密码
	 * 
	 * @param ids
	 * @return
	 */
	public int resetUserPwd(String ids) {
		// TODO Auto-generated method stub
		String md5Pwd = MD5.md5("1");
		return Db.update("update jf_user set password = '" + md5Pwd
				+ "' where id in (" + ids + ")");
	}

	/**
	 * 用户修改密码
	 */
	public int setUserPwd(int id, String password) {
		String md5Pwd = MD5.md5(password);
		return Db.update("update jf_user set password = '" + md5Pwd
				+ "' where id =?", id);
	}

	/**
	 * 判断用户是否存在
	 * 
	 * @param username
	 * @return
	 */
	public boolean checkIsExist(String username) {
		// TODO Auto-generated method stub
		User user = findFirst("select top 1 * from jf_user where username=?",
				username);
		if (user == null) {
			return true;// 表明用户不存在，可以注册
		} else {
			return false;
		}
	}
    
	/**
	 * 查找系统的角色
	 * @return
	 */
	public List<Role> queryRoles() {
		// TODO Auto-generated method stub
		return Role.dao.find("select * from jf_role order by id desc");
	}
	
	/**
	 * 根据部门查找用户
	 */
	public List<User> findUserByDept(String dept){
		return find("select * from jf_user where dept=?",dept);
	}
}
