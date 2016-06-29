package com.grid.wdt.util;

/**
 * 字符串处理类
 * @author PC
 *
 */
public class StringUtil {

	/**
	 * 将字符串数组转化成字符串
	 * @param arr
	 * @return
	 */
	public static String explode(String[] arr){
		String str="";
		for(String s:arr){
			if(str.equals("")){
				str=s;
			}else{			
				str+=","+s;
			}
		}
		return str;
	}
}
