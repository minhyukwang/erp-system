<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${! empty sessionScope.name}">
	<font style="font-size: 23px; color:blue; text-shadow: 2px 2px 1px white;">${sessionScope.name}</font><font style="font-size: 20px; text-shadow: 2px 2px 1px white;">님 &nbsp;</font>
	<a href="${pageContext.request.contextPath}/insa/emp/logout.do?oper=logout" style="font-size: 20px; color: white; text-shadow: 2px 2px 1px black;">로그아웃</a>
</c:if>
<c:if test="${empty sessionScope.name}">
	<a href="<%=request.getContextPath()%>/insa/emp/loginform.html" style="font-size: 20px; color: white; text-shadow: 2px 2px 1px black;">로그인</a>
</c:if>