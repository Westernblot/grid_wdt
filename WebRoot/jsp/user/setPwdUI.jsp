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
<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/common.css">
<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/theme.css">
<script type="text/javascript">
	$(document).ready(function() {

	});

	function save(){
		
		var password = $('#password').val();
		var newPassword = $('#newPassword').val();
		
		if(password=="" || password!=newPassword){
			layer.msg("密码输入有误！");
			return;
		}
		
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
				<li><a href="${CONTEXT_PATH}/index">首页</a><span
					class="divider">/</span></li>
				<li class="active">修改密码</li>
			</ul>

			<div class="container-fluid">
				<div class="row-fluid">

					<div class="btn-toolbar"></div>
					<div class="well you-bg">

						<form id="form1" action="${CONTEXT_PATH}/user/setPwd"
							method="post">
							<input type="hidden" name="id" value="${mo.id}">
							<fieldset>
								<legend>
									<small>用户：${mo.username}</small>
								</legend>
								<table class="youAdd">
									<tr>
										<td class="TDleft"><label>新密码：</label></td>
										<td><input type="text" id="password" name="password" value=""
											><span class="text-star">*</span></td>
									</tr>
									<tr>
										<td class="TDleft"><label>重复新密码：</label></td>
										<td><input type="text" id="newPassword" name="repassword" value=""
											><span class="text-star">*</span></td>
									</tr>
									<tr>
										<td class="TDleft">&nbsp;</td>
										<td>
											<a class="btn btn-primary" onclick="save()">
												<img src="${CONTEXT_PATH}/images/icon/clipboard.png"
													class="clipboard" /> 保存
											</a>
										</td>
									</tr>
								</table>
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>

	</div>



</body>
</html>