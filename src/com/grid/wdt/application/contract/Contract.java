package com.grid.wdt.application.contract;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

public class Contract extends Model<Contract>{

	public static final Contract dao = new Contract();
	
public Page<Contract> paginate(int pageNumber, int pageSize,String condition) {
		
		String select = "select *";
		
		String sqlExceptSelect = "from jf_contract";
		if(!condition.equals("")){
			sqlExceptSelect+=" where "+condition;
		}
		sqlExceptSelect += " order by id desc";
		
		return paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}
	
	
}
