package com.grid.wdt.application.file;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.jfinal.upload.UploadFile;

/**
 * 文件上传下载 实现类
 * 
 * @author PC
 * 
 */
public class FileController extends Controller {

	
	/**
	 * 普通文件上传
	 */
	@Clear
	public void upload(){
		
		String path = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		UploadFile file = getFile();

		File source = file.getFile();
		String oldFileName = file.getFileName();
		String fileName = "";
        
		String extension = oldFileName.substring(oldFileName.lastIndexOf("."));
		String prefix;
		if (".png".equals(extension) || ".jpg".equals(extension)
				|| ".gif".equals(extension)) {
			prefix = "uploads/img";
		} else {
			prefix = "uploads/file";
		}
		fileName = generateWord() + extension;
		JSONObject json = new JSONObject();
		try {
			FileInputStream fis = new FileInputStream(source);
			File targetDir = new File(PathKit.getWebRootPath() + "/" + prefix
					+ "/" + path);
			if (!targetDir.exists()) {
				targetDir.mkdirs();
			}
			File target = new File(targetDir, fileName);
			if (!target.exists()) {
				target.createNewFile();
			}
			FileOutputStream fos = new FileOutputStream(target);
			byte[] bts = new byte[300];
			while (fis.read(bts, 0, 300) != -1) {
				fos.write(bts, 0, 300);
			}
			fos.close();
			fis.close();
			json.put("status", true);
			json.put("name", oldFileName);
			json.put("url", prefix + "/" + path + "/" + fileName);
			source.delete();
		} catch (FileNotFoundException e) {
			json.put("status", false);
			json.put("message", "上传出现错误，请稍后再上传");
		} catch (IOException e) {
			json.put("status", false);
			json.put("message", "文件写入服务器出现错误，请稍后再上传");
		}
		renderJson(json.toJSONString());
	}
	
	
	//----------------------------分隔线---------------------------------
	/**
	 * 文件上传 < 符合kindeditor 上传规范 >
	 */
	@Clear
	public void mangeupload() {
		String path = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		UploadFile file = getFile();

		File source = file.getFile();
		String fileName = file.getFileName();
		String extension = fileName.substring(fileName.lastIndexOf("."));
		String prefix;
		if (".png".equals(extension) || ".jpg".equals(extension)
				|| ".gif".equals(extension)) {
			prefix = "uploads/img";
		} else {
			prefix = "uploads/file";
		}
		fileName = generateWord() + extension;
		JSONObject json = new JSONObject();
		try {
			FileInputStream fis = new FileInputStream(source);
			File targetDir = new File(PathKit.getWebRootPath() + "/" + prefix
					+ "/" + path);
			if (!targetDir.exists()) {
				targetDir.mkdirs();
			}
			File target = new File(targetDir, fileName);
			if (!target.exists()) {
				target.createNewFile();
			}
			FileOutputStream fos = new FileOutputStream(target);
			byte[] bts = new byte[300];
			while (fis.read(bts, 0, 300) != -1) {
				fos.write(bts, 0, 300);
			}
			fos.close();
			fis.close();
			json.put("error", 0);
			json.put("url", prefix + "/" + path + "/" + fileName);
			source.delete();
		} catch (FileNotFoundException e) {
			json.put("error", 1);
			json.put("message", "上传出现错误，请稍后再上传");
		} catch (IOException e) {
			json.put("error", 1);
			json.put("message", "文件写入服务器出现错误，请稍后再上传");
		}
		renderJson(json.toJSONString());
	}

	/**
	 * 文件下载
	 * @throws UnsupportedEncodingException 
	 */
	@Clear
	public void download() throws UnsupportedEncodingException {
		
		String path = PathKit.getWebRootPath() +"/uploads/img/2016-04-28/D3SZ.jpg"; // 文件的绝对路径
		//System.out.println(path);
		
		boolean isExist = new File(path).isFile();
		if(isExist){
			renderFile(new File(path));
			return;
		}else{
			//文件不存在，404错误！
			renderNull();
		}
		
	
	}
	
	
	/**
	 * 文件下载2
	 * @return
	 * @throws IOException 
	 */
	@Clear
	public void download2() throws IOException{
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		
		//String fileName = "普通菩提.jpg";
		//String downloadPath = PathKit.getWebRootPath() +"/uploads/img/2016-04-28/D3SZ.jpg"; // 文件的绝对路径

		String fileName = getPara("fileName");
		String fileURL = PathKit.getWebRootPath()+"/"+getPara("fileURL");
				
		Long fileLength = new File(fileURL).length();
		getResponse().setContentType("application/x-msdownload;");
	
		getResponse().setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(fileName, "UTF-8")); 
		getResponse().setHeader("Content-Length", String.valueOf(fileLength));
		bis = new BufferedInputStream(new FileInputStream(fileURL));
		bos = new BufferedOutputStream(getResponse().getOutputStream());
		byte[] buff = new byte[2048];
		int bytesRead;

		while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
			bos.write(buff, 0, bytesRead);
		}

		bis.close();
		bos.close();
		
		renderNull();//可写可不写？
	}

	// =================================分隔线============================================

	private String generateWord() {
		String[] beforeShuffle = new String[] { "2", "3", "4", "5", "6", "7",
				"8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
				"K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
				"W", "X", "Y", "Z" };
		List<String> list = Arrays.asList(beforeShuffle);
		Collections.shuffle(list);
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < list.size(); i++) {
			sb.append(list.get(i));
		}
		String afterShuffle = sb.toString();
		String result = afterShuffle.substring(5, 16);
		return result;
	}

}
