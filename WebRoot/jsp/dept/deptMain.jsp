<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>...</title>
<jsp:include page="../include.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/common.css">
<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/theme.css">
<%--=================================z-tree 相关======================================================== --%>
 <link rel="stylesheet" href="${CONTEXT_PATH}/zTree/css/demo.css" type="text/css">
 <link rel="stylesheet" href="${CONTEXT_PATH}/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
 <script type="text/javascript" src="${CONTEXT_PATH}/zTree/js/jquery-1.4.4.min.js"></script>
 <script type="text/javascript" src="${CONTEXT_PATH}/zTree/js/jquery.ztree.core-3.5.js"></script>
 <script type="text/javascript" src="${CONTEXT_PATH}/zTree/js/jquery.ztree.excheck-3.5.js"></script>

</head>
<script type="text/javascript">

var setting = {
		check: {
			enable: true
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};

	var zNodes = PublicAjax('${CONTEXT_PATH}/dept/deptJson');
	 
	$(document).ready(function(){
		setting.check.chkboxType = { "Y" : "", "N" : "" };//设置 无关联
		$.fn.zTree.init($("#tree"), setting, zNodes);
	});
	
	
	//------------------------分隔线--------------------------------
	  
	  //修改部门
	  function editDept(){
		  var treeObj=$.fn.zTree.getZTreeObj("tree");
        nodes=treeObj.getCheckedNodes(true);
        
        if(nodes.length!=1){
      	  alert("请选择一个项进行操作！");
      	  return;
        }
        
        var id="";
        for(var i=0;i<nodes.length;i++){
      	  id=nodes[i].id;
        }
       
       location.href="${CONTEXT_PATH}/dept/deptUI?id="+id;
	  }
	  
	  //删除部门
	  function delDept(){
			  var treeObj=$.fn.zTree.getZTreeObj("tree");
	          nodes=treeObj.getCheckedNodes(true);
	          
	          if(nodes.length==0){
	        	  alert("请选择操作项！");
	        	  return;
	          }
	          
		  if(confirm("确认删除吗？若该部门存在子部门，则一并删除!")){

	          var ids="";
	          for(var i=0;i<nodes.length;i++){
	        	  if(ids==""){
	        		  ids=nodes[i].id;
	        	  }else{
	        		  ids+=","+nodes[i].id;
	        	  }
	          }
	
	          location.href="${CONTEXT_PATH}/dept/delete?ids="+ids;
		  }
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
            <li><a href="${CONTEXT_PATH }/index">首页</a> <span class="divider">/</span></li>
            <li class="active">部门管理</li>
        </ul>
        <div class="container-fluid">
              <div class="btn-toolbar">
                  <a href="${CONTEXT_PATH}/dept/deptUI"  class="btn btn-success"><img src="${CONTEXT_PATH }/images/icon/plus.png"/> 新增</a> 　
                  <a href="javascript:editDept()"  class="btn btn-warning"><img src="${CONTEXT_PATH }/images/icon/clipboard.png"/> 修改</a> 　
                  <a href="javascript:delDept()" class="btn btn-danger"><img src="${CONTEXT_PATH }/images/icon/cross.png"/> 删除</a> 
              </div>
              <div id="zhongxin">
                  <ul id="tree" class="ztree" style="overflow:auto; width: 80%;">
                      
                  </ul>
              </div>	

		</div>
    </div> 
<!--主体结束--> 
		
		
	</div>
</body>
</html>