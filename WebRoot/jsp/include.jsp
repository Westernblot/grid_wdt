<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<%--
<base href="<%=basePath%>"/>
<meta http-equiv="Expires" CONTENT="0">
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Cache-Control" CONTENT="no-store">

<link rel="stylesheet" type="text/css" href="<%=basePath%>css/style.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/msgbox/jquery.msgbox.css" />
 --%>
 <base href="${CONTEXT_PATH}/" ></base>
 <meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<script type="text/javascript" src="<%=basePath%>layer/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>layer/layer.js"></script>


 <script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
 <script type="text/javascript" src="<%=basePath%>js/systemUtils.js"></script>
<script type="text/javascript" src="<%=basePath%>js/sysGeneral.js"></script>
<script type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>


 <%--
<script type="text/javascript" src="<%=basePath%>js/jquery.rte.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.msgbox.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.dragndrop.js"></script>
<script type="text/javascript" src="<%=basePath%>js/newajax.js"></script>

<script type="text/javascript" src="<%=basePath%>js/dateUtils.js"></script>

<script type="text/javascript" src="<%=basePath%>js/numberUtils.js"></script> --%>


<%-- <script type="text/javascript" src="<%=basePath%>js/stringUtils.js"></script>
<script type="text/javascript" src="<%=basePath %>js/kindeditor/kindeditor-min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/kindeditor/lang/zh_CN.js"></script> --%>


