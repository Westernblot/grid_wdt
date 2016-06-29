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
    	<script type="text/javascript" src="${CONTEXT_PATH}/zTree/js/jquery-1.4.4.min.js"></script>
    	<script type="text/javascript" src="${CONTEXT_PATH}/js/systemUtils.js"></script>
    	<%--=================================z-tree 相关======================================================== --%>
    	<script type="text/javascript" src="${CONTEXT_PATH}/js/showZTree.js"></script>
		<link rel="stylesheet" href="${CONTEXT_PATH}/js/zTree/css/demo.css" type="text/css">
		<link rel="stylesheet" href="${CONTEXT_PATH}/js/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${CONTEXT_PATH}/js/zTree/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="${CONTEXT_PATH}/js/zTree/js/jquery.ztree.excheck-3.5.js"></script>
	</head>
<script type="text/javascript">
var zNodes=PublicAjax('${CONTEXT_PATH}/dept/deptJson');
//==========================动态表格添加/删除==================================
function addLine(){
	//部门
	var dept = $("#fPname").val();
	//部门人数
	var num = synchroAjax('${CONTEXT_PATH}/dept/deptNum',{dept:dept});
	//金额
	var price=$("#price").val();
	
	var len=$("tr").length;
	var tr=$("tr").eq(len-1);
	var trHtml= "<tr>";
		trHtml+="<td>"+len+"</td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\""+dept+"\"  class=\"input-medium\" readonly></td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\""+num+"\"  class=\"input-medium\" readonly></td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\""+price+"\"  class=\"input-medium\"></td>";
		trHtml+="<td><a href=\"javascript:#\" onclick=\"delLine(this)\" class=\"btn btn-danger\">删除一行</a></td>";
		trHtml+="</tr>";
	if(len==2&&$("#dept1").val()==""&&$("#num1").val()==""&&$("#price1").val()==""){
		$("#dept1").val(dept);
		$("#num1").val(num);
		$("#price1").val(price);
	}else{
		$(tr).after(trHtml);	
	}	
	
}

function delLine(obj){
	var tr = $(obj).parent().parent();
	$(tr).remove();
	//修改序号
	var len=$("tr").length;
	for(var i=0;i<len;i++){
		$("tr").eq(i).find("td").eq(0).html(i);
	}
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
            <li><a href="../index.html">首页</a> <span class="divider">/</span></li>
            <li class="active">合同管理</li>
        </ul>

        <div class="container-fluid">
  
  <div class="tabmenu">
    <ul class="tab-title">
      	 <li><a href="${CONTEXT_PATH}/contract/contractUI">合同基础信息录入</a></li>
         <li class="active"><a href="${CONTEXT_PATH}/contract/contractDepartment">部门分配</a></li>
         <li><a href="${CONTEXT_PATH}/contract/contractPersonnel">人员分配</a></li>
         <li><a href="${CONTEXT_PATH}/contract/celfareDistribution">福利分配</a></li>
    </ul>
    <div class="tab-main">
    
     <div class="blocklabel">
              <label><span>部门：</span><input type="text" id="fPname" value="" class="input-medium"><button class="btn btn-link" href="budgetAdd.html" onclick="getDept()">选择部门</button>　</label>
            <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
						 <ul id="treeDemo" class="ztree" style="margin-top:0; width:180px;height:400px;overflow-y:auto;overflow-x:hidden;"></ul>
					</div>
            <label><span>分配金额：</span><input type="text" id="price" value="" class="input-medium"></label>
            <button class="btn btn-primary" onclick="addLine()"><img src="../images/icon/clipboard.png" class="clipboard"/> 添 加</button>
        </div>
            <!--列表开始-->
            <div class="block-tab">
            <table class="table-mins">
                  <thead>	
                    <tr>
                      <th>序号</th>
                      <th>部门名称</th>
                      <th>部门人数</th>
                      <th>预算分配金额</th>
                      <th>操作</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td><input type="text" id="dept1" name="vacate.daynum" value="${mo.daynum}"  class="input-medium" readonly></td>
                      <td><input type="text" id="num1" name="vacate.daynum" value="${mo.daynum}"  class="input-medium" readonly></td>
                      <td><input type="text" id="price1" name="vacate.daynum" value="${mo.daynum}"  class="input-medium"></td>
                      <td>	<a href="javascript:#" onclick="delLine(this)" class="btn btn-danger">删除一行</a></td>
                    </tr>
                  </tbody>
                </table>
            </div>
           
    <div class="btn-youAdd">
        <button class="btn btn-danger" onclick="save()"><img src="${CONTEXT_PATH}/images/icon/clipboard.png" class="clipboard"/> 提 交</button>
    </div>
      </div>

</div> 


        </div>
    </div> 
<!--主体结束--> 
</div> 
</body>
</html>
