package com.grid.wdt.application.menu;

import java.util.List;

import com.grid.wdt.application.role.Role;
import com.jfinal.plugin.activerecord.Model;

public class Menu extends Model<Menu>{

	public static final Menu dao = new Menu();

	/**
	 * 查询
	 * @return
	 */
	public List<Menu> select() {
		// TODO Auto-generated method stub
		return dao.find("select * from jf_menu");
	}
	
	
	/**
	 * 权限条件查询,根据用户查找其对应的权限
	 */
	public List<Menu> selectPower(String power){
		return find("select * from jf_menu where id in ("+power+")");
	}

    /**
     * 根权限查询
     * @return
     */
	public List<Menu> selectBaseMenuList() {
		// TODO Auto-generated method stub
		return find("select * from jf_menu where pid = 0");
	}

    /**
     * 子条件查询
     * @return
     */
	public List<Menu> selectSubMenuList() {
		// TODO Auto-generated method stub
		return find("select * from jf_menu where pid != 0");
	}

    /**
     * 根据用户角色来查询权限
     * @param role
     * @return
     */
	public List<Menu> queryPowerByRole(String roleName) {
		// TODO Auto-generated method stub
		
		Role role =  Role.dao.findFirst("select * from jf_role where name = ?",roleName);
		if(role!=null){
			String power = role.get("power");
			System.out.println(power);
			return dao.find("select * from jf_menu where id in ("+power+")");
		}
		
		return null;
	}
	
	
}
