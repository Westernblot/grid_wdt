package com.grid.wdt.application.vacate;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

public class Vacate extends Model<Vacate>{

	public static final Vacate dao = new Vacate();
	
public Page<Vacate> paginate(int pageNumber, int pageSize,String condition) {
		
		String select = "select *";
		
		String sqlExceptSelect = "from jf_vacate";
		if(!condition.equals("")){
			sqlExceptSelect+=" where "+condition;
		}
		sqlExceptSelect += " order by id desc";
		
		return paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}
	
/**
 * 批量删除
 * 
 * @param ids
 * @return
 */
public int deleteByIds(String ids) {
	// TODO Auto-generated method stub
	return Db.update("delete from jf_vacate where id in (" + ids + ")");
}
	
}
