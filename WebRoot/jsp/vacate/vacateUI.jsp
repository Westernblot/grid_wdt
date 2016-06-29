<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>请假</title>
   		<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/common.css">
    	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/theme.css">
    	<script type="text/javascript" src="${CONTEXT_PATH}/js/jquery.js"></script>
    	<script type="text/javascript" src="${CONTEXT_PATH}/js/DatePicker/WdatePicker.js"></script>
    	<script type="text/javascript" src="${CONTEXT_PATH}/js/placeholder.js"></script>
    	<script type="text/javascript" src="${CONTEXT_PATH}/js/systemUtils.js"></script>
    	<%--=================================z-tree 相关======================================================== --%>
		<link rel="stylesheet" href="${CONTEXT_PATH}/js/zTree/css/demo.css" type="text/css">
		<link rel="stylesheet" href="${CONTEXT_PATH}/js/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${CONTEXT_PATH}/js/zTree/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="${CONTEXT_PATH}/js/zTree/js/jquery.ztree.excheck-3.5.js"></script>
		<script type="text/javascript" src="${CONTEXT_PATH}/js/showZTree.js"></script>
	</head>
<script type="text/javascript">
var zNodes=PublicAjax('${CONTEXT_PATH}/dept/deptJson');


/**
 * 获得姓名
 */
 
function getUser(){
	var dept=$("#fPname").val();
	if(dept==""){
		alert("请先选择部门");
		$("#deptBut").focus();
	}else{
		var userList=PublicAjax('${CONTEXT_PATH}/user/findUserByDept',{'dept':dept});
		if(userList.length==0){
			alert("该部门没有人员");
			return;
		}
		userL=userList;
		var str="[";
		for(var i=0;i<userList.length;i++){
			str +="{ id:"+userList[i].id.toString()+",pId:0,name:\""+userList[i].username+"\"},";
		}
		str=str.substring(0,str.length-1)+"]";
		var json=eval(str); 
		var treeName=$.fn.zTree.init($("#treeName"), settingName, json);
		treeName.expandAll(true); 
		var cityObj = $("#userName");
		var cityOffset = $("#userName").offset();
		$("#menuName").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDownName);
	}
}




//保存数据
function save1() {
	$('#form1').submit();
}

</script>	
	
<body>

<div id="container">
    <!--左边栏显示 -->
		<%@ include file="../common/left.jsp"%>
		
   <!-- 顶部显示 -->
		<%@ include file="../common/top.jsp"%>
<!--主体开始-->  
  <div class="content">
        <ul class="breadcrumb">
            <li><a href="${CONTEXT_PATH}/index">首页</a> <span class="divider">/</span></li>
            <li><a href="${CONTEXT_PATH}/vacate/">假期管理</a> <span class="divider">/</span></li>
            <li class="active">请假</li>
        </ul>

        <div class="container-fluid" style="text-align:center;">

<div class="well you-bg">    
	<h1 class="h1-title">请假</h1> 
	<form id="form1" action="${CONTEXT_PATH}/${mo==null?'vacate/insert':'vacate/update'}"  method="post">
        <table class="youAdd">
            <tr>
                <td class="TDleft"><label>部　　门：</label></td>
                <td colspan="3">
                	<input type="hidden" id="fPid" value="" class="input-medium">
                	<input type="text" id="fPname" name="vacate.dept" value="${mo.dept}" class="input-medium">
                	<input type="button" id="deptBut" value="选择部门" class="btn btn-link" onclick="getDept()">　
                  	<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
						 <ul id="treeDemo" class="ztree" style="margin-top:0; width:180px;height:400px;overflow-y:auto;overflow-x:hidden;"></ul>
					</div>
				</td>	
           </tr>
            <tr>
                <td class="TDleft"><label>姓　　名：</label></td>
                <td>
                	<input type="hidden" id="userid" value="" class="input-medium">
                	<input type="text" id="userName" name="vacate.name" value="${mo.name}" class="input-medium">
                	<input type="button" value="选择姓名" class="btn btn-link" onclick="getUser()">
                	<div id="menuName" class="menuContent" style="display:none; position: absolute;">
						 <ul id="treeName" class="ztree" style="margin-top:0; width:150px;height:400px;overflow-y:auto;overflow-x:hidden;"></ul>
					</div>
                </td>
                <td class="TDleft"><label>职员类别：</label></td>
                <td><input type="text" id="position" name="vacate.clerkclass" value="${mo.clerkclass}" class="input-medium"></td>
            </tr>
            <tr>
                <td class="TDleft"><label>职员代码：</label></td>
                <td><input type="text" id="clerkCode" name="vacate.clerkcode" value="${mo.clerkcode}" class="input-medium"></td>
                <td class="TDleft"><label>身份证号：</label></td>
                <td><input type="text" id="idCard" name="vacate.idcard" value="${mo.idcard}" class="input-medium"></td>
            </tr>
            <tr>
                <td class="TDleft"><label>请假时间：</label></td>
                <td colspan="3">
                	<input type="text" id="d4311" name="vacate.begintime" value="${mo.begintime}"  class="input-medium Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'d4312\')}'})">
                    至
                	<input type="text" id="d4312" name="vacate.endtime" value="${mo.endtime}"  class="input-medium Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'d4311\')}'})">
                
                </td>
           </tr>
            <tr>
                <td class="TDleft"><label>合计请假天数：</label></td>
                <td colspan="3">
                	<input type="text" name="vacate.daynum" value="${mo.daynum}" placeholder="0.0" class="input-medium">
                
                </td>
           </tr>
            <tr>
                <td class="TDleft"><label>备　　注：</label></td>
                <td colspan="3">
            	<textarea rows="4" name="vacate.remark" value="${mo.remark}" style="width:98%;"></textarea></td>
           </tr>
       </table>
     <div class="btn-youAdd">
        <button class="btn btn-danger" onclick="save()"><img src="${CONTEXT_PATH}/images/icon/clipboard.png" class="clipboard"/> 提 交</button>
    </div>
</div>

        </div>
    </div>
    
    
<!--主体结束--> 
</div> 
</body>
</html>
