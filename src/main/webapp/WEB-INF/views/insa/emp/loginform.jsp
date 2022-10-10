<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.loginTable {display: inline-table;}
.loginTable td {text-align: left;}
input[type=text], input[type=password] {width: 200px; font-size: 20px;}
input[type=submit], input[type=reset] {font-size: 20px;}
#login {font-size: 20px;}
</style>
<script>
	$(document).ready(function(){
		$(":text").eq(0).focus();
		$('#login').click(doLogin);
	});
	function doLogin(){
		$("#err").html("");
		$.ajax({
			url:"${pageContext.request.contextPath}/insa/emp/login.do",
			cache : false,
			type : "post",
			data:{
				"oper" : "login",
				"id" : $("#id").val(),
				"pw" : $("#pw").val(),
				"caller" : "${requestScope.caller}"
			},
			dataType : "json",
			success: function(data) {
	       	 if(data.errorCode == 1) {
	                /* window.location.href = data.caller; */
	                $(location).attr("href","${pageContext.request.contextPath}/welcome.html");
	            } else if (data.errorCode == -1) {
	                $("#err").html(data.errorMsg);
	                $("#id").val("").focus();
	                $("#pw").val("").focus();
	            } else if (data.errorCode == -2) {
	                $("#err").html(data.errorMsg);
	                $("#pw").val("").focus();
	            }
	        }
	       /*  error : function(a,b,c){
	        	alert(a+" , "+b+" , "+c);
	        } */

		});
	}
</script>
</head>
<body>
<form>
	<table class="loginTable">
		<tr>
			<td style="width: 60px; text-align: left;">ID</td>
			<td><input type="text" name="id" id="id"></td>
		</tr>
		<tr>
			<td style="width: 60px; text-align: left;">PW</td>
			<td><input type="password" name="pw" id="pw"></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">
				<span style="font-size: 20px; color:red;" id="err"></span>
			</td>
		</tr>
	</table><br/>
<input type="reset" value="취소">
<button id="login" >로그인</button><br/><br/>

</form>
</body>
</html>