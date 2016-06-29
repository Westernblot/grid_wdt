<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<jsp:include page="../include.jsp"></jsp:include>
<link rel="stylesheet" type="text/css"
	href="${CONTEXT_PATH}/css/common.css">
<link rel="stylesheet" type="text/css"
	href="${CONTEXT_PATH}/css/theme.css">

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
	
	
	//========分隔线=======
	function save(){
		$('#form1').submit();
	}
	
	//清除
	function clear(){
		$('#pid').attr('value','');
		$('#pname').attr('value','');
	}
		
</script>

</head>
<body style="overflow: auto;">
	<div id="container">
		<!--左边栏显示 -->
		<%@ include file="../common/left.jsp"%>

		<!-- 顶部显示 -->
		<%@ include file="../common/top.jsp"%>


		<div class="content">

			<ul class="breadcrumb">
				<li><a href="${CONTEXT_PATH}/index">首页</a><span class="divider">/</span></li>
				<li><a href="${CONTEXT_PATH}/dept/">部门管理</a><span
					class="divider">/</span></li>
				<li class="active">新增部门</li>
			</ul>

			<div class="container-fluid">
				<div class="row-fluid">

					<div class="btn-toolbar">
						<a class="btn btn-primary" onclick="save()"> <img
							src="${CONTEXT_PATH}/images/icon/clipboard.png" class="clipboard" />
							保存
						</a> <a href="javascript:history.back();" class="btn">返回</a>
					</div>
					<div class="well you-bg">


						<form id="form1"
							action="${CONTEXT_PATH}/${mo==null?'dept/insert':'dept/update'}"
							method="post">
							<c:if test="${mo!=null}">
								<input type="hidden" name="dept.id" value="${mo.id}">
							</c:if>

							<table class="youAdd">
								<tr>
									<td class="TDleft">上级部门：</td>
									<td>
		<input type="hidden" id="pid" name="dept.pid" value="${mo.pid==null?'0':mo.pid }" style="width: 120px;">
		<input type="text" id="pname" readonly value="${pname}" /> 
		<a id="menuBtn" href="javascript:#" onclick="showMenu(); return false;">选择</a>
		&nbsp;
		<a href="javascript:clear()">清除</a>

									</td>
								</tr>
								<tr>
									<td class="TDleft">部门名称：</td>
									<td><input type="text" name="dept.name" value="${mo.name}">
									</td>
								</tr>
								<tr>
									<td class="TDleft">排序号：</td>
									<td><input type="text" name="dept.sort" value="${mo.sort}">
									</td>
								</tr>

							</table>

						</form>
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