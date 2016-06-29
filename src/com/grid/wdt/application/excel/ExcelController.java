package com.grid.wdt.application.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.ActionKey;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.jfinal.upload.UploadFile;

/**
 * 导入excel 演示
 * 
 * @author PC
 * 
 */
public class ExcelController extends Controller {

	/**
	 * 导入数据
	 */
	@Clear
	@ActionKey("excel/")
	public void excelDemo() {
		render("excelDemo.jsp");
	}

	/**
	 * 普通文件上传,导入excel
	 * 
	 * @throws IOException
	 */
	@Clear
	@Before(Tx.class)
	public void imData() throws IOException {

		UploadFile file = getFile();
		File source = file.getFile();
		String oldFileName = file.getFileName();

		String extension = oldFileName.substring(oldFileName.lastIndexOf("."));

		JSONObject json = new JSONObject();

		FileInputStream is = new FileInputStream(source);
		// 验证文件类型
		if (extension.equals(".xls")) {
			HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
			HSSFSheet sheet = hssfWorkbook.getSheetAt(0);

			int rows = sheet.getLastRowNum();
			int num = 0;
			for (int i = 1; i <= rows; i++) {
				HSSFRow row = sheet.getRow(i);

				System.out.println(row.getCell(1) + "-" + row.getCell(2));

				// -------------写数据到数据库-------------
				num++;
				// -------------写数据到数据库-------------
			}
            
			source.delete();//删除临时文件
			
			json.put("status", true);// 导入成功
			json.put("num", num);// 导入成功的数据条数

		}

		renderJson(json.toJSONString());
	}

	@SuppressWarnings("static-access")
	private String getValue(HSSFCell cell) {
		if (cell == null) {
			return "";
		} else if (cell.getCellType() == cell.CELL_TYPE_BOOLEAN) {
			// 返回布尔类型的值
			return String.valueOf(cell.getBooleanCellValue());
		} else if (cell.getCellType() == cell.CELL_TYPE_NUMERIC) {
			if (HSSFDateUtil.isCellDateFormatted(cell)) {
				double d = cell.getNumericCellValue();
				Date date = HSSFDateUtil.getJavaDate(d);
				return new SimpleDateFormat("yyyy-MM-dd").format(date);
			} else {
				// 返回数值类型的值
				return String.valueOf(cell.getNumericCellValue());
			}
		} else {
			// 返回字符串类型的值
			return String.valueOf(cell.getStringCellValue());
		}
	}
	
	
	//-----------------------分隔线-----------------------

	/**
	 * 导出excel 演示
	 * 
	 * @throws Exception
	 */
	@Clear
	public void outExcel() throws Exception {
		// 第一步，创建一个webbook，对应一个Excel文件
		HSSFWorkbook wb = new HSSFWorkbook();
		// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
		HSSFSheet sheet = wb.createSheet("sheet1");
		//sheet.setVerticallyCenter(true);

		// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
		HSSFRow row;// 定义行
		HSSFCell cell;// 定义列

		row = sheet.createRow((int) 0);

		cell = row.createCell((short) 0);
		cell.setCellValue("序号");
		cell = row.createCell((short) 1);
		cell.setCellValue("姓名");
		cell = row.createCell((short) 2);
		cell.setCellValue("年龄");

		// 第五步，构建一串数据
		List<Map> list = new ArrayList<Map>();
		for (int i = 0; i < 10; i++) {
			Map<String, Object> mp = new HashMap<String, Object>();
			mp.put("id", i + 1);
			mp.put("name", "张三" + i);
			mp.put("age", i + 20);
			list.add(mp);
		}

		// 写入excel表中
		for (int j = 0; j < list.size(); j++) {
			// 表体
			row = sheet.createRow((int) j + 1);
			cell = row.createCell((short) 0);
			cell.setCellValue(list.get(j).get("id").toString());
			cell = row.createCell((short) 1);
			cell.setCellValue(list.get(j).get("name").toString());
			cell = row.createCell((short) 2);
			cell.setCellValue(list.get(j).get("age").toString());

		}

		// 第六步，将文件存到指定位置
		String fileName = new Date().getTime() + ".xls";// 时间戳命名文件
		getResponse().setContentType("application/vnd.ms-excel");
		getResponse().setHeader("Content-disposition",
				"attachment;filename=" + fileName);
		OutputStream ouputStream = getResponse().getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
		
		renderNull(); //jfinal 框架结束？
	}

}
