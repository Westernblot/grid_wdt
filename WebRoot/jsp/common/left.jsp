<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


	<div id="div_left">
    		<div class="gs_logo"></div>
			<div class="sidebar-nav">             
			
			  <c:forEach items="${sessionScope.menuList }" var="base">
			      
			      <c:if test="${base.pid==0}">
			      
			      <a id="sub01" class="menu" href="javascript:#">${base.name}</a>
			        	 <ul class="nav-list i-sub01">
			        	 
			        	  <c:forEach items="${sessionScope.menuList }" var="sub">
			        	  
			                  <!--  <li><a href="hrm/department.html">部门管理</a></li>  被选中的样式为：current  -->
			                
			                  <c:if test="${sub.pid==base.id}">			                
			                      <li ><a href="${CONTEXT_PATH}/${sub.action}" 
			                      			   			                      	                 			                   
			                          <c:if test="${fn:contains(pageContext.request.requestURL, sub.action)}">
                                             class="current"
                                      </c:if>			                      
			                      
			                      >${sub.name}</a></li>
			                  </c:if>
			              
			               </c:forEach>
			               
			             </ul> 
			      </c:if>

			   </c:forEach>
			   

                       <%--  <a class="menu active" href="${CONTEXT_PATH}/user/userMain">用户管理</a>  
                        <a id="sub01" class="menu" href="#">人力资源管理</a>
			        	<ul class="nav-list i-sub01">
			                <li><a href="hrm/department.html">部门管理</a></li><!--被选中的样式为：current--> 
			                <li><a href="hrm/staff.html">员工管理</a></li>
			                <li><a href="hrm/check.html">假期管理</a></li>
			             </ul> 
			             <a id="sub02" class="menu" href="#">财务管理</a>
			             <ul class="nav-list i-sub02">
			                <li><a href="finance/contract.html">合同管理</a></li>
			                <li><a href="finance/fund.html">五险管理</a></li>
			                <li><a href="finance/salary-report.html">部门工资上报</a></li>
			                <li><a href="finance/payroll.html">工资发放</a></li>
			                <li><a href="finance/historical-wage.html">历史工资明细</a></li>
			             </ul> 
			             <a id="sub03" class="menu" href="finance/budget.html">预决算管理</a>   --%>       
        	</div>
    </div>
