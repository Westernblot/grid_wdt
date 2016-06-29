package com.grid.wdt.application.dept;

import java.util.List;

import com.grid.wdt.application.user.User;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;

public class Dept extends Model<Dept>{

	public static final Dept dao = new Dept();

    /**
     * 查询部门树JSon
     * @return
     */
	public List<Dept> selectTreeJson() {
		// TODO Auto-generated method stub
		return find("select id,pid as pId,name from jf_dept");
	}
	
	/**
	 * 删除byIds
	 */
	public int deleteByIds(String ids){
		return Db.update("delete from jf_dept where id in (" + ids + ")");
	}
	
	
	/**
	 * 查询父级对象名称
	 */
	public String findParentName(int pid){
		String pname = "";
		Dept dept = findFirst("select top 1 name from jf_dept where id = ?", pid);
		if(dept!=null){
			pname = dept.get("name");
		}
		return pname;
	}

	/**
	 * 同步修改user用户的所属部门
	 * @param id
	 * @param newName
	 */
	public void syncUpdateUserDept(int id, String newName) {
		// TODO Auto-generated method stub
		String oldName="";
		Dept dept = dao.findFirst("select name from jf_dept where id =?",id);
		if(dept!=null){
			oldName = dept.get("name");
		}
		
		Db.update("update jf_user set dept = '"+newName+"' where dept='"+oldName+"'");
	}

	/**
	 * 同步清除user用户的所属部门
	 * @param ids
	 */
	public void syncDelUserDept(String ids) {
		// TODO Auto-generated method stub
		Db.update("update jf_user set dept = ' ' where dept in (select name from jf_dept where id in (" + ids + "))");
	}
	/**
	 * 计算部门人数
	 */
	public int countUserNum(String dept){
		return Db.queryInt("select count(*) from jf_user where dept='"+dept+"'");
	}
}
