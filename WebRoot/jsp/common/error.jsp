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
<link rel="stylesheet" type="text/css"
	href="${CONTEXT_PATH}/css/common.css">
<script type="text/javascript" src="${CONTEXT_PATH}/js/jquery.min.js"></script>
<script type="text/javascript">
	var num = 1;
	$(function() {
		timer1 = setInterval("clock()", 1000);
	});

	function clock() {
		$('#sp').text(num--);
		if (num == 0) {
			location.href = "javascript:window.history.back(-1)";
		}
	}
</script>
</head>
<body style="overflow: auto;">
	<div class="http-error">
		<div class="error">
			<dl>
				<dt>
					<img src="${CONTEXT_PATH}/images/icon/error_500.jpg" />
				</dt>
				<dd>
					<p class="info">操作失败！</p>
					<p>
						页面自动 
						
						  <a href="javascript:window.history.back(-1)">跳转</a> 等待时间：<span id="sp">2</span>
						
						
					</p>
				</dd>
			</dl>
		</div>
	</div>
</body>
</html>