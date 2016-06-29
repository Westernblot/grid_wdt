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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>合同编辑</title>
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
            <li><a href="${CONTEXT_PATH}/index">首页</a> <span class="divider">/</span></li>
            <li><a href="${CONTEXT_PATH}/contract/">合同管理</a> <span class="divider">/</span></li>
            <li class="active">合同编辑</li>
        </ul>

        <div class="container-fluid" style="text-align:center;">

<div class="well you-bg">    
	<h1 class="h1-title">合同编辑</h1> 
	<form id="form1" action="${CONTEXT_PATH}/${mo==null?'vacate/insert':'vacate/update'}"  method="post">
        <table class="youAdd">
            <tr>
                <td class="TDleft"><label>合同编号：</label></td>
                <td colspan="3">
                	<input type="text" id="fPname" name="vacate.dept" value="${mo.dept}" class="input-medium">
				</td>	
           </tr>
            <tr>
                <td class="TDleft"><label>合同名称：</label></td>
                <td colspan="3">
                	<input type="text" id="userName" name="vacate.name" value="${mo.name}" class="input-medium">
                </td>
                 </tr>
            <tr> <td class="TDleft"><label>合同签订时间：</label></td>
                <td><input type="text" id="d4311" name="vacate.begintime" value="${mo.begintime}"  class="input-medium Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'d4312\')}'})"></td>
                <td class="TDleft"><label>合同截止时间：</label></td>
                <td><input type="text" id="d4312" name="vacate.endtime" value="${mo.endtime}"  class="input-medium Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'d4311\')}'})"></td>
               
            </tr>
            <tr>
             	<td class="TDleft"><label>合同金额：</label></td>
                <td colspan="3"><input type="text" id="idCard" name="vacate.idcard" value="${mo.idcard}" class="input-medium"></td>
            </tr>
            <tr>
                <td class="TDleft"><label>合同计价内容：</label></td>
                <td ><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-medium"> </td>
                <td class="TDleft"><label>单       价：</label></td>
                <td > <input type="text" name="vacate.daynum" value="${mo.daynum}" placeholder="0.0" class="input-medium"></td>
                <td>
		   			<a href="javascript:#" onclick="addLine(this)" class="btn btn-primary">添加一行</a>&nbsp;&nbsp;&nbsp;&nbsp;
		   			<a href="javascript:#" onclick="delLine(this)" class="btn btn-danger">删除一行</a>
                </td>
           </tr>
       </table>
     <div class="btn-youAdd">
        <button class="btn btn-danger" onclick="save()"><img src="${CONTEXT_PATH}/images/icon/clipboard.png" class="clipboard"/> 提 交</button>
    </div>
</div>

        </div>
    </div>
    
    
<!--主体结束--> 
</div> 
</body>
</html>