<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${! empty sessionScope.name}">
		<font style="color:#674f2c;">물류정보 시스템에 오신 것을 환영합니다.</font>
	</c:if>
	<c:if test="${empty sessionScope.name}">
		<font style="color: #8b6b3a;">물류정보 시스템</font>에 오신 것을 환영합니다.<br/>
		<font style="color: red;">로그인을 하셔야 이용가능 합니다.</font>
	</c:if>
</body>
</html>