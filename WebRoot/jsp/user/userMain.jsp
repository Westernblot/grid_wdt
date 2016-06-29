<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<link rel="stylesheet" href="${CONTEXT_PATH}/zTree/css/demo.css"
	type="text/css">
<link rel="stylesheet"
	href="${CONTEXT_PATH}/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="${CONTEXT_PATH}/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript"
	src="${CONTEXT_PATH}/zTree/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="${CONTEXT_PATH}/zTree/js/jquery.ztree.excheck-3.5.js"></script>
</head>
<script type="text/javascript">
	
var setting = {
		view : {
			dblClickExpand : false
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			beforeClick : beforeClick,
			onClick : onClick
		}
	};

	var zNodes = PublicAjax('${CONTEXT_PATH}/dept/deptJson');

	function beforeClick(treeId, treeNode) {
		var check = (treeNode && !treeNode.isParent);
		//if (!check) alert("只能选择城市...");
		//return check;
	}

	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		nodes = zTree.getSelectedNodes();
		var id = "";
		var name = "";
		//	nodes.sort(function compare(a,b){return a.id-b.id;});
		for (var i = 0, l = nodes.length; i < l; i++) {
			id += nodes[i].id + ",";
			name += nodes[i].name + ",";
		}
		if (id.length > 0)
			id = id.substring(0, id.length - 1);
		if (name.length > 0)
			name = name.substring(0, name.length - 1);

		$("#pid").attr('value', id);
		$("#pname").attr('value', name);

		hideMenu();
	}

	function showMenu() {
		var cityObj = $("#pname");
		var cityOffset = $("#pname").offset();
		$("#menuContent").css({
			left : cityOffset.left + "px",
			top : cityOffset.top + cityObj.outerHeight() + "px"
		}).slideDown("fast");

		$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(
				event.target).parents("#menuContent").length > 0)) {
			hideMenu();
		}
	}

	$(document).ready(function() {
		 $.fn.zTree.init($("#treeDemo"), setting, zNodes);
		//treeObj.expandAll(true); 
	});
	
	
	//重置密码
	function resetPwd() {
		var ids = getId('delete');
		if (ids == false) {
			return;
		}
		//alert(ids);
		if (confirm("确定重置吗？重置后密码为1")) {
			location.href="${CONTEXT_PATH}/user/resetPwd?ids="+ids;
		}

	}
	
	//删除数据
	function delData() {
		var ids = getId('delete');
		if (ids == false) {
			return;
		}
		//alert(ids);
		if (confirm("确定删除吗?")) {
			location.href="${CONTEXT_PATH}/user/delete?ids="+ids;
		}

	}
	
	//提交表单
	function doQuery(){
		$('#form1').submit();
	}
	
</script>
<body>
	<div id="container">
		<!--左边栏显示 -->
		<%@ include file="../common/left.jsp"%>

		<!-- 顶部显示 -->
		<%@ include file="../common/top.jsp"%>

		<div class="content">
			<ul class="breadcrumb">
				<li><a href="${CONTEXT_PATH}/index">首页</a><span class="divider">/</span></li>
				<li class="active">系统用户管理</li>
			</ul>

			<div class="container-fluid">
				<div class="row-fluid">

 <form id="form1" action="${CONTEXT_PATH}/user/" method="post">
					<div class="btn-toolbar">
						<a href="${CONTEXT_PATH}/user/userUI" class="btn btn-primary"> <img
							src="${CONTEXT_PATH}/images/icon/plus.png" /> 新增用户
						</a> <a class="btn" onclick="resetPwd()"> 重置密码 </a> <font color="red">提示：密码重置后全部为1</font>

						<a class="btn btn-danger pull-right" onclick="delData()">
							<img src="${CONTEXT_PATH}/images/icon/cross.png" /> 删除
						</a>
						
						
						部门：
		<input type="hidden" id="pid"  style="width: 120px;">
		<input type="text" id="pname" name="dept"  value="${dept}" /> 
		<a id="menuBtn" href="javascript:#" onclick="showMenu(); return false;">选择</a>
		&nbsp;
		 
					 姓名:
					 <input type="text" name="cnname" value="${cnname}">
						<a class="btn" onclick="doQuery()">
							<img src="${CONTEXT_PATH}/images/icon/cross.png" /> 查询
						</a>
						
						
						
						<div class="btn-group"></div>
					</div>
</form>
					<div class="block-tab">
						<table class="table-mins">
							<thead>
								<tr>
									<th><input type="checkbox" name="checkbox" id="checkbox"
										onclick="checkAll(this)"></th>
									<th>序号</th>
									<th>登录名</th>
									<th>中文名</th>
									<th>部门</th>
									<th>职位</th>
									<th>角色</th>
									<th colspan="2">操作</th>
								</tr>
							</thead>
							<tbody>
							
								<c:if test="${fn:length(page.list)==0}">
							<tr>
                              <td colspan="10">
                              <font color="red">查无数据</font>
                              </td>							
							</tr>
							</c:if>
							
								<c:forEach items="${page.list }" var="vo" varStatus="vs">
									<tr id="${vo.id}">
										<td><input type="checkbox" name="chk" id="chk"
											onclick="selTr(this);"></td>
										<td>${(page.pageNumber-1)*10+vs.index+1}</td>
										<td>${vo.username}</td>
										<td>${vo.cnname}</td>
										<td>${vo.dept}</td>
										<td>${vo.position}</td>
										<td><font color="red">${vo.role}</font></td>
										<td><a href="${CONTEXT_PATH}/user/userUI?id=${vo.id}" class="tick-circle">编辑</a></td>
										
									</tr>
								</c:forEach>

							</tbody>
							<tfoot>
								<tr>
									<td colspan="8" style="padding: 0;">
										<div class="block-foot">
											<ul class="pagination pagination_ml pull-right">

												<c:set var="actionUrl" value="${CONTEXT_PATH}/user/" />
												<c:set var="urlParas" value="${urlParas}" />
												<%@ include file="../common/pageBtm.jsp"%>


											</ul>
										</div>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>

				</div>
			</div>
		</div>
	</div>
	
	
	<div id="menuContent" class="menuContent"
		style="display: none; position: absolute;">
		<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 160px;"></ul>
	</div>
	
	
</body>
</html>