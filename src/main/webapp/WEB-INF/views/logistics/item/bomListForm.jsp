<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#tabs {width: 960px; height: 470px; font-size: 25px;}
#rightBom > input {font-size: 18px;}
#inverseBom > input {font-size: 18px;}
#rightBomList {font-size: 18px;}
#inverseBomList {font-size: 18px;}
</style>
<script>
var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	$(document).ready(function() {
		$("#tabs").tabs();
		$("#rightBomPrint").click(rightBomListFunc);
		$("#inverseBomPrint").click(inverseBomListFunc);
		$("#parentItemCode").click(parentItemCodeListFunc);
		$("#childItemCode").click(childItemCodeListFunc);

		$("#right").click(function(){
			$.jgrid.gridUnload("#rightBomList");
			$("#parentItemCode").val("");
			$("#pItemName").val("");
		});
		$("#inverse").click(function(){
			$.jgrid.gridUnload("#inverseBomList");
			$("#childItemCode").val("");
			$("#cItemName").val("");
		});
	});

	function parentItemCodeListFunc(){
        window.open('${pageContext.request.contextPath}/base/codeList.html?code=PI','코드 검색',features);
	}
	function childItemCodeListFunc(){
        window.open('${pageContext.request.contextPath}/base/codeList.html?code=CI','코드 검색',features);
	}

	function rightBomListFunc(){
		var code=$("#parentItemCode").val();
		$.jgrid.gridUnload("#rightBomList");
		$('#rightBomList').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/item/bomRightList.do',
			cache:false,
			datatype : 'json',
			postData : {'oper':'findBomRightList', 'code':code},
			jsonReader : {
				page : 'page',
				total : 'total',
				root : 'list'
			},
			colNames : [ 'Level', '품목코드', '품목명', '모품목코드', '수량', '단위', '구매처코드', '단가', '계정','조달', '손실률', '소요일', '고객사코드' ],
			colModel : [
				{name : 'lev', width : 5, editable : true, align : "center"},
				{name : 'itemCode', width : 20, editable : true, align : "center"},
				{name : 'itemName', width : 10, editable : true, align : "center"},
				{name : 'parentCode', width : 20, editable : false, align : "center"},
				{name : 'quantity', width : 5, editable : true, align : "center"},
				{name : 'unit', width : 5, editable : true, align : "center"},
				{name : 'purchaseCode', width : 10, editable : false, align : "center"},
				{name : 'price', width : 10, editable : true, align : "right"},
				{name : 'grade', width : 5, editable : false, align : "center"},
				{name : 'procurementCode', width : 5, editable : false, align : "center"},
				{name : 'lossFactor', width : 5, editable : true, align : "center"},
				{name : 'leadTime', width : 5, editable : true, align : "center"},
				{name : 'clientCode', width : 10, editable : false, align : "center"}
			],
			width : 890,
			height : 220,
			rowNum : 8,
			rowList : [8,16,24],
			pager : '#rightBomPager',
			caption : 'BOM 정전개'
		});
		$("#rightBomList").navGrid("#rightBomPager", {add:false,del:false,edit:false,search:false,refresh:false});
	}
	function inverseBomListFunc(){
		var code=$("#childItemCode").val();
		$.jgrid.gridUnload("#inverseBomList");
		$('#inverseBomList').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/item/bomInverseList.do',
			cache : false,
			datatype : 'json',
			postData : {'oper':'findBomInverseList', 'code':code},
			jsonReader : {
				page : 'page',
				total : 'total',
				root : 'list'
			},
			colNames : [ 'Level', '품목코드', '품목명', '모품목코드', '수량', '단위', '구매처코드', '단가', '계정','조달', '손실률', '소요일', '고객사코드' ],
			colModel : [
				{name : 'lev', width : 5, editable : true, align : "center"},
				{name : 'itemCode', width : 20, editable : true, align : "center"},
				{name : 'itemName', width : 10, editable : true, align : "center"},
				{name : 'parentCode', width : 20, editable : false, align : "center"},
				{name : 'quantity', width : 5, editable : true, align : "center"},
				{name : 'unit', width : 5, editable : true, align : "center"},
				{name : 'purchaseCode', width : 10, editable : false, align : "center"},
				{name : 'price', width : 10, editable : true, align : "right"},
				{name : 'grade', width : 5, editable : false, align : "center"},
				{name : 'procurementCode', width : 5, editable : false, align : "center"},
				{name : 'lossFactor', width : 5, editable : true, align : "center"},
				{name : 'leadTime', width : 5, editable : true, align : "center"},
				{name : 'clientCode', width : 10, editable : false, align : "center"}
			],
			width : 890,
			height : 220,
			rowNum:8,
			rowList:[8,16,24],
			pager : '#inverseBomPager',
			caption : 'BOM 역전개'
		});

	}

</script>
</head>
<body>
<br/><br/>
<center>
	<div id="tabs">
		<ul>
			<li><a href="#rightBom" id="right">BOM 정전개</a></li>
			<li><a href="#inverseBom" id="inverse">BOM 역전개</a></li>
		</ul>
		<div id="rightBom">

			<input type="text" id="parentItemCode" placeholder="모품목코드 확인" readonly="readonly">
			<input type="text" id="pItemName" placeholder="품목명" readonly="readonly">
			<input type="button" id="rightBomPrint" value="조회">
			<br/><br/>
			<center>
			<table id="rightBomList"></table>
			<div id="rightBomPager"></div>
			</center>

		</div>
		<div id="inverseBom">

			<input type="text" id="childItemCode" placeholder="자품목코드 확인" readonly="readonly">
			<input type="text" id="cItemName" placeholder="품목명" readonly="readonly">
			<input type="button" id="inverseBomPrint" value="조회">
			<br/><br/>
			<center>
			<table id="inverseBomList"></table>
			<div id="inverseBomPager"></div>
			</center>

		</div>

	</div>
</center>
<br/>
</body>
</html>