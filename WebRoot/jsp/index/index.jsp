<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>维达通_管理系统入口</title>
<base href="${CONTEXT_PATH}/" />
  <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/theme.css">
<script type="text/javascript" src="<%=basePath%>layer/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>layer/layer.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/systemUtils.js"></script>

</head>
<script type="text/javascript">



</script>
<body>
	<div id="container">
	
	<!--左边栏显示 -->
	 <%@ include file="../common/left.jsp"%> 
	
    <!-- 顶部显示 -->
	<%@ include file="../common/top.jsp"%> 


<!-- 中间主面板显示 -->
    <!--主体开始-->  
   <div class="content">
   	
       <ul class="breadcrumb">
            <li><a href="#">首页</a> <span class="divider">/</span></li>
           <!--  <li class="active">财产刑执行检察案件系统</li> -->
        </ul>
        <p style="font-size:18px; text-align:center; margin:8% 0;">
           为了保证系统兼容性请使用<strong style=" color:#F00;">IE8以上浏览器</strong>或者<strong style=" color:#F00;">360浏览器极速模式</strong> 访问！
        </p>
        <img src="images/login/home_text.png" />
        <img src="images/login/home_bg.jpg" width="100%" height="100%" style="position: fixed; bottom:0; right:0; z-index: -1;" />
   </div>
<!--主体结束--> 
  
    <!--/main-->
    </div>
</body>
</html>