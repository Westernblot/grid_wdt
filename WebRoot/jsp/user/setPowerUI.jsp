<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>配置用户权限</title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="${CONTEXT_PATH}/css/default.css" rel="stylesheet" type="text/css" />
<link href="${CONTEXT_PATH}/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>

</head>
<script type="text/javascript">


    function selectAll(checkedValue){
	   $("input[type=checkbox]").attr("checked", checkedValue);
    }

	function doChecked( liID, checkedValue ){
		// 当前点击的checkbox元素所在的li元素
		var jLi = $("#" + liID);

		// 选中所有的直属下级。（children()方法是筛选下一级，find()是筛选所有后代）
		jLi.children("ul").find("input[type=checkbox]").attr("checked", checkedValue);
		
		// 选中或取消选中直属上级
		if( checkedValue ){ // checkedValue是boolean型，表示是否选中了当前复选框
			// 如果当前是选中，则选中所有的直属上级
			jLi.parents("li").children("input[type=checkbox]").attr("checked", checkedValue);
		}else{
			// 如果当前是取消选中，并且同级中没有被选中的项，则也取消上级的选中状态
			var jCheckedSibingCB = jLi.siblings("li").children("input[type=checkbox]:checked");
			if(jCheckedSibingCB.size() == 0){
				var jCheckboxInput = jLi.parent("ul").prev("label").prev("input[type=checkbox]");
				jCheckboxInput.attr("checked", checkedValue);
				
				// 递归操作每一层直属上级
				var jParentLi = jCheckboxInput.parent("li");
				if(jParentLi.size() > 0){
					doChecked(jParentLi.attr("id"), checkedValue);
				}
			}
		}
	} 
	
function doSave(){
	
	var data=PublicAjax('${CONTEXT_PATH}/user/update',$('#form1').serialize());
	if(data>0){
		layer.msg('操作成功,3秒后跳转', function(){
		     //do something
            location.href='${CONTEXT_PATH}/user/';
		}); 
	}
}

function doShow(obj){
	var ul=$(obj).parent().find('#ul_1');
	var style=$(ul).attr('style');
	if(style=='display:none'){
		$(obj).text("-");
		$(ul).attr('style','display:block');
	}else{
		$(obj).text("+");
	    $(ul).attr('style','display:none');
	}
}


</script>
 <style>
	ul.permissions li{color: #D95200;padding:5px 10px; margin:8px 0;border: 1px solid #CCCCCC;border-top: 3px solid #CCCCCC;}
 	ul#ul_1{ display:block; margin-top:8px;}
 	ul#ul_1 li{ display:inline-block; height:30px; padding:0 25px 0 5px; margin:0;color: #000;border:0;}
 </style>
<body>
<div id="div_right">
	<div class="right_top">
					<span> 配置用户权限</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
					
				</div>


<form action="" id="form1" >
<input type="hidden" name="user.id" value="${user.id}">
<input type="hidden" name="user.power" value="0">
<table border="0" style=" width:850px; margin-left: 60px;">
      <thead>
						<tr>
							<td style=" text-align:center;">
								<h4>正在为  ${user.cnname} 设置权限</h4>
							</td>
						</tr>
						<tr>
							<td style=" text-align:left; background-color:#EEE; padding:3px 10px;">
								<input type="checkbox" id="cbSelectAll" onClick="selectAll(this.checked)"/>
								<label for="cbSelectAll">全选</label>
							</td>
						</tr>
	 </thead>

<tr>
<td style=" text-align:left;white-space:normal; padding:3px 10px;">
<ul class="permissions">
    <c:forEach items="${baseMenuList }" var="base">
    <li id="li_${base.id }">
    <input type="checkbox" id="cb_${base.id}" name="user.power" value="${base.id}" onclick='doChecked("li_${base.id}", this.checked)' <c:forEach items="${user.power.split(',') }" var="ac"><c:if test="${ac==base.id}">checked</c:if></c:forEach> >
      <label for="cb_${base.id}">${base.name}</label>
         <ul id="ul_1">
         <c:forEach items="${subMenuList}" var="sub"><c:if test="${base.id==sub.pid }">
         <li id="li_${sub.id}">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="cb_${sub.id}" name="user.power" value="${sub.id}" onclick='doChecked("li_${sub.id}", this.checked)' <c:forEach items="${user.power.split(',') }" var="ac"><c:if test="${ac==sub.id}">checked</c:if></c:forEach> >
         <label for='cb_${sub.id}'>${sub.name}</label></li>
         </c:if></c:forEach>
         </ul>
      </li>
    </c:forEach>
</ul>

</td>
</tr>
</table>
</form>

</div>

</body>
</html>