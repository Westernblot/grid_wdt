<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit" /><!-- 开启360浏览器极速模式，其他浏览器未测试 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>维达通_管理系统入口</title>
<base href="${CONTEXT_PATH}/" />
<script type="text/javascript" src="<%=basePath%>layer/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>layer/layer.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/systemUtils.js"></script>
<link href="${CONTEXT_PATH}/css/default.css" rel="stylesheet" type="text/css" />
<style>
	*{ margin:0; padding:0; }
	html,body{ height:100%;}
	body{ font-size:12px; background:#1E64AC;}
    .login-top{ background:#1C4E80; height:47px; line-height:47px; color:#AEBFD1; text-align:left; padding-left:21px;}
	.login-main{ height:636px; background:url(${CONTEXT_PATH}/images/login/login_bg.jpg) center top repeat-x;}
	.login-foot{ background:#4C87C2; position:absolute; bottom:0; width:100%;height:24px; color:#24476F; padding-top:10px; text-align:center;}
	.login{ padding-top:136px; height:636px; background:url(${CONTEXT_PATH}/images/login/login_mbg.jpg) center top no-repeat; text-align:center; overflow:hidden;}
	.login table{ margin:109px auto 0 auto; text-align:left; }
	.login table td{ text-align:left; padding-bottom:23px; padding-left:224px;color:#687992;}
	.login a{ color:#687992; text-decoration:none;}
	.inputText{padding:0 10px 0 35px;clear:both;line-height:44px;height:46px;width:296px;border:1px solid #B9C3D2; box-shadow: inset 1px 1px 1px #DDE6F2;border-radius:4px; font-weight:bold; font-size:16px;}
	.button{ height:35px; width:111px; background:url(${CONTEXT_PATH}/images/login/login_btn.jpg) center top repeat-x; border-radius:4px; border:0; color:#FFF; font-weight:bold; font-size:14px;}
</style>
</head>
<script type="text/javascript">

$(function(){
	$('#account').focus();
});


function toPwd(obj) {
    $('#password').focus();	
}


function doLogin(){
	
	$.ajax({
		url:'${CONTEXT_PATH}/login/toLogin',
		data:$('#form1').serialize(),
		dataType:'json',
		type:'post',
		success:function(data){
			if(data>0){
				layer.msg('操作成功,3秒后跳转', function(){
					  //do something
			             location.href='${CONTEXT_PATH}/index';
					}); 
			}else{
				layer.msg('账户或密码错误');
			}
		},
		error:function(){
			alert("系统错误");
		}
	});
	
}


</script>
<body>
	<div class="login-top"><img src="${CONTEXT_PATH}/images/login/login_dot.jpg" style="vertical-align:middle;"/> 欢迎湖北维达通科技有限公司(黄石分公司)系统管理平台</div>
	<div class="login-main">
    	<div class="login">
        <form action="${CONTEXT_PATH}/login/toLogin" method="post" id="form1">
             <table>
             <caption><font color="red">${msg}</font></caption>
                <tr>
                    <td><input name="username" id="username" type="text" class="inputText" value="" style=" background:url(${CONTEXT_PATH}/images/login/login_name.jpg) 10px center no-repeat #EBF3FA;"></td>
                </tr>
                <tr>
                    <td><input name="password" id="password" type="password" class="inputText" value="" style=" background:url(${CONTEXT_PATH}/images/login/login_password.jpg) 10px center no-repeat #EBF3FA;"></td>
                </tr>
                <tr> 
                    <td><input type="submit" id="button" value="登 录" class="button" />　　
                    <!--<label for="zh"><input name="zh" id="zh" type="checkbox" value="" style="vertical-align:middle;" />记住账号</label>　　
             		<a href="#">忘记密码？</a>-->
                    </td> 
                </tr>
        </table>
        
        
        </form>
        
        
    	</div>
    </div>
	<div class="login-foot">
    	copyright by gridsoft co.,ltd.  2015-2016  版权申明  湖北网格软件开发有限公司 <a href="www.gridssoft.com" target="_blank" style=" color:#24476F;">www.gridssoft.com</a>
    </div>
</body>
</html>