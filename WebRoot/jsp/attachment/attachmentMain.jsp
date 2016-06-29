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

</head>
<script type="text/javascript">
	
	
	//删除数据
	function delData() {
		var ids = getId('delete');
		if (ids == false) {
			return;
		}
		//alert(ids);
		if (confirm("确定删除吗?")) {
			location.href="${CONTEXT_PATH}/attachment/delete?ids="+ids;
		}

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
				<li class="active">附件演示</li>
			</ul>

			<div class="container-fluid">
				<div class="row-fluid">

					<div class="btn-toolbar">
						<a href="${CONTEXT_PATH}/attachment/attachmentUI" class="btn btn-primary"> <img
							src="${CONTEXT_PATH}/images/icon/plus.png" /> 新增
						</a> 

						<button class="btn btn-danger pull-right" onclick="delData()">
							<img src="${CONTEXT_PATH}/images/icon/cross.png" /> 删除
						</button>
						<div class="btn-group"></div>
					</div>
					<div class="block-tab">
						<table class="table-mins">
							<thead>
								<tr>
									<th><input type="checkbox" name="checkbox" id="checkbox"
										onclick="checkAll(this)"></th>
									<th>序号</th>
									<th>标题</th>
									<th>附件</th>
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
										<td>${vo.title}</td>										
										<td>${vo.attachment}</td>										
										<td><a href="${CONTEXT_PATH}/attachment/attachmentUI?id=${vo.id}" class="tick-circle">编辑</a></td>										
									</tr>
								</c:forEach>

							</tbody>
							<tfoot>
								<tr>
									<td colspan="8" style="padding: 0;">
										<div class="block-foot">
											<ul class="pagination pagination_ml pull-right">

												<c:set var="actionUrl" value="${CONTEXT_PATH}/attachment/" />
												<c:set var="urlParas" value="" />
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
</body>
</html>