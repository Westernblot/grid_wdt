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
//	alert($("tr").length);
	var len=$("tr").length;
	var tr=$("tr").eq(len-1);
	var trHtml= "<tr>";
		trHtml+="<td>"+(len-2)+"</td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\"${mo.daynum}\"  class=\"input-small\" readonly></td>";
		trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\"${mo.daynum}\"  class=\"input-small\" readonly></td>";
		//trHtml+="<td><input type=\"text\" name=\"vacate.daynum\" value=\"${mo.daynum}\"  class=\"input-small\"></td>";
		trHtml+="<td><a href=\"javascript:#\" onclick=\"delLine(this)\" class=\"btn btn-danger\">删除一行</a></td>";
		trHtml+="</tr>";
		//alert(trHtml);
	$(tr).after(trHtml);
}

function delLine(obj){
	var tr = $(obj).parent().parent();
	$(tr).remove();
	var len=$("tr").length;
	for(var i=2;i<len;i++){
		$("tr").eq(i).find("td").eq(0).html(i-2);
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
         <li><a href="${CONTEXT_PATH}/contract/contractDepartment">部门分配</a></li>
         <li><a href="${CONTEXT_PATH}/contract/contractPersonnel">人员分配</a></li>
         <li class="active"><a href="${CONTEXT_PATH}/contract/celfareDistribution">福利分配</a></li>
    </ul>
    <div class="tab-main">
    
     <div class="blocklabel">
              <label><span class="w200">部门：</span><input type="text" id="fPname" value="" class="input-medium"><button class="btn btn-link" href="budgetAdd.html" onclick="getDept()">选择部门</button>　</label>
               <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
						 <ul id="treeDemo" class="ztree" style="margin-top:0; width:180px;height:400px;overflow-y:auto;overflow-x:hidden;"></ul>
					</div>
               <label><span class="w200">单位应缴保险金标准（月）：</span><select name="select5" id="select5">
                  <option>600</option>
                  <option>660</option>
                  <option>658</option>
                </select></label>
               <label><span class="w200">中餐伙食补贴（元/餐）：</span><input type="text" name="textfield" id="textfield" /> </label>
               <label><span class="w200">大病医疗（元/年）：</span><input type="text" name="textfield2" id="textfield2" /></label>
               <label><span class="w200">安全生产（元/月）：</span><input type="text" name="textfield3" id="textfield3" /></label>
               <label><span class="w200">体检费（元/月）：</span><input type="text" name="textfield4" id="textfield4" /></label>
               <label><span class="w200">绩效（元/月） ：</span><input type="text" name="textfield5" id="textfield5" /></label>
        </div>
<div class="btn-youAdd">
    <button class="btn btn-primary" onclick="addLine()"><img src="../images/icon/clipboard.png" class="clipboard"/> 添 加</button>
</div>
            <!--列表开始-->
            <div class="block-tab">
             <table class="table-mins">
             <thead>	
                    <tr>
                      <th>部门名称</th>
                      <th>部门应缴纳保险金标准（元/月）</th>
                      <th>中餐伙食补贴（元/餐）</th>
                      <th>大病医疗（元/年）</th>
                      <th>安全生产（元/月）</th>
                      <th>体检费（元/月）</th>
                      <th>绩效（元/月）</th>
                      <th>合计(年)</th>
                     <!-- <th>操作</th>-->
                    </tr>
                     <tbody>
                    <tr>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly></td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" >*12</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" >*365</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" ></td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" >*12</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" >*12</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" >*12</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly></td>
                      <!--<td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly></td>
                      <td><a href="javascript:#" onclick="delLine(this)" class="btn btn-danger">删除一行</a></td>-->
                    </tr>
                  </tbody>
                  </thead>
                  
             </table>
             
             
            <table class="table-mins">
                  <thead>	
                    <tr>
                      <th>序号</th>
                     <!-- <th>部门名称</th>-->
                      <th>姓名</th>
                      <th>职员代码</th>
                      <!-- <th>部门应缴纳保险金标准（元/月）</th>
                      <th>中餐伙食补贴（元/餐）</th>
                      <th>大病医疗（元/年）</th>
                      <th>安全生产（元/月）</th>
                      <th>体检费（元/月）</th>
                      <th>效绩（元/月）</th>
                      <th>合计(年)</th> -->
                      <th>操作</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <!-- <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly></td>-->
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly></td>
                       <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly></td>
                     <!-- <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly>*12</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly>*365</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly></td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly>*12</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly>*12</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly>*12</td>
                      <td><input type="text" name="vacate.daynum" value="${mo.daynum}"  class="input-small" readonly></td>-->
                      <td><a href="javascript:#" onclick="delLine(this)" class="btn btn-danger">删除一行</a></td>
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
