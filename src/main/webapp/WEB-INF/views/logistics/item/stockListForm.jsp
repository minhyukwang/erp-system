<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#tabs {width: 960px; height: 470px; font-size: 25px;}
#itemGroupStock > input {font-size: 18px;}
#dateStock > input {font-size: 18px;}
#itemGroupStock {font-size: 18px;}
#dateStock {font-size: 18px;}
.ui-datepicker {font-size: 18px;}
#itemGroupStockList, #dateStockList {font-size: 18px;}
</style>
<script>
var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	$(document).ready(function() {
		$("#tabs").tabs();
		$("#itemGroupStockPrint").click(stockSearch);
		$("#dateStockPrint").click(dateStockSearch);
		$("#itemGroupCode").click(codeSearch);

		$('#startDate').datepicker({
			dateFormat:"yy/mm/dd"
		});
		$('#endDate').datepicker({
			dateFormat:"yy/mm/dd"
		});
		$("#itemGroup").click(function(){
			$.jgrid.gridUnload("#itemGroupStockList");
			$("#itemGroupCode").val("");
			$("#itemGroupName").val("");
		});
		$("#date").click(function(){
			$.jgrid.gridUnload("#dateStockList");
			$("#startDate").val("");
			$("#endDate").val("");
		});
	});

	function codeSearch(){
        window.open('${pageContext.request.contextPath}/base/codeList.html?code=IG','코드 검색',features);
	}


	function stockSearch(){
		var code=$("#itemGroupCode").val();
		$.jgrid.gridUnload("#itemGroupStockList");
		$('#itemGroupStockList').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/item/stockList.do',
			cache : false,
			datatype : 'json',
			postData : {'oper':'findStockList', 'code':code},
			jsonReader : {
				page : 'page',
				total : 'total',
				root : 'list'
			},
			colNames:["품목코드","품목명", "총재고수량", "출고예정수량", "입고일", "입고수량","출고일","출고수량"],
			colModel:[
		               {name:'itemCode',width:10, align:'center', editable:false},
		               {name:'itemName',width:10, align:'center', editable:false},
		               {name:'stockQuantity',width:5, align:'center', editable:false},
		               {name:'outputScheduleQuantity',width:5, align:'center', editable:false},
		               {name:'inputDate',width:10, align:'center', editable:false},
		               {name:'inputQuantity',width:5, align:'center', editable:false},
		               {name:'outputDate',width:10, align:'center', editable:false},
		               {name:'outputQuantity',width:5, align:'center', editable:false}
		               ],
			width : 890,
			height : 220,
			rowNum : 8,
			rowList : [8,16,24],
			rownumbers : true,
			pager : '#itemGroupStockPager',
			caption : '품목군별 재고조회'
		});
		$("#itemGroupStockList").navGrid("#itemGroupStockList", {add:false,del:false,edit:false,search:false,refresh:false});
	}
	function dateStockSearch(){
		var sDate=$("#startDate").val();
		var eDate=$("#endDate").val();
		$.jgrid.gridUnload("#dateStockList");
		$('#dateStockList').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/item/stockList.do',
			cache : false,
			datatype : 'json',
			postData : {'oper':'findStockList', 'start':sDate,'end':eDate},
			jsonReader : {
				page : 'page',
				total : 'total',
				root : 'list'
			},
			colNames:["품목코드","품목명", "총재고수량", "입고일", "입고수량","출고일","출고수량"],
			colModel:[
		               {name:'itemCode',width:10, align:'center', editable:false},
		               {name:'itemName',width:10, align:'center', editable:false},
		               {name:'stockQuantity',width:5, align:'center', editable:false},
		               {name:'inputDate',width:10, align:'center', editable:false},
		               {name:'inputQuantity',width:5, align:'center', editable:false},
		               {name:'outputDate',width:10, align:'center', editable:false},
		               {name:'outputQuantity',width:5, align:'center', editable:false}
		               ],
			width : 890,
			height : 220,
			rowNum : 8,
			rowList : [8,16,24],
			rownumbers : true,
			pager : '#dateStockPager',
			caption : '기간별 재고조회'
		});
		$("#dateStockList").navGrid("#dateStockList", {add:false,del:false,edit:false,search:false,refresh:false});
	}


</script>
</head>
<body>
<br/><br/>
<center>
	<div id="tabs">
		<ul>
			<li><a href="#itemGroupStock" id="itemGroup">품목군별 조회</a></li>
			<li><a href="#dateStock" id="date">기간별 조회</a></li>
		</ul>
		<div id="itemGroupStock">

			<input type="text" id="itemGroupCode" placeholder="품목군코드 확인" readonly="readonly">
			<input type="text" id="itemGroupName" placeholder="품목군" readonly="readonly">
			<input type="button" id="itemGroupStockPrint" value="조회">
			<br/><br/>
			<center>
			<table id="itemGroupStockList"></table>
			<div id="itemGroupStockPager"></div>
			</center>

		</div>
		<div id="dateStock">

			<input type="text" id="startDate" placeholder="시작 날짜" readonly="readonly">
			<label>~</label>
			<input type="text" id="endDate" placeholder="마지막 날짜" readonly="readonly">
			<input type="button" id="dateStockPrint" value="조회">
			<br/><br/>
			<center>
			<table id="dateStockList"></table>
			<div id="dateStockPager"></div>
			</center>

		</div>

	</div>
</center>
<br/>
</body>
</html>