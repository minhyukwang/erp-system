<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- jqGrid CSS & SCRIPT -->
<script src="${pageContext.request.contextPath}/jqGrid/js/jquery-1.11.0.min.js"></script>
<script src="${pageContext.request.contextPath}/jqGrid/js/i18n/grid.locale-en.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/jqGrid/css/ui.jqgrid.css" />
<script src="${pageContext.request.contextPath}/jqGrid/js/jquery.jqGrid.min.js"></script>
<!-- jQuery-ui CSS & SCRIPT -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui/jquery-ui.css" />
<script src="${pageContext.request.contextPath}/jquery-ui/jquery-ui.js"></script>
<style type="text/css">
#stockQuantityListGrid {font-size: 15px;}
</style>
<script>
$(document).ready(function(){
	stockQuantityList();
});
function stockQuantityList(){
	var code="${param.code}";
	$('#stockQuantityListGrid').jqGrid({
		url : '${pageContext.request.contextPath}/logistics/item/stockListCode.do',
		datatype : 'json',
		postData : {'oper':'findStockListCode', 'code':code},
		cache : false,
		jsonReader : {
			page : 'page',
			total : 'total',
			root : 'list'
		},
	 	beforeProcessing : function(data) {
			if (data.errorCode < 0) {
				alert(data.errorMsg);
			} else {
				dataset = data.list;
			}
		},
		colNames : [ '품목코드', '품목명', '현재고','사용가능재고'],
		colModel : [
			{name : 'itemCode',	width : 10,	editable : false, align : "center"},
			{name : 'itemName',	width : 10,	editable : false, align : "center"},
			{name : 'stockQuantity',	width : 5, editable : false, align : "center"},
			{name : 'quantity',	width : 5, editable : false, align : "center"}
		],
		onSelectRow : function(id) {
			index = id - 1;
			insertStockQuantityListInfo();
		},
		width : 600,
		height : 300,
		viewrecords : true,
		rowNum:6,
		rowList:[6,12,18],
		multiboxonly : true,
		cellsubmit : 'clientArray',
		rownumbers : true,
		pager : '#stockQuantityListPager',
		caption : '현 재고 리스트'
	});
}

	function insertStockQuantityListInfo() {
		var data = {
			"stockQuantity" : dataset[index].stockQuantity,
			"quantity" : dataset[index].quantity
		}
		window.close();
		opener.parent.addStockQuantityListInfo(data);

	}
</script>
</head>
<body>
<center>
	<table id="stockQuantityListGrid"></table>
	<div id="stockQuantityListPager"></div>
</center>
</body>
</html>