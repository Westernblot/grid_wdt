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
    	<script type="text/javascript" src="${CONTEXT_PATH}/js/DatePicker/WdatePicker.js"></script>
    	<script type="text/javascript" src="${CONTEXT_PATH}/zTree/js/jquery-1.4.4.min.js"></script>
	</head>
<script type="text/javascript">
//==========================动态表格添加/删除==================================
function addLine(obj){
	var tr=$(obj).parent().parent();
	var trHtml='<tr>'+$(tr).html()+'</tr>';
	$(tr).after(trHtml);
}

function delLine(obj){
	var tr = $(obj).parent().parent();
	$(tr).remove();
}
//===============================================================================
function save(){
	$("#form1").submit();
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
            <div class="tabmenu">
                <ul class="tab-title">
                  <li class="active"><a href="${CONTEXT_PATH}/contract/contractUI">合同基础信息录入</a></li>
                  <li><a href="${CONTEXT_PATH}/contract/contractDepartment">部门分配</a></li>
                  <li><a href="${CONTEXT_PATH}/contract/contractPersonnel">人员分配</a></li>
                  <li><a href="${CONTEXT_PATH}/contract/celfareDistribution">福利分配</a></li>
                </ul>
            	<div class="tab-main">
    
    <div class="well you-bg">    
	<h1 class="h1-title">合同基础信息录入</h1> 
	<form id="form1" action="${CONTEXT_PATH}/${mo==null?'contract/insert':'contract/update'}"  method="post">
        <table class="youAdd">
       						<c:if test="${mo!=null}">
								<input type="hidden" name="dept.id" value="${mo.id}">
							</c:if>
            <tr>
                <td class="TDleft"><label>合同编号：</label></td>
                <td colspan="3">
                	<input type="text" id="fPname" name="contract.number" value="${mo.dept}" class="input-medium">
				</td>	
           </tr>
            <tr>
                <td class="TDleft"><label>合同名称：</label></td>
                <td colspan="3">
                	<input type="text" id="userName" name="contract.name" value="${mo.name}" class="input-medium">
                </td>
                 </tr>
            <tr> <td class="TDleft"><label>合同签订时间：</label></td>
                <td><input type="text" id="d4311" name="contract.signdate" value="${mo.signdate}"  class="input-medium Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'d4312\')}'})"></td>
                <td class="TDleft"><label>合同截止时间：</label></td>
                <td><input type="text" id="d4312" name="contract.enddate" value="${mo.enddate}"  class="input-medium Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'d4311\')}'})"></td>
               
            </tr>
            <tr>
             	<td class="TDleft"><label>合同金额：</label></td>
                <td colspan="3"><input type="text" id="idCard" name="contract.sum" value="${mo.sum}" class="input-medium"></td>
            </tr>
            <tr>
                <td class="TDleft"><label>合同计价内容：</label></td>
                <td ><input type="text" name="contract.content" value="${mo.content}"  class="input-medium"> </td>
                <td class="TDleft"><label>单       价：</label></td>
                <td > <input type="text" name="contract.price" value="${mo.price}" placeholder="0.0" class="input-medium"></td>
                <td>
		   			<a href="javascript:#" onclick="addLine(this)" class="btn btn-primary">添加一行</a>&nbsp;&nbsp;&nbsp;&nbsp;
		   			<a href="javascript:#" onclick="delLine(this)" class="btn btn-danger">删除一行</a>
                </td>
           </tr>
       </table>
     <div class="btn-youAdd">
        <button class="btn btn-danger" onclick="save()"><img src="${CONTEXT_PATH}/images/icon/clipboard.png" class="clipboard"/> 提 交</button>
    </div>
    </form>
</div>
      </div> 
        </div>
      </div>
</div> 
<!--主体结束--> 
</div> 
</body>
</html>
