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
#purchaseList, #purchaseHistory {font-size: 18px;}
#purchaseListGrid, #purchaseHistoryGrid {font-size: 15px;}
.ui-datepicker {font-size: 18px;}
input[type=text] {width: 140px;}
</style>
<script>
var row;
var lastselect;
var emptyMrpBean;
var mrpBeanList = [];
var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	$(document).ready(function() {
		$("#tabs").tabs();														//UI
		$("#purchaseName").click(purchaseCodeSearch);			//거래처코드 받아오기
		$("#findPurchaseList").click(purchaseListSearch);		//구매계획 리스트
		$("#savePurchase").click(savePurchaseFunc);
		$("#findPurchaseHistoryList").click(purchaseHistoryListSearch);

		$('#startDate').datepicker({
			dateFormat:"yy/mm/dd"
		});
		$('#endDate').datepicker({
			dateFormat:"yy/mm/dd"
		});

	});

	function purchaseListSearch(){
		$.jgrid.gridUnload("#purchaseListGrid");
		$('#purchaseListGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/product/purchaseOrder.do',
			datatype : 'json',
			postData : {'oper':'findPurchaseOrderList', 'code': $('#purchaseCode').val()},
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
					emptyMrpBean = data.mrpBean;
				}
			},
			colNames : [ '구매처', '품목코드', '품목명','수량','납기일','전개번호', '주문내역번호', '발주일','사업장명', '담당자', '발주번호', '상태'],
			colModel : [
				{name : 'purchaseCode', width : 6, editable : false, align : "center"},
				{name : 'itemCode',	width : 16,	editable : false, align : "center"},
				{name : 'itemName',	width : 10,	editable : false, align : "center"},
				{name : 'orderQuantity', width : 4, editable : false, align : "center"},
				{name : 'orderDueDate', width : 12, editable : false, align : "center"},
				{name : 'mrpNo',	width : 5,	editable : false, align : "center"},
				{name : 'orderListNo',width : 18, editable : false, align : "center"},
				{name : 'orderDate',width : 12,	align : "center", editable : true,
	                editoptions:{size : 15, dataInit : function(date){
	                    $(date).datepicker({dateFormat : 'yy/mm/dd'});
	                  }
					}
				},
				{name : 'workplaceName',	width : 10,	editable : false, align : "center"},
				{name : 'empName',	width : 6, editable : false, align : "center"},
				{name : 'purchaseOrderNo', width : 13, editable : true,align : "center"},
				{name : 'status',	width : 7,	editable : false, align : "center"}
			],
			width : 900,
			height : 200,
			viewrecords : true,
			rowNum : 10,
			rowList : [10,20,30],
			multiboxonly : true,
			editurl : 'clientArray',
			pager : '#purchaseListPager',
			caption : '구매계획 리스트',
			onSelectRow: function(id) {
				if(id && id !== lastselect) {
				        $(this).restoreRow(lastselect);
				          lastselect = id;
				       }
				       $(this).editRow(id, true);
				   },
				   onCellSelect: function(rowid, iCol, cellcontent, e) {
					   if(iCol ==8){
					     row=rowid;
					     workplaceCodeSearch("WP");
					   }
					   else if(iCol==9){
						   $("#purchaseListGrid").setCell(rowid, 'status', 'insert');
						   $("#purchaseListGrid").setCell(rowid, 'empName', '${sessionScope.name}');
					   }
				   }
		});
	}

	function savePurchaseFunc(){

		var rowid = $('#purchaseListGrid').jqGrid('getDataIDs');
		for(var i=1; i<=rowid.length; i++){
		  var tempList = $('#purchaseListGrid').jqGrid('getRowData', i);
		  if(tempList.status !=""){
			var mrpBean=ObjectCopy(emptyMrpBean);
			mrpBean.purchaseCode=tempList.purchaseCode;
			mrpBean.itemCode=tempList.itemCode;
			mrpBean.itemName=tempList.itemName;
			mrpBean.orderListNo=tempList.orderListNo;
			mrpBean.orderDueDate=tempList.orderDueDate;
			mrpBean.orderQuantity=tempList.orderQuantity;
			mrpBean.workplaceName=tempList.workplaceName;
			mrpBean.empName=tempList.empName;
			mrpBean.mrpNo=tempList.mrpNo;
			mrpBean.orderDate=tempList.orderDate;
			mrpBean.purchaseOrderNo=tempList.purchaseOrderNo;
			mrpBeanList.push(mrpBean);
		  }
		}
		//var list='{"mrpBeanList":'+ $.toJSON(insertList)+'}';
		//alert(list);
		purchaseCrud();
	}

	function purchaseCrud(){
		var check=confirm("등록하시겠습니까?");
		if(check){}else{
			location.href='${pageContext.request.contextPath}/logistics/product/purchaseListForm.html';
			return false;
		}
		$.ajax({
		    url : '${pageContext.request.contextPath}/logistics/product/purchaseRegis.do',
		    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		    type : 'post',
		    cache : false,
		    data :{'oper':'purchaseCrud', 'mrpBeanList' : JSON.stringify(mrpBeanList)},
		    success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("purchase Crud 완료 되었습니다.");
		    		location.href="${pageContext.request.contextPath}/logistics/product/purchaseListForm.html";
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("일괄처리 오류입니다!");
		    }
		});
	}

	function purchaseHistoryListSearch(){
		var sDate=$("#startDate").val();
		var eDate=$("#endDate").val();
		$.jgrid.gridUnload("#purchaseHistoryGrid");
		$('#purchaseHistoryGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/product/purchaseOrderHistory.do',
			datatype : 'json',
			postData : {'oper':'findPurchaseOrderHistoryList', 'start': sDate, 'end': eDate},
			cache : false,
			jsonReader : {
				page : 'page',
				total : 'total',
				root : 'list'
			},
		 	beforeProcessing : function(data) {
				if (data.errorCode < 0) {
					alert(data.errorMsg);
				} else {}
			},
			colNames : [ '발주번호', '전개번호','구매처명','발주일자' ,'품목코드', '품목명','수량','납기일자' , '담당자','발주적용'],
			colModel : [
				{name : 'purchaseOrderNo',width : 10,	editable : false, align : "center"},
				{name : 'mrpNo',width : 4, editable : false, align : "center"},
				{name : 'purchaseName', width : 12, editable : false, align : "center"},
				{name : 'orderDate', width : 10, editable : false, align : "center"},
				{name : 'itemCode', width : 14, editable : false, align : "center"},
				{name : 'itemName', width : 10, editable : false, align : "center"},
				{name : 'quantity',	width : 4, editable : false, align : "center"},
				{name : 'targetDate', width : 10, editable : false, align : "center"},
				{name : 'empName', width : 6, editable : false, align : "center"},
				{name : 'orderStatus', width : 4, editable : false, align : "center"}
			],
			width : 900,
			height : 230,
			viewrecords : true,
			rowNum : 10,
			rowList : [10,20,30],
			multiboxonly : true,
			cellsubmit : 'clientArray',
			rownumbers : true,
			pager : '#purchaseHistoryPager',
			caption : '발주이력 리스트'
		});
	}

	//검색 해온 사업장명 입력
	function addWorkPlaceCode(code){
		$("#purchaseListGrid").setCell(row, 'workplaceName', code)
	}

	//사업장 검색 시 코드확인 및 불러오는 새창열기
	function workplaceCodeSearch(code){
	        window.open('${pageContext.request.contextPath}/base/codeList.html?code='+code,
	        '사업장코드 검색',features);
	}
	//거래처 검색 시 코드확인 및 불러오는 새창열기
	function purchaseCodeSearch(){
	        window.open('${pageContext.request.contextPath}/base/codeList.html?code=PC',
	        '거래처코드 검색',features);
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
			<li><a href="#purchaseList">구매계획관리</a></li>
			<li><a href="#purchaseHistory">발주이력조회</a></li>
		</ul>
		<div id="purchaseList">
			<input type="hidden" id="purchaseCode">
  			<input type="text" id="purchaseName" placeholder="구매처 선택">
			<button id="findPurchaseList">조회</button>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;
			<button id="savePurchase">저장</button>
			<br/><br/>
			<table id="purchaseListGrid"></table>
			<div id="purchaseListPager"></div>

		</div>
		<div id="purchaseHistory">

			<input type="text" id="startDate" placeholder="시작 날짜" readonly="readonly">
			<label>~</label>
			<input type="text" id="endDate" placeholder="마지막 날짜" readonly="readonly">
			<input type="button" id="findPurchaseHistoryList" value="조회">
			<br/><br/>
			<center>
			<table id="purchaseHistoryGrid"></table>
			<div id="purchaseHistoryPager"></div>
			</center>

		</div>

	</div>
</center>
<br/>
</body>
</html>