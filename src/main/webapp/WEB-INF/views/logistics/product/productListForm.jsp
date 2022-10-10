<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/jqGrid/jquery.json-2.3.js"></script>
<title>Insert title here</title>
<style type="text/css">
#tabs {width: 960px; height: 470px; font-size: 25px;}
#regisProductList, #productHistory {font-size: 18px;}
#productListGrid, #productHistoryListGrid {font-size: 15px;}
.ui-datepicker {font-size: 18px;}
input[type=text] {width: 140px;}
</style>
<script>
var row;
var lastselect;
var emptyProductBean;
var productBeanList = [];
	$(document).ready(function() {
		$("#tabs").tabs();													//UI
		$("#workPlaceName").click(workPlaceSearch);			//사업장 코드리스트
		$("#findProductList").click(productListSearch);
		$("#saveProduct").click(saveFunc);
		$("#findProductHistoryList").click(ProductHistoryListSearch);

		$('#startDate').datepicker({
			dateFormat:"yy/mm/dd"
		});
		$('#endDate').datepicker({
			dateFormat:"yy/mm/dd"
		});

	});

	function productListSearch(){
		$.jgrid.gridUnload("#productListGrid");
		$('#productListGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/product/productList.do',
			datatype : 'json',
			postData : {'oper':'findProductList', 'code': $("#workPlaceCode").val()},
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
					emptyProductBean = data.productBean
				}
			},
			colNames : [ '주문내역번호', '품목코드', '품목명','계획수량','계획일','생산수량', '생산일', '담당자', '상태'],
			colModel : [
				{name : 'orderListNo', width : 15, editable : false, align : "center"},
				{name : 'itemCode', width : 14, editable : false, align : "center"},
				{name : 'itemName', width : 13, editable : false, align : "center"},
				{name : 'planQuantity', width : 5, editable : false, align : "center"},
				{name : 'planDate', width : 14, editable : false, align : "center"},
				{name : 'productQuantity',	width : 5, editable : true, align : "center"},
				{name : 'productDate',width : 14,align : "center",	editable : true,
                    editoptions:{size : 15, dataInit:function(date){
                        $(date).datepicker({dateFormat : 'yy/mm/dd'});
                      }
					}
				},
				{name : 'empName', width : 7, editable :false, align : "center"},
				{name : 'status',	 width : 5, editable : false, align : "center"}
			],
			width : 900,
			height : 200,
			viewrecords : true,
			rowNum : 10,
			rowList : [10,20,30],
			multiboxonly : true,
			editurl : 'clientArray',
			rownumbers : true,
			pager : '#productListPager',
			caption : '생산 실적 리스트',
			onSelectRow: function(id) {
				if(id && id !== lastselect) {
				        $(this).restoreRow(lastselect);
				          lastselect = id;
				       }
				       $(this).editRow(id, true);
				   },
			onCellSelect: function(rowid, iCol, cellcontent, e) {
				if(iCol==8){
					$("#productListGrid").setCell(rowid, 'empName', '${sessionScope.name}');
					$("#productListGrid").setCell(rowid, 'status', 'insert');
				 }
	        }
		});
	}

	function saveFunc(){

		var rowid = $('#productListGrid').jqGrid('getDataIDs');
		for(var i=1; i<=rowid.length; i++){
		  var tempList = $('#productListGrid').jqGrid('getRowData', i);
		  if(tempList.status !=""){
			var productBean=ObjectCopy(emptyProductBean);
			productBean.orderListNo=tempList.orderListNo;
			productBean.itemCode=tempList.itemCode;
			productBean.productQuantity=tempList.productQuantity;
			productBean.productDate=tempList.productDate;
			productBean.empName=tempList.empName;
			productBean.status=tempList.status;
			productBeanList.push(productBean);
		  }
		}
		//var list='{"productBeanList":'+ $.toJSON(insertList)+'}';
		//alert(list);
		productCrud();
	}

	function productCrud(){
		var check=confirm("등록하시겠습니까?");
		if(check){}else{
			location.href='${pageContext.request.contextPath}/logistics/product/productListForm.html';
			return false;
		}
		$.ajax({
		    url : '${pageContext.request.contextPath}/logistics/product/productRegis.do',
		    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		    type : 'post',
		    cache : false,
		    data :{'oper':'productCrud', 'productBeanList' : JSON.stringify(productBeanList)},
		    success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("생산 실적 등록이 완료 되었습니다.");
		    		location.href="${pageContext.request.contextPath}/logistics/product/productListForm.html";
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("일괄처리 오류입니다!");
		    }
		});
	}

	function ProductHistoryListSearch(){
		$.jgrid.gridUnload("#productHistoryListGrid");
		$('#productHistoryListGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/product/productHistoryList.do',
			datatype : 'json',
			postData : {'oper':'findProductHistoryList', 'start': $('#startDate').val(), 'end':$('#endDate').val()},
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
				}
			},
			colNames : [ '생산일련번호','품목코드', '품목명', '생산수량','생산일자', '담당자'],
			colModel : [
			    {name : 'productNo',width : 5,	editable : false,align : "center"},
				{name : 'itemCode',	width : 13,	editable : false,align : "center"},
				{name : 'itemName',	width : 13,	editable : false,align : "center"},
				{name : 'productQuantity',	width : 5,	editable : false,align : "center"},
				{name : 'productDate',	width : 13,	editable : false,align : "center"},
				{name : 'empName',	width : 10,	editable : false,align : "center"}
			],
			width : 900,
			height : 200,
			viewrecords : true,
			rowNum : 10,
			rowList : [10,20,30],
			multiboxonly : true,
			cellsubmit : 'clientArray',
			rownumbers : true,
			pager : '#productHistoryListPager',
			caption : '생산 내역 조회'
		});
	}


	//사업장 검색 시 코드확인 및 불러오는 새창열기
	function workPlaceSearch(){
		var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	        window.open('${pageContext.request.contextPath}/base/codeList.html?code=WP',
	        '사업장코드 검색',features);
	}
	//오브젝트 copy
	function ObjectCopy(obj){
		 return JSON.parse(JSON.stringify(obj));
	}

</script>
</head>
<body>
<br/><br/>
<center>
	<div id="tabs">
		<ul>
			<li><a href="#regisProductList">생산실적관리</a></li>
			<li><a href="#productHistory">생산실적조회</a></li>
		</ul>
		<div id="regisProductList">
			<input type="hidden" id="workPlaceCode">
  			<input type="text" id="workPlaceName" placeholder="사업장 선택">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button id="findProductList">조회</button>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;
			<button id="saveProduct">저장</button>
			<br/><br/>
			<table id="productListGrid"></table>
			<div id="productListPager"></div>

		</div>
		<div id="productHistory">
			<input type="text" id="startDate" placeholder="시작 날짜" readonly="readonly">
			<label>~</label>
			<input type="text" id="endDate" placeholder="마지막 날짜" readonly="readonly">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button id="findProductHistoryList">조회</button>
			<br/><br/>
			<table id="productHistoryListGrid"></table>
			<div id="productHistoryListPager"></div>
		</div>

	</div>
</center>
<br/>
</body>
</html>