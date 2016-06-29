package com.grid.wdt.application.attachment;


import com.grid.wdt.util.StringUtil;
import com.jfinal.core.ActionKey;
import com.jfinal.core.Controller;


public class AttachmentController extends Controller {

	/**
	 * 附件上传列表
	 */
	@ActionKey("attachment/")
	public void attachmentMain() {
		setAttr("page",
				Attachment.dao.paginate(getParaToInt("pageNumber", 1),
						getParaToInt("pageSize", 10)));
		render("attachmentMain.jsp");
	}
	
	
	
	/**
	 * 附件上传页面
	 */
	public void attachmentUI(){
        int id = getParaToInt("id", 0);
		Attachment attachment = Attachment.dao.findById(id);
	    setAttr("mo", attachment);
		render("attachmentUI.jsp");
	}
	
	
	//------------------以下CRUD------------------------
	
	
	/**
	 * 增
	 */
	public void insert(){
		Attachment attachment = getModel(Attachment.class);
		// 对字符串的处理
		String[] attachmentArr = getParaValues("attachment.attachment");
		String[] attachment_urlArr = getParaValues("attachment.attachment_url");
		if (attachmentArr != null) {
			String attachmentvalue = StringUtil.explode(attachmentArr);
			String attachment_urlvalue = StringUtil.explode(attachment_urlArr);
			// System.out.println(power);
			attachment.set("attachment", attachmentvalue);
			attachment.set("attachment_url", attachment_urlvalue);
		}
		
		boolean status = attachment.save();
		if (status) {
			redirect("/success?toPage=attachment/", true);
		} else {
			redirect("/error", true);
		}
		
	}
	
	
	/**
	 * 修改
	 */
	public void update(){
		Attachment attachment = getModel(Attachment.class);
		// 对字符串的处理
		String[] attachmentArr = getParaValues("attachment.attachment");
		String[] attachment_urlArr = getParaValues("attachment.attachment_url");
		if (attachmentArr != null) {
			String attachmentvalue = StringUtil.explode(attachmentArr);
			String attachment_urlvalue = StringUtil.explode(attachment_urlArr);
			// System.out.println(power);
			attachment.set("attachment", attachmentvalue);
			attachment.set("attachment_url", attachment_urlvalue);
		}
		
		boolean status = attachment.update();
		if (status) {
			redirect("/success?toPage=attachment/", true);
		} else {
			redirect("/error", true);
		}
	}
	
	/**
	 * 删除
	 */
	public void delete(){
        String ids = getPara("ids");
		
		int flag = Attachment.dao.deleteByIds(ids);
		if (flag > 0) {
			redirect("/success", true);
		} else {
			redirect("/error", true);
		}
	}
	
}
