<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 


<div id="div_top">
          <ul class="top_icon pull-right">
              <li>
                <a href="javascript:#" class="username">
                    <span><img src="${CONTEXT_PATH}/images/frame/1.jpg"/></span>
                    <p>
                        <strong>${sessionScope.user.cnname}</strong><br/>
                       ${sessionScope.user.dept}
                    </p>
                </a>
              </li>
              <li>
				<a href="${CONTEXT_PATH}/index"  class="top_a"><i class="hIcon ico_jsq"></i><span>回到首页</span></a>
			  </li>
			  <li>
				<a href="${CONTEXT_PATH}/user/setPwdUI?id=${sessionScope.user.id}"  class="top_a"><i class="hIcon ico_sz"></i><span>修改密码</span></a>
			  </li>
              <!-- <li><a href="javascript:#" class="top_a"><i class="hIcon ico_sz"></i><span>帮助</span></a></li> -->
              <li><a href="${CONTEXT_PATH}/login/quit" class="top_a"><i class="hIcon ico_tc"></i><span>退出</span></a></li>
          </ul>
</div>