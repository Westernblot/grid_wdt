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
	
	//清除
	function clear(){
		$('#pid').attr('value','');
		$('#pname').attr('value','');
	}

	//保存数据
	function save1() {
		$('#form1').submit();
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
				<li><a href="${CONTEXT_PATH}/user/">系统用户管理</a><span
					class="divider">/</span></li>
				<li class="active">新增用户</li>
			</ul>

			<div class="container-fluid">
				<div class="row-fluid">

					<div class="btn-toolbar">
						<a class="btn btn-primary" onclick="save1()"> <img
							src="${CONTEXT_PATH}/images/icon/clipboard.png" class="clipboard" />
							保存
						</a> <a href="javascript:history.back();" class="btn">返回</a>
					</div>
					<div class="well you-bg">


						<form id="form1"
							action="${CONTEXT_PATH}/${mo==null?'user/insert':'user/update'}"
							method="post">
							<c:if test="${mo!=null}">
								<input type="hidden" name="user.id" value="${mo.id}">
							</c:if>
							<font color="red">提示:初始登陆密码为1</font>
							<table class="youAdd" width="100%">
							<caption>
							 登录名：<input type="text" name="user.username" value="${mo.username}"
							 <c:if test="${mo!=null}">readOnly</c:if>
							  class="input-medium">
							是否启用： <select name="user.flag">							           
									    <option value="禁用" <c:if test="${mo.flag=='禁用'}">selected</c:if> >禁用</option>
									    <option value="启用" <c:if test="${mo.flag=='启用'}">selected</c:if> >启用</option>
									   </select>
						           角色： <select name="user.role">
						             <option value="" <c:if test="${mo.role=='禁用'}">selected</c:if> >-请选择-</option>
						             <c:forEach items="${roleList }" var="vo" varStatus="vs">
						              <option value="${vo.name }" <c:if test="${mo.role==vo.name}">selected</c:if> >${vo.name }</option>
						             </c:forEach>
						       </select>
						       
							</caption>
							   
								<tr>
									<td class="TDleft" width="140"><label>姓名：</label></td>
									<td><input type="text" name="user.cnname" value="${mo.cnname }" class="input-medium"></td>
									<td class="TDleft" width="140"><label>身份证号：</label></td>
									<td><input type="text" name="user.idcard" value="${mo.idcard }" class="input-medium"></td>
								</tr>
								<tr>
									<td class="TDleft"><label>出生年月：</label></td>
									<td><input type="text" name="user.birthday" value="${mo.birthday}"  class="Wdate"  onclick="WdatePicker()"></td>
									<td class="TDleft"><label>籍贯：</label></td>
									<td><input type="text" name="user.native_place" value="${mo.native_place}" class="input-small"></td>
								</tr>
								<tr>
									<td class="TDleft"><label>性别：</label></td>
									<td><label><input name="user.sex" type="radio" value="男" <c:if test="${mo.sex=='男'}">checked</c:if>  > 男</label>
									 <label><input name="user.sex" type="radio" value="女" <c:if test="${mo.sex=='女'}">checked</c:if> > 女</label></td>
									<td class="TDleft"><label>婚否：</label></td>
									<td><label><input name="user.marry" type="radio" value="未婚" <c:if test="${mo.marry=='未婚'}">checked</c:if> > 未婚</label>
									 <label><input name="user.marry" type="radio" value="已婚" <c:if test="${mo.marry=='已婚'}">checked</c:if> > 已婚</label></td>
								</tr>
								<tr>
									<td class="TDleft"><label>学历：</label></td>
									<td><select class="input-medium" name="user.education">
											<option value="" <c:if test="${mo.education==''}">selected</c:if> >-请选择-</option>
											<option value="硕士" <c:if test="${mo.education=='硕士'}">selected</c:if> >硕士</option>
											<option value="学士" <c:if test="${mo.education=='学士'}">selected</c:if> >学士</option>
											<option value="本科" <c:if test="${mo.education=='本科'}">selected</c:if> >本科</option>
											<option value="专科" <c:if test="${mo.education=='专科'}">selected</c:if> >专科</option>
											<option value="高职高专" <c:if test="${mo.education=='高职高专'}">selected</c:if> >高职高专</option>
											<option value="高中" <c:if test="${mo.education=='高中'}">selected</c:if> >高中</option>
											<option value="初中" <c:if test="${mo.education=='初中'}">selected</c:if> >初中</option>
											<option value="小学" <c:if test="${mo.education=='小学'}">selected</c:if> >小学</option>
									</select></td>
									<td class="TDleft"><label>联系电话：</label></td>
									<td><input type="text" name="user.phone" value="${mo.phone }" class="input-medium"></td>
								</tr>
								<tr>
									<td class="TDleft"><label>紧急联系人：</label></td>
									<td><input type="text" name="user.emergency_man" value="${mo.emergency_man }" class="input-medium"></td>
									<td class="TDleft"><label>家庭住址：</label></td>
									<td><input type="text" name="user.address" value="${mo.address}"
										class="input-xlarge"></td>
								</tr>
								<tr>
									<td class="TDleft"><label>紧急联系人电话：</label></td>
									<td><input type="text" name="user.emergency_tel" value="${mo.emergency_tel }" class="input-medium"></td>
									<td class="TDleft"><label>银行账号：</label></td>
									<td><input type="text" name="user.bank_account" value="${mo.bank_account }" class="input-xlarge">
									</td>
								</tr>
								<!-- <tr>
									<td class="TDleft"><label>影像资料：</label></td>
									<td colspan="3"><input name="" type="file"></td>
								</tr> -->
							</table>
							<hr />
							<table class="youAdd" width="80%">
								<tr>
									<td class="TDleft" width="140"><label>社保号：</label></td>
									<td><input type="text" name="user.social_no" value="${mo.social_no }" class="input-medium"></td>
									<td class="TDleft" width="140"><label>医保号：</label></td>
									<td><input type="text" name="user.medicate_no" value="${mo.medicate_no }" class="input-medium"></td>
								</tr>
								<tr>
									<td class="TDleft"><label>职员代码：</label></td>
									<td><input type="text" name="user.code" value="${mo.code }" class="input-medium"></td>
									<td class="TDleft"><label>入职时间：</label></td>
									<td><input type="text" name="user.entry_date" value="${mo.entry_date }"
										class="Wdate"  onclick="WdatePicker()"></td>
								</tr>
								<tr>
									<td class="TDleft"><label>基本工资：</label></td>
									<td><input type="text" name="user.basic_wage" value="${mo.basic_wage }"
										class="input-amount input-medium"></td>
									<td class="TDleft"><label>在岗状态：</label></td>
									<td><select class="input-medium" name="user.status">
											<option value="在职" <c:if test="${mo.status=='在职'}">selected</c:if> >在职</option>
											<option value="离职" <c:if test="${mo.status=='离职'}">selected</c:if> >离职</option>
									    </select>
									</td>
								</tr>
								<tr>
									<td class="TDleft"><label>部门：</label></td>
									<td>
									
		<input type="hidden" id="pid" name="pid" value="" style="width: 120px;">
		<input type="text" id="pname" name="user.dept"  value="${mo.dept}" readonly /> 
		<a id="menuBtn" href="javascript:#" onclick="showMenu(); return false;">选择</a>
		&nbsp;
		<a href="javascript:clear()">清除</a>
		
									</td>
									<td class="TDleft"><label>职员类别：</label></td>
									<td>
									<input type="text" name="user.position" name="${mo.position }" >
									</td>
								</tr>
								<tr>
									<td class="TDleft"><label>就业合同编号：</label></td>
									<td><input type="text" name="user.employee_no" value="${mo.employee_no }" class="input-large"></td>
									<td class="TDleft"><label>合同签订时间：</label></td>
									<td><input type="text" name="user.employee_date" value="${mo.employee_date }"
										 class="Wdate"  onclick="WdatePicker()" ></td>
								</tr>
								<tr>
									<td class="TDleft"><label>合同年限：</label></td>
									<td>
									<input type="text" name="user.employee_long" value="${mo.employee_long }" />
									</td>
									<td class="TDleft"><label>到期时间：</label></td>
									<td><input type="text" name="user.employee_end" value="${mo.employee_end }"
										 class="Wdate"  onclick="WdatePicker()" ></td>
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