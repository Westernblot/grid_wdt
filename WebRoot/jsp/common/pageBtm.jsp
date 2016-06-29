<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 



<div>
	<a class="first" href="${actionUrl}?pageNumber=1${urlParas}">首页</a> | 
	
	<c:choose>
				<c:when test="${page.pageNumber <=1}">
						<a class="prev" href="${actionUrl}?pageNumber=1${urlParas}">上一页</a> | 
				</c:when>
				<c:otherwise>
					    <a class="prev" href="${actionUrl}?pageNumber=${page.pageNumber-1}${urlParas}">上一页</a> | 
				</c:otherwise>
	</c:choose>
	
   <c:choose>
				<c:when test="${page.pageNumber < page.totalPage}">
						<a class="prev" href="${actionUrl}?pageNumber=${page.pageNumber+1}${urlParas}">下一页</a> | 
				</c:when>
				<c:otherwise>
					    <a class="prev" href="${actionUrl}?pageNumber=${page.totalPage==0?1:page.totalPage}${urlParas}">下一页</a> | 
				</c:otherwise>
	</c:choose>

	<a class="end" href="${actionUrl}?pageNumber=${page.totalPage==0?1:page.totalPage}${urlParas}">末页</a>  ${page.pageNumber}/${page.totalPage}页, 
	<span class="rows">每页${page.pageSize}条;共${page.totalRow}条记录&nbsp</span>
</div>