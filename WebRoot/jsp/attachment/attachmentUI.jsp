<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>..</title>
<jsp:include page="../include.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/common.css">
<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/css/theme.css">
<script type="text/javascript" src="js/goaler.js"></script>
<script type="text/javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>

<script type="text/javascript">


//=========================附件上传=================================

function doUpload(){
	
	$.ajaxFileUpload
    (
        {
            url: '${CONTEXT_PATH}/file/upload', //用于文件上传的服务器端请求地址
            type: 'post',
            data: { Id: '123', name: 'lunis' }, //此参数非常严谨，写错一个引号都不行
            secureuri: false, //一般设置为false
            fileElementId: 'file', //文件上传空间的id属性  <input type="file" id="file" name="file" />
            dataType: 'json', //返回值类型 一般设置为json
            success: function (data, status)  //服务器成功响应处理函数
            {
                
            	//alert(data.name+"-"+data.status+"-"+data.url);
            	
                var attachment=data.name;
    			var attachment_url=data.url;
    			var html='<div><a href="${CONTEXT_PATH}/file/download2?fileName='+attachment+'&fileURL='+attachment_url+'" id="attachment">'+attachment+'</a>'
    		     +'<input type="hidden" id="attachment" name="attachment.attachment" value="'+attachment+'" />'
    		     +'<input type="hidden" id="attachment_url" name="attachment.attachment_url" value="'+attachment_url+'" />'
    		     +'<a href="javascript:#" id="del" onclick="delDiv(this)"><img src="${CONTEXT_PATH}/images/remove.png" /></a></div>'; 
    	
    		    $('#div_attachment').append(html);
            },
            error: function (data, status, e)//服务器响应失败处理函数
            {
                alert(e);
            }
        }
    );
	
}


//删除附件
function delDiv(obj){
	$(obj).parent().remove();
}


//保存
function doSave(){
	$('#form1').submit();
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
	<div class="right_top">
					<span>${fGroup}</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
				</div>
				
		<div class="develop">
		<form action="${CONTEXT_PATH}/${mo==null?'attachment/insert':'attachment/update'}"  id="form1" method="post">
		                    <c:if test="${mo!=null}">
							<input type="hidden" name="attachment.id" value="${mo.id}">
							</c:if>
		  
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" width="15%">标题：</td>
		   <td colspan="3" >
		   <input type="text" size="80" id="title" name="attachment.title" value="${mo.title }" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		
		   <tr>
		   <td align="right">附件：</td>
		   <td colspan="3">
		   <input type="file" id="file" name="file" value="" onchange="doUpload()"> 
		    <div id="div_attachment">
		    <c:if test="${mo.attachment!=null and mo.attachment !=''}">
		    <c:forEach items="${mo.attachment_url.split(',') }" var="url" varStatus="vs">
		       <div>
		       <a href="${CONTEXT_PATH}/file/download2?fileName=${mo.attachment.split(',')[vs.index] }&fileURL=${url}" id="attachment">${mo.attachment.split(',')[vs.index] }</a>
		       <input type="hidden" id="attachment" name="attachment.attachment" value="${mo.attachment.split(',')[vs.index] }" />
		       <input type="hidden" id="attachment_url" name="attachment.attachment_url" value="${url}" />
		       <a href="javascript:#" id="del" onclick="delDiv(this)"><img src="${CONTEXT_PATH}/images/remove.png" /></a>
		       </div>
		    </c:forEach>
		    </c:if>
		    </div>
		   </td>
		   </tr>
		   
		   </table>
		</form>
		</div>
		</div>
</div>
</body>
</html>