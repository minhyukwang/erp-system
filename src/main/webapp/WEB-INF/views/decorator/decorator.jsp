<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title><decorator:title/></title>
<!-- jqGrid CSS & SCRIPT -->
<script src="${pageContext.request.contextPath}/jqGrid/js/jquery-1.11.0.min.js"></script>
<script src="${pageContext.request.contextPath}/jqGrid/js/i18n/grid.locale-en.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/jqGrid/css/ui.jqgrid.css" />
<script src="${pageContext.request.contextPath}/jqGrid/js/jquery.jqGrid.min.js"></script>
<!-- jQuery-ui CSS & SCRIPT -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui/jquery-ui.css" />
<script src="${pageContext.request.contextPath}/jquery-ui/jquery-ui.js"></script>
<style type="text/css">
* {margin: 0; padding: 0;text-decoration: none; font-family: "makarong";}
body {
	text-align: center;
	font-size: 25px;
	color: black;
}
a {color: black;}
/* td {border: 3px solid red;} */
.mainTable {
	display: inline-table;
	width: 1024px;
	height: 600px;
}
.mainTop {
	background-image: url(${pageContext.request.contextPath}/img/banner.png);
	background-repeat: no-repeat;
}
</style>
<script>
	$(document).ready(function(){
		$("input:button, input:submit, input:reset, input:text, input:password, button").button();
		$("#gender").buttonset();
		$(".mainTop").click(homeFunc);
	});
	function homeFunc(){
		var home="${pageContext.request.contextPath}/welcome.html";
		$(location).attr("href",home);
	}
</script>
<decorator:head/>
</head>
<body>
	<table class="mainTable">
	<tr class="mainTop">
	<td style="height: 130px; text-align: right; padding-right: 40px;"><br/><br/><br/><jsp:include page="top.jsp"/></td>
	</tr>
	<tr>
		<td style="height: 40px"><jsp:include page="menu.jsp"/></td>
	</tr>
	<tr>
		<td><decorator:body/></td>
	</tr>
	<tr>
		<td style="height: 20px"><jsp:include page="bottom.jsp"/></td>
	</tr>
	</table>
</body>
</html>