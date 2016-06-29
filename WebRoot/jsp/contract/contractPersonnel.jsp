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
		<title>合同管理</title>
   		<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/common.css">
    	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/theme.css">
    	<script type="text/javascript" src="${CONTEXT_PATH}/zTree/js/jquery-1.4.4.min.js"></script>
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




//==========================动态表格添加/删除==================================
function addLine(){
//	alert($("tr").length);
	var len=$("tr").length;
	var tr=$("tr").eq(len-1);
	var trHtml= "<tr>";
		trHtml+="<td>"+len+"</td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\"${mo.daynum}\"  class=\"input-medium\" readonly></td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\"${mo.daynum}\"  class=\"input-medium\" readonly></td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\"${mo.daynum}\"  class=\"input-medium\" readonly></td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\"${mo.daynum}\"  class=\"input-medium\" readonly></td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\"${mo.daynum}\"  class=\"input-medium\" readonly></td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\"${mo.daynum}\"  class=\"input-medium\"></td>";
		trHtml+="<td><a href=\"javascript:#\" onclick=\"delLine(this)\" class=\"btn btn-danger\">删除一行</a></td>";
		trHtml+="</tr>";
		//alert(trHtml);
	$(tr).after(trHtml);
}

function delLine(obj){
	var tr = $(obj).parent().parent();
	$(tr).remove();
	var len=$("tr").length;
	for(var i=0;i<len;i++){
		$("tr").eq(i).find("td").eq(0).html(i);
	}
}
//===============================================================================
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
            <li><a href="../index.html">首页</a> <span class="divider">/</span></li>
            <li class="active">合同管理</li>
        </ul>

        <div class="container-fluid">
  
  <div class="tabmenu">
    <ul class="tab-title">
      	 <li><a href="${CONTEXT_PATH}/contract/contractUI">合同基础信息录入</a></li>
         <li><a href="${CONTEXT_PATH}/contract/contractDepartment">部门分配</a></li>
         <li  class="active"><a href="${CONTEXT_PATH}/contract/contractPersonnel">人员分配</a></li>
         <li><a href="${CONTEXT_PATH}/contract/celfareDistribution">福利分配</a></li>
    </ul>
    <div class="tab-main">
        <div class="blocklabel">
              <label><span>部门：</span><input type="text" id="fPname" value="" class="input-medium"><button class="btn btn-link" href="budgetAdd.html" onclick="getDept()">选择部门</button>　</label>
              <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
						 <ul id="treeDemo" class="ztree" style="margin-top:0; width:180px;height:400px;overflow-y:auto;overflow-x:hidden;"></ul>
					</div>
              <label><span>职员代码：</span><input type="text" value="" id="clerkCode" class="input-medium"></label>
              <label><span>身份证号：</span><input type="text" value="" id="idCard" class="input-medium"></label>
              <input type="hidden" id="userid" value="" class="input-medium">
               <label><span>姓名：</span><input type="text" id="userName" value="" class="input-medium"><button class="btn btn-link" href="budgetAdd.html" onclick="getUser()">选择姓名</button></label>
              <div id="menuName" class="menuContent" style="display:none; position: absolute;">
						 <ul id="treeName" class="ztree" style="margin-top:0; width:150px;height:400px;overflow-y:auto;overflow-x:hidden;"></ul>
					</div>
              <label><span>职员类别：</span><input type="text" id="position" value="" class="input-medium"></label>
             <label><span>分配金额：</span><input type="text" value="" class="input-medium"></label>
           <button class="btn btn-primary" onclick="addLine()"><img src="../images/icon/clipboard.png" class="clipboard"/> 添 加</button>
        </div>

            <!--列表开始-->
            <div class="block-tab">
            <table class="table-mins">
                  <thead>	
                    <tr>
                      <th>序号</th>
                      <th>职员代码</th>
                      <th>姓名</th>
                      <th>身份证号</th>
                      <th>所属部门</th>
          			  <th>职员类别</th>
                      <th>预算分配金额（万）</th>
                      <th>操作</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-medium" readonly></td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-medium" readonly></td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-medium" readonly></td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-medium" readonly></td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-medium" readonly></td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-medium" ></td>
                       <td>	<a href="javascript:#" onclick="delLine(this)" class="btn btn-danger">删除一行</a></td>
                    </tr>
                  </tbody>
                </table>
            </div>
           
    <div class="btn-youAdd">
        <button class="btn btn-danger" onclick="save()"><img src="${CONTEXT_PATH}/images/icon/clipboard.png" class="clipboard"/> 提 交</button>
    </div>
      </div>

</div> 


        </div>
    </div> 
<!--主体结束--> 
</div> 
</body>
</html>
