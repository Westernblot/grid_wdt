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
		<jsp:include page="../include.jsp"></jsp:include>
   		<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/common.css">
    	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/theme.css">
    	<script type="text/javascript" src="${CONTEXT_PATH}/js/placeholder.js"></script>
    	<script type="text/javascript" src="${CONTEXT_PATH}/js/DatePicker/WdatePicker.js"></script>
	</head>
<script type="text/javascript">
	//提交表单
	function doQuery(){
		$('#form1').submit();
	}
	//删除数据
	function delData() {
		var ids = getId('delete');
		if (ids == false) {
			return;
		}
		//alert(ids);
		if (confirm("确定删除吗?")) {
			location.href="${CONTEXT_PATH}/contract/delete?ids="+ids;
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
            <li><a href="../index.html">首页</a> <span class="divider">/</span></li>
            <li class="active">合同管理</li>
        </ul>
        <div class="container-fluid">
                    
<div class="btn-toolbar">
 <span class="pull-right">
    	<button class="btn btn-danger" onclick="delData()" >删除</button>
    </span>
<form action="${CONTEXT_PATH}/vacate/" id="form1" method="post">　
    	<a class="btn btn-success" href="${CONTEXT_PATH}/contract/contractUI"><img src="${CONTEXT_PATH}/images/icon/plus.png"/> 新 增</a>
    	　
	        <input type="text" name="name" value="${name}" placeholder="合同名称/合同编号" class="input-medium">
	        
	       <input type="text" id="d4311" name="begintime" value="${begintime}"  class="input-medium Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'d4312\')}'})">
	                    至
	       <input type="text" id="d4312" name="endtime" value="${endtime}"  class="input-medium Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'d4311\')}'})">
             
        <button class="btn" type="button" onclick="doQuery()">查询</button>
    </form>   
</div>

            <!--列表开始-->
            <div class="block-tab">
            <table class="table-mins">
                  <thead>	
                    <tr>
                     <th width="20"><input type="checkbox" name="checkbox" id="checkbox"
										onclick="checkAll(this)"></th>
                       <th width="120">合同编号</th>
                        <th>合同名称</th>
                        <th width="120">合同签订时间</th>
                        <th width="120">合同截止时间</th>
                        <th width="120">合同金额</th>
                        <th>合同计价内容</th>
                        <th width="120">单价</th>
                        <th colspan="2">操作</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:if test="${fn:length(page.list)==0}">
						<tr>
		                    <td colspan="9">
		                      <font color="red">查无数据</font>
		                    </td>							
						</tr>
					</c:if>
				<c:forEach items="${page.list}" var="vo" varStatus="vs">
                    <tr id="${vo.id}">
                     <td><input type="checkbox" name="chk" id="chk" onclick="selTr(this);"></td>
                      <td>${vo.number}</td>
                      <td>${vo.name}&nbsp;</td>
                      <td>${vo.signdate}</td>
                      <td>${vo.enddate}</td>
                      <td>${vo.sum}</td>
                      <td>${vo.content}</td>
                      <td>${vo.price}</td>
                      <td><a href="${CONTEXT_PATH}/contract/contractUI?id=${vo.id}" class="tick-circle">编辑</a></td>
                    </tr>
                  </c:forEach>
                  </tbody>
                   <tfoot>
					<tr>
						<td colspan="9" style="padding: 0;">
							<div class="block-foot">
								<ul class="pagination pagination_ml pull-right">
									<c:set var="actionUrl" value="${CONTEXT_PATH}/vacate/" />
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
<!--主体结束--> 
</div> 
</body>
</html>

