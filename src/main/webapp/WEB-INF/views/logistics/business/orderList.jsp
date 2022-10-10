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
#orderListGrid {font-size: 15px;}
</style>
<script>
$(document).ready(function(){
	orderList();
});
function orderList(){
	$('#orderListGrid').jqGrid({
		url : '${pageContext.request.contextPath}/logistics/business/orderListCode.do',
		datatype : 'json',
		postData : {'oper':'findOrderCodeList'},
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
		colNames : [ '주문내역번호', '품목코드', '품목명', '주문수량', '납기예정일'],
		colModel : [
			{name : 'orderListNo',width : 10,	editable : false,align : "center"},
			{name : 'itemCode',	width : 10,	editable : false,align : "center"},
			{name : 'itemName',	width : 10,	editable : false,align : "center"},
			{name : 'orderQuantity',	width : 5,	editable : false,align : "center"},
			{name : 'demandDate',	width : 10,	editable : false,align : "center"},
		],
		onSelectRow : function(id) {
			index = id - 1;
			insertOrderListCode();
		},
		width : 600,
		height : 300,
		viewrecords : true,
		rowNum:6,
		rowList:[6,12,18],
		multiboxonly : true,
		cellsubmit : 'clientArray',
		rownumbers : true,
		pager : '#orderListPager',
		caption : '주문정보리스트'
	});
}
function insertOrderListCode(){
 var data={"orderListNo":dataset[index].orderListNo,
		 "itemCode":dataset[index].itemCode,
		 "itemName":dataset[index].itemName,
		 "orderQuantity":dataset[index].orderQuantity,
		 "demandDate":dataset[index].demandDate
		 }
 window.close();
 	opener.parent.addOrderListInfo(data);

}
</script>
</head>
<body>
<center>
	<table id="orderListGrid"></table>
	<div id="orderListPager"></div>
</center>
</body>
</html>