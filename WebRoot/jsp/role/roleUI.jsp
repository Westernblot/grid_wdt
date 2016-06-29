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
<script type="text/javascript" src="${CONTEXT_PATH}/layer/jquery-1.9.1.js"></script>
 <script type="text/javascript" src="${CONTEXT_PATH}/layer/layer.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

	});
	
	//选中子菜单
	function checkedSub(ul,checkedValue){
		$('#'+ul).find("input[type=checkbox]").attr("checked", checkedValue);
	}
	
	//选中父菜单
	function checkedPar(ul,cb,checkedValue){
		if( checkedValue ){ // checkedValue是boolean型，表示是否选中了当前复选框
			// 如果当前是选中，则选中所有的直属上级
			$('#'+cb).attr("checked", checkedValue);
		}else{
			//如果兄弟节点都没有选中，则取消父级节点选中
			var chked=false;
			$('#'+ul).find("input[type=checkbox]").each(function(){
			       if(this.checked){
			    	   chked=true;
			       }
		    }); 
			
			if(!chked){
				$('#'+cb).attr("checked", checkedValue);
			}
		}
	}

	
	//选择成员
	function chooseUser(){
		   //页面层
	    layer.open({
	        type: 2,
	        title: '用户选择',
	        maxmin: true,
	        shade:0,
	        shadeClose: true, //点击遮罩关闭层
	        area : ['500px' , '520px'],
	        offset: ['100px', '800px'],
	        content: '${CONTEXT_PATH}/user/userSelect',
	         btn: ['确定','关闭'],
	         yes: function(index, layero){
	             //do something	   
	              var body = layer.getChildFrame('body', index);
	             	        
	              body.find("input[type=checkbox]").each(function(){
				       if(this.checked && $(this).val()!=''){
				    	  //alert($(this).val());
				    	  var id =$(this).val();
				    	  var cnname =$(this).attr('data');
				    	  
				    	  var html ='<li>'
                            	      +'<input type="hidden" name="userid" value="'+id+'">'
                        	          +cnname+'&nbsp;'
                        	          +'<img src="../images/icon/del.png" class="subdel" onclick="del(this)"/>'
                        	        +'</li>';
				    	  $('#role_name').append(html);

				       }
			      }); 
	          //layer.close(index); //如果设定了yes回调，需进行手工关闭
	         },cancel: function(index){ //或者使用btn2
	        	    //按钮【按钮二】的回调
	         }
	    });
	}
	
	//保存数据
	function save1(){
		$('#form1').submit();
	}
	
	//移除父元素
	function del(obj){
		$(obj).parent().remove();
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
				<li><a href="${CONTEXT_PATH}/user/">角色管理</a><span class="divider">/</span></li>
				<li class="active">新增角色</li>
			</ul>

			<div class="container-fluid">

					<div class="btn-toolbar">
						<a class="btn btn-primary" onclick="save1()">
							<img src="${CONTEXT_PATH}/images/icon/clipboard.png" class="clipboard" /> 保存
						</a>
						<a href="javascript:history.back();" class="btn">返回</a>
					</div>


						<form id="form1" action="${CONTEXT_PATH}/${mo==null?'role/insert':'role/update'}"
							method="post">
							<c:if test="${mo!=null}">
							<input type="hidden" name="role.id" value="${mo.id}">
							</c:if>
							<table class="youAdd" width="100%">
								<tr>
									<td colspan="2">名称：
									<input type="text" name="role.name" value="${mo.name}" class="input-xlarge" />
									</td>
								</tr>
								<tr>
                                    <td class="TDleft" width="200" valign="top" style="text-align:left;">权限：</td>
                                    <td class="TDleft" valign="top" style="text-align:left;">
                                                             成员：<a href="javascript:chooseUser()">选择</a>
                                    </td>		
								</tr>
								
								<tr>							
							    <td valign="top">
	<div class="role-nav">
         
         
          <c:forEach items="${sessionScope.menuList }" var="base">
			      
			      <c:if test="${base.pid==0}">
			      
			      <div class="menu" ><label><input type="checkbox" id="cb_${base.id}" name="role.power" value="${base.id}" onclick="checkedSub('ul_${base.id}', this.checked)" <c:forEach items="${mo.power.split(',') }" var="ac"><c:if test="${ac==base.id}">checked</c:if></c:forEach> > ${base.name}</label></div>
			        	 <ul class="nav-list" id="ul_${base.id}">
			        	 
			        	  <c:forEach items="${sessionScope.menuList }" var="sub">
			        	  
			                  <c:if test="${sub.pid==base.id}">			                
			                      <li><label><input type="checkbox" id="cb_${sub.id}" name="role.power" value="${sub.id}" onclick="checkedPar('ul_${base.id}','cb_${base.id}', this.checked)" <c:forEach items="${mo.power.split(',') }" var="ac"><c:if test="${ac==sub.id}">checked</c:if></c:forEach> >${sub.name}</label></li>
			                  </c:if>
			              
			               </c:forEach>
			               
			             </ul> 
			      </c:if>

			</c:forEach>
         
         
    </div> 
							    </td>					
							    <td valign="top" style="background-color:#FFF;">
							      <ul class="role-name" id="role_name">
                                  	
                                  	<c:forEach items="${list}" var="vo" varStatus="vs">
                                  	<li>
                            	      <input type="hidden" name="userid" value="${vo.id}">
                        	          ${vo.cnname }
                        	          <img src="../images/icon/del.png" class="subdel" onclick="del(this)"/>
                        	        </li>
                                  	</c:forEach>
                                  	
                                  	
                                  	
                                   <!--  <li>王缪缪</li>
                                  	<li>胡某某</li>
                                  	<li>郭鑫</li>
                                    <li>王缪缪</li>
                                  	<li>胡某某</li>
                                  	<li>郭鑫</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                    <li>王缪缪</li>
                                  	<li>胡某某</li>
                                  	<li>郭鑫</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                  	<li>admin</li>
                                    <li>王缪缪</li>
                                  	<li>胡某某</li>
                                  	<li>郭鑫</li> -->
                                  </ul>
							      
							    
							    </td>
								</tr>

							</table>

						</form>
					
				
			</div>
		</div>
	</div>



</body>
</html>