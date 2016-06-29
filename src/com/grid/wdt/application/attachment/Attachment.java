package com.grid.wdt.application.attachment;


import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

@SuppressWarnings("serial")
public class Attachment extends Model<Attachment> {

	public static final Attachment dao = new Attachment();

	/**
	 * 所有 sql 与业务逻辑写在 Model 或 Service 中，不要写在 Controller 中，养成好习惯，有利于大型项目的开发与维护
	 */
	public Page<Attachment> paginate(int pageNumber, int pageSize) {

		return paginate(pageNumber, pageSize, "select *",
				"from jf_attachment order by id desc");
	}

	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	public int deleteByIds(String ids) {
		// TODO Auto-generated method stub
		return Db.update("delete from jf_attachment where id in (" + ids + ")");
	}
     

}
