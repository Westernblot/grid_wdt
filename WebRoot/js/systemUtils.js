/****************************************/
/**
 * 网格软件js公共库 系统js
 * 2013.08.30
 */
var SysBasePath = null;
jQuery(document).ready(function(){
	
	//屏蔽退格键操作 
	jQuery(document).keydown( function(e) 
	{ 
		var ev = e || window.event; //获取event对象 
        var obj = ev.target || ev.srcElement; //获取事件源 
        var t = obj.type || obj.getAttribute('type'); //获取事件源类型 
        //获取作为判断条件的事件类型 
        var vReadOnly = obj.readOnly;
        var vDisabled = obj.disabled;
        //处理undefined值情况 
        vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
        vDisabled = (vDisabled == undefined) ? true : vDisabled;
        //当敲Backspace键时，事件源类型为密码或单行、多行文本的， 
        //并且readOnly属性为true或disabled属性为true的，则退格键失效 
        var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);
        //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效 
        var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";
        //判断 
        if (flag2 || flag1) return false;
	});
	
	//屏蔽F5
	/*
	jQuery(document).bind("keydown",function(e){
		var ev = window.event || e;
		var code = ev.keyCode || ev.which;
		if (code == 116) {
		    ev.keyCode ? ev.keyCode = 0 : ev.which = 0;
		    cancelBubble = true;
		    if(e && e.preventDefault) {
		    	e.preventDefault();
		    }else{
		    	window.event.returnValue = false;
		    }
		    return false;
		}
	});
	//屏蔽鼠标右键
	jQuery(document).bind("contextmenu",function(e){   
	    return false;   
	});
	*/
	//window.history.go(1);
	/*jQuery(document).keydown(function (e) {
	    var doPrevent;
	    if (e.keyCode == 8) {
	        var d = e.srcElement || e.target;
	        if (d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA') {
	            doPrevent = d.readOnly || d.disabled;
	        }
	        else
	            doPrevent = true;
	    }
	    else
	        doPrevent = false;
	    if (doPrevent)
	        e.preventDefault();
	}); */
});

/* 
 *  方法:Array.remove(index) 
 *  功能:根据元素位置值删除数组元素. 
 *  参数:元素值 
 *  返回:在原数组上修改数组 
 */  
Array.prototype.remove = function (index) {
    if (isNaN(index) || index > this.length) {
        return false;
    }
    this.splice(index, 1);
};

Array.prototype.indexOf = function(Object){
	for(var i = 0; i<this.length; i++){
       if(this[i] === Object){
    	   return i;
       }
    }
    return -1;
};
/*
 * jquery ajax 封装函数
 */
var _ajax_seq = 0;
//异步访问ajax函数
function ajax(params) {
	var settings = {
			type : 'POST',
			dataType : 'text',
			error : _ajax_error
		};
	jQuery.extend(settings, params);
	var load = new loading();
	load.show();
	jQuery.ajax(settings);
}

function _ajax_error(data) {
	loadingClose();
	alertMsg(3, '访问失败');
}

//同步访问ajax函数
function synchroAjax(url, data, type){
	if(typeof(type) == 'undefined')
		type = 'text';
	var str = '';
	var load = new loading();
	load.show();
	jQuery.ajax({
		async : false,
		url : url,
		data : data,
		type : 'POST',
		dataType : type,
		success : function(text) {
			load.close();
			str = text;
		},
		error : function(){
			load.close();
			alertMsg(3, '访问失败');
		}
	});
	return str;
}


//同步访问ajax函数
function PublicAjax(url, data){
	var load = new loading();
	load.show();
	var str = '';
	jQuery.ajax({
		async : false,
		url : url,
		data : data,
		type : 'POST',
		dataType : 'json',
		success : function(text) {
			str = text;
			//alert(str);
		},
		error : function(){
			load.close();
			alert('访问失败');
		}
	});
	load.close();
	return str;
}

/*
 * 清除对象的value值
 */
function clearText(obj){
	obj.value = '';
}

function getSysBasePath(){
	return window.location.protocol + '//' + window.location.host + '/' + window.location.pathname.split('/')[1] + '/';
}

//---停止事件冒泡函数
function stopPropagation(e) {
	e = e || window.event;
	if (document.all) {
		e.cancelBubble = true;
	} else {
		e.stopPropagation();
	}
}

//选中tr函数
function selTr(tr){
	var checked = jQuery(tr).find('input[type=checkbox]:eq(0)').is(':checked');
	if(checked){
		jQuery(tr).find('input[type=checkbox]').attr('checked', false);
	} else {
		jQuery(tr).find('input[type=checkbox]').attr('checked', true);
	}
}

//----------------checkbox全选函数
function checkAll(obj){
	var checked = jQuery(obj).is(':checked');
	var chks = jQuery('input[name="chk"]');
	for(var i=0; i<chks.length; i++){
		jQuery(chks[i]).attr('checked', checked);
	}
}
/*根据type(提示框类型)【int型】；msg(提示信息)弹出系统提示框*/
/*type：
 *1：成功提示；
 *2：失败提示；
 *3：系统错误； 
 */
function loadingClose(){
	jQuery('#tab_sys_loading').remove();
	jQuery('#div_sys_loading').remove();
}

function loading() {
	var table = jQuery('<table/>').attr('id','tab_sys_loading').css({
		'position':'absolute',
		'width':'250px',
		'height':'150px',
		'top': (jQuery(window).height()-300)/2 + 'px',
		'left': (jQuery(window).width()-300)/2 + 'px',
		'background-color': '#FFFFFF',
		'z-index': '9991',
		'display': 'none',
		'border': '0px solid red'
	}).html('<tr><td align="center">'+'<img src="images/loading02.gif" border="0"><br>正在加载数据，请稍后...</td></tr>').appendTo('body');
	
	var div = jQuery('<div />').css({
		'position': 'absolute',
		'width': jQuery(window).width() + 'px',
		'height': jQuery(window).height() + 'px',
		'z-index': '9990',
		'top': '0px',
		'left': '0px',
		'opacity': '0.3',
		'background-color': '#0A0A0A',
		'display': 'none'
	}).attr('id','div_sys_loading').appendTo('body');
	
	this.show = function(){
		div.show();
		table.show();
	};
	
	this.close = function(){ // anyway remove it
		table.remove();
		div.remove();
	};

}

function alertMsg(type, msg, time){
	if(typeof(time) == 'undefined'){//如果找不到time，则默认为2秒
		time = 2000;
	}
	var title = '';
	var content = '';
	msg = '<span style="font-size: 14px">' + msg + '</span>';
	if(type==1){
		title="系统提示";
		content = '<table height="100%"><tr align="middle"><td width="60px"><img src="images/succeed.png" width="48" height="48" /></td><td align="left">'+msg+'</td></tr></table>';
	}else if(type==2){
		title="系统警示";
		content = '<table height="100%"><tr align="middle"><td width="60px"><img src="images/warning.png" width="48" height="48" /></td><td align="left">'+msg+'</td></tr></table>';
	}else if(type==3){
		title="错误提示";
		content = '<table height="100%"><tr align="middle"><td width="60px"><img src="images/error.png" width="48" height="48" /></td><td align="left">'+msg+'</td></tr></table>';
	}
	var d = new jQuery.msgbox({
		id: 'sys_alert_msg',
		type: 'alert',
		showMin: false,
		showHide: false,
		time: time,
		title: title,
		zIndex: 10011,
		content: content,
		width: 280,
		height: 120
	});
	d.show();
}

/*系统提示框：确定及取消*/
function confirmMsg(msg, fun){
	msg = '<span style="font-size: 14px">' + msg + '</span>';
	var content = '<table height="100%"><tr align="middle"><td width="60px"><img src="images/question.png" width="48" height="48" /></td><td align="left">'+msg+'</td></tr></table>';
	var id = new Date().getTime();
	var doFun = function(){
		fun();
		closeDialog(id);
	};
	var d = new jQuery.msgbox({
		id: id,
		type: 'confirm',
		lock: true,
		showMin: false,
		showHide: false,
		zIndex: 10011,
		title: '系统提示',
		content: content,
		width: 280,
		height: 120,
		btns: [{name: '确定', fun: doFun},{name: '取消',fun: function(){
				closeDialog(id);
			}}]
	});
	d.show();
}

/*
 * 提示框选择 是、否，分别执行不同函数
 * */
function chooseYesOrNo(msg, fun1, fun2){
	msg = '<span style="font-size: 14px">' + msg + '</span>';
	var content = '<table height="100%"><tr align="middle"><td width="60px"><img src="images/question.png" width="48" height="48" /></td><td>'+msg+'</td></tr></table>';
	var id = new Date().getTime();
	var yesFun = function(){
		fun1();
		closeDialog(id);
	};
	var noFun = function(){
		fun2();
		closeDialog(id);
	};
	var d = new jQuery.msgbox({
		id: id,
		type: 'confirm',
		lock: true,
		showMin: false,
		showHide: false,
		zIndex: 10011,
		title: '系统提示',
		content: content,
		width: 280,
		height: 120,
		btns: [{name: '是', fun: yesFun},{name: '否',fun: noFun}]
	});
	d.show();
}
/*
 * 光标停留在控件中文本数据的最后
 */
function setCaretAtEnd(field){  
    if(field.createTextRange){  
        var r =  field.createTextRange();
        r.moveStart('character',  field.value.length);  
        r.collapse();  
        r.select();  
    }
}

/**
 * dialog相关操作
 * 
 */
function openDialog(params) {
	var dialog = jQuery('#' + params.id);
	var bg = jQuery('#bg_' + params.id);
	if(dialog.length > 0){
		if(dialog.css('display') != 'table'){
			if(bg.length>0)
				bg.show();
			dialog.show().animate({
				top: '-=100px',
				left: '+=100px',
				opacity: 1
			}, 'normal');
			dialog.find('input[type="text"]:first').focus();
		}
	}else{
		var settings = {};
		if(typeof(params.type) == 'undefined'){
			settings = {type : 'confirm'};
		}
		jQuery.extend(settings, params);
		var d = new jQuery.msgbox(settings);
		d.show();
		d.mainWrap.find('input[type="text"]:first').focus();
		
	}
}

/**
 * 关闭dialoag窗口 
 * 
 */
function closeDialog(id){
	jQuery('#bg_' + id).remove();
	jQuery('#' + id).remove();
}

/**
 * 表单提交前的验证
 * @param form1  所提交表单的名称
 * @returns {Boolean}  返回值
 * dataType:String "字符串"
 *   int "整数型"
 *   number "实数型"
 *   email "电子邮箱型"
 *   tel "电话号码类型"
 *   mobile "手机号类型"
 * 
 * title：字段名称
 * 
 * want：是否允许为空；yes不允许--no允许
 * 
 */
function checkForm(form){
	var result = true;
	jQuery(form).find('input').each(function(){
		if(checkObj(this) == false){
			result = false;
			return result;
		}
	});
	jQuery(form).find('select').each(function(){
		if(checkObj(this) == false){
			result = false;
			return result;
		}
	});
	jQuery(form).find('textarea').each(function(){
		if(checkObj(this) == false){
			result = false;
			return result;
		}
	});
	
	if(!result){
	  alert("*号项必填！");
	}
	
	return result;
}

function checkObj(obj){
	var dataType = jQuery(obj).attr('dataType');
	var title = jQuery(obj).attr('title');
	var want = jQuery(obj).attr('want');
	var value = jQuery(obj).val();
	var res = true;
	if(value == null || value == ''){
		if(want == 'yes'){
			jQuery(obj).focus();
			//alert(title+"不得为空！",2000);
			res = false;
		}
	} else {
		if(dataType == 'int'){
			var checkNum = /^\d+$/;
			if(!checkNum.test(value)){//验证字符串是否全为数字
				jQuery(obj).focus();
				alert( title + " 只能输入数字！",2000);
				res = false;
			}
		}else if(dataType == 'number'){
			if(isNaN(value)){//验证字符串是否全为数字
				jQuery(obj).focus();
				alert(title+" 只能输入数字和小数点！",3000);
				res = false;
			}
		}else if(dataType == 'tel'){
			if( value.isTel() == false){
				jQuery(obj).focus();
				alert("请输入正确的 "+title+" 格式",2000);
				res = false;
			}
		}else if(dataType == 'mobile'){
			if( value.isMobile() == false){
				jQuery(obj).focus();
				alert("请输入正确的 "+title+" 格式",2000);
				res = false;
			}
		}else if(dataType == 'email'){
			var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}jQuery/;//email判断正则表达式
			if(!reg.test(value)){
				jQuery(obj).focus();
				alert("请输入正确的 "+title+" 格式",2000);
				res = false;
			}
		}else if(dataType == 'imgfile'){
			var reg = /\.(jpg|JPG|gif|GIF|jpeg|JPEG|png|PNG)jQuery/;//图片后缀正则表达式
			if(!reg.test(value)){
				jQuery(obj).focus();
				alert("请选择正确的图片文件:<br/> jpg,JPG,gif,GIF,jpeg,JPEG,png,PNG",2000);
				res = false;
			}
		}
	}
	return res;
}

/**
 * 全/反选
 * @param obj checkbox的对象
 * @param name checkbox的name值 ，name外需有引号
 * 
 */
function selectAll(obj,name){
	jQuery('input[name='+ name +']').attr('checked',obj.checked);
}

/***********************************************************已下为原有的js************************************************************/

/**
 * @param tbid
 *            清除表格的id
 */
function clearValue(tbid){
	var addinfo = document.getElementById(tbid).getElementsByTagName("input");
	var infolen = addinfo.length;
	for( var i = 0;i < infolen;i++){
		if(addinfo[i].type != "button"){
			addinfo[i].value = "";
		}
	}
}

/**
 * 通用分页执行函数
 * 
 * @param url
 *            执行的路径
 * @param page_num
 *            跳转的页码
 */
function gotoPage(url,page_num){
	if(url != null && url != ""){
		if(url.indexOf("?") > -1){
			url += "&"; // 如果url中已经包含了其他的参数,就把curPageNo参数接在后面
		}
		else{
			url += "?"; // 如果url中没有别的参数
		}
		location.href = url + "pageNo=" + page_num;
	}
}

/*
 *从访问路径中获得参数的值 
 */
function getUrlParam(url, paramName) {
	var bi = url.indexOf(paramName);
	if (bi != -1) {
		bi = url.indexOf("=", bi) + 1;
		var ei = url.indexOf("&", bi);
		if (ei != -1) {
			return url.substring(bi, ei); 			
		} else {
			return url.substring(bi, url.length);
		}
	}

	return null;
}
/*
 * 页面刷新函数
 */
function refresh(){
	window.location.reload();
}
/*
 * Cookie 操作函数
 */
function getCookie(c_name) {
	if (document.cookie.length > 0)
	{
		c_start = document.cookie.indexOf(c_name + "=");
		if (c_start != -1)
		{
			c_start = c_start + c_name.length + 1;
			c_end   = document.cookie.indexOf(";",c_start);
			if (c_end == -1)
			{
				c_end = document.cookie.length;
			}
			return unescape(document.cookie.substring(c_start,c_end));
		}
	}
	return null;
}

function setCookie(c_name,value,expiredays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + expiredays);
	document.cookie = c_name + "=" + escape(value) + ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString()); //使设置的有效时间正确。增加toGMTString()
}

/*
 * Map 函数
 * 可使用子函数及属性，可参照java中map对象
	this.get = get;    
	this.put = put;    
	this.remove = remove;    
	this.size = size;    
	this.isEmpty = isEmpty;    
	this.keys = keys;
	this.join = join;
 */ 
function Map() {    
	var struct = function(key, value) {    
	  this.key = key;    
	  this.value = value;    
	};
	
	var put = function(key, value){    
	  for (var i = 0; i < this.arr.length; i++) {    
	   if ( this.arr[i].key === key ) {    
	    this.arr[i].value = value;    
	    return;    
	    }    
	   }    
	   this.arr[this.arr.length] = new struct(key, value);    
	};    
	   
	var get = function(key) {    
	  for (var i = 0; i < this.arr.length; i++) {    
	   if ( this.arr[i].key === key ) {    
	     return this.arr[i].value;    
	    }    
	   }    
	  return null;    
	};   
	   
	var remove = function(key) {    
	  var v;    
	  var oldValue=null;
	  for (var i = 0; i < this.arr.length; i++) {    
		  v = this.arr.pop();    
		  if ( v.key === key ) {  
			  oldValue = v.value;
			  continue;    
		  }    
		  this.arr.unshift(v);    
	  }
	  return oldValue;
	};    
	   
	var size = function() {    
	  return this.arr.length;    
	};    
	   
	var isEmpty = function() {    
	  return this.arr.length <= 0;    
	}; 
	
	var keys = function() {
		var arr = new Array();
		for (var i = 0; i < this.arr.length; i++) {    
			arr.push(this.arr[i].key);    
		}
		return arr.join(',');
	};
	
	var join = function(sep) {
		var arr = new Array();
		for (var i = 0; i < this.arr.length; i++) {
			arr.push(this.arr[i].key);
			arr.push(this.arr[i].value);
		}
		return arr.join(sep);
	};
	   
	this.arr = new Array();    
	this.get = get;    
	this.put = put;    
	this.remove = remove;    
	this.size = size;    
	this.isEmpty = isEmpty;    
	this.keys = keys;
	this.join = join;
};
