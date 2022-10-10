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
#shippingListGrid, #shippingHistoryGrid {font-size: 15px;}
.ui-datepicker {font-size: 18px;}
#regisShippingList, #shippingHistory {font-size: 18px;}
</style>
<script>
var row;
var lastselect;
var emptyShippingBean;
var shippingBeanList=[];
var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	$(document).ready(function() {
		$("#tabs").tabs();													//UI
		$("#clientCodeName").click(clientCodeSearch);			//고객사 코드 불러오기
		$("#findShippingList").click(shippingListSearch);		//납품 할 리스트 가져오기
		$("#saveShipping").click(saveShippingFunc);			//납품등록하기
		$("#historySearch").click(shippingHistoryListSearch);		//납품 내역 조회하기

		$('#startDate').datepicker({
			dateFormat:"yy/mm/dd"
		});
		$('#endDate').datepicker({
			dateFormat:"yy/mm/dd"
		});

	});

	function shippingListSearch(){
		$.jgrid.gridUnload("#shippingListGrid");
		$('#shippingListGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/business/shippingList.do',
			datatype : 'json',
			postData : {'oper':'findShippingList', 'code': $('#clientCode').val()},
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
					emptyShippingBean = data.shippingBean;
				}
			},
			colNames : [ '고객사','주문내역번호', '품목코드', '품목명','계획수량','계획일','현재재고','출하수량', '출하일', '담당자', '출하일련번호','상태'],
			colModel : [
				{name : 'clientCode', width : 5, editable : false, align : "center"},
				{name : 'orderListNo', width : 15, editable : false, align : "center"},
				{name : 'itemCode', width : 14, editable : false, align : "center"},
				{name : 'itemName', width : 12, editable : false, align : "center"},
				{name : 'orderQuantity', width : 5, editable : false, align : "center"},
				{name : 'demandDate', width : 12, editable : false, align : "center"},
				{name : 'stockQuantity', width : 5, editable : false, align : "center"},
				{name : 'shippingQuantity', width : 5, editable : true, align : "center"},
				{name : 'shippingDate', width : 12,align : "center", editable : true,
                    editoptions:{size : 15, dataInit:function(date){
                        $(date).datepicker({dateFormat : 'yy/mm/dd'});
                      }
					}
				},
				{name : 'empName', width : 6, editable :false, align : "center"},
				{name : 'shippingNo', width : 12, editable :true, align : "center"},
				{name : 'status', width : 5, editable : false, align : "center"}
			],
			width : 900,
			height : 200,
			viewrecords : true,
			rowNum : 10,
			rowList : [10,20,30],
			multiboxonly : true,
			editurl : 'clientArray',
			rownumbers : true,
			pager : '#shippingListPager',
			caption : '납품관리 리스트',
			onSelectRow: function(id) {
				if(id && id !== lastselect) {
				        $(this).restoreRow(lastselect);
				          lastselect = id;
				       }
				       $(this).editRow(id, true);
				   },
			onCellSelect: function(rowid, iCol, cellcontent, e) {
				if(iCol==10 || iCol==8 || iCol==9 || iCol==11){
					$("#shippingListGrid").setCell(rowid, 'empName', '${sessionScope.name}');
					$("#shippingListGrid").setCell(rowid, 'status', 'insert');
				 }else if(iCol=7){
	            	   row=rowid;
	                	stockInfoSearch($(this).getCell(rowid, "itemCode"));
	             }
	       }
		});
	}
	//남품정보 등록
	function saveShippingFunc(){

		var rowid=$("#shippingListGrid").jqGrid('getDataIDs');
		for(var i=1 ; i<=rowid.length ; i++){
			var tempList=$("#shippingListGrid").jqGrid('getRowData', i);
			if(tempList.status !=""){
				var shippingBean=ObjectCopy(emptyShippingBean);
				shippingBean.shippingNo=tempList.shippingNo;
				shippingBean.shippingDate=tempList.shippingDate;
				shippingBean.shippingQuantity=tempList.shippingQuantity;
				shippingBean.orderListNo=tempList.orderListNo;
				shippingBean.itemCode=tempList.itemCode;
				shippingBean.empName=tempList.empName;
				shippingBean.status=tempList.status;
				shippingBeanList.push(shippingBean);
				}
			}
			//var list='{"shippingBeanList":'+ $.toJSON(shippingList)+'}';
			//alert(list);
			shippingCrud();
	}

	function shippingCrud(){
		var check=confirm("등록하시겠습니까?");
		if(check){}else{
			location.href='${pageContext.request.contextPath}/logistics/business/shippingListForm.html';
			return false;
		}
		$.ajax({
		    url : '${pageContext.request.contextPath}/logistics/business/shippingRegis.do',
		    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		    type : 'post',
		    cache : false,
		    data :{'oper':'shippingCrud', 'shippingBeanList' : JSON.stringify(shippingBeanList)},
		    success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("shipping Crud 완료 !!!");
		    		location.href="${pageContext.request.contextPath}/logistics/business/shippingListForm.html";
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("일괄처리 오류입니다!");
		    }
		});
	}

	function shippingHistoryListSearch(){
		$.jgrid.gridUnload("#shippingHistoryGrid");
		$('#shippingHistoryGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/business/shippingHistoryList.do',
			datatype : 'json',
			postData : {'oper':'findShippingHistoryList', 'start': $('#startDate').val(), 'end':$('#endDate').val()},
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
			colNames : [ '고객사','주문내역번호','품목코드', '품목명', '출하수량','출하일', '담당자', '출하일련번호'],
			colModel : [ {
				name : 'clientName',width : 7,	editable : false,align : "center"},
				{name : 'orderListNo',	width : 13,	editable : false,align : "center"},
				{name : 'itemCode',	width : 13,	editable : false,align : "center"},
				{name : 'itemName',	width : 10,	editable : false,align : "center"},
				{name : 'shippingQuantity',	width : 5,	editable : false,align : "center"},
				{name : 'shippingDate',	width : 13,	editable : false,align : "center"},
				{name : 'empName',	width : 10,	editable : false,align : "center"},
				{name : 'shippingNo',	width : 13,	editable : false,align : "center"}
			],
			width : 900,
			height : 200,
			viewrecords : true,
			rowNum : 10,
			rowList : [10,20,30],
			multiboxonly : true,
			cellsubmit : 'clientArray',
			rownumbers : true,
			pager : '#shippingHistoryPager',
			caption : '납품 내역 조회'
		});
	}

	//새창에서 받아오는 현재고를 그리드에 입력 !!!
	function addStockQuantityListInfo(data){
		$("#shippingListGrid").setCell(row, 'stockQuantity', data.stockQuantity);
	}

	//납품 나갈 수 있는 재고 리스트
	function stockInfoSearch(code){
		var features = "width=580px; height=360px; left=550px; top=150px; titlebar=no; status=no";
		window.open('${pageContext.request.contextPath}/logistics/item/stockQuantityList.html?code='+code,
				'재고정보검색',features);
	}

	//고객사 코드 Search !!!
	function clientCodeSearch(){
		 window.open('${pageContext.request.contextPath}/base/codeList.html?code=CL',
			        '고객사코드 검색',features);
	}

	// 오브젝트 카피
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
			<li><a href="#regisShippingList">납품등록관리</a></li>
			<li><a href="#shippingHistory">납품내역조회</a></li>
		</ul>
		<div id="regisShippingList">

  			<input type="hidden" id="clientCode">
  			<input type="text" id="clientCodeName" placeholder="고객사 선택">
  			<button id="findShippingList">조회</button>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;
  			<button id="saveShipping">저장</button><br><br>
  			<table id="shippingListGrid"></table>
 			<div id="shippingListPager"></div>

		</div>
		<div id="shippingHistory">

			<input type="text" id="startDate" placeholder="시작 날짜" readonly="readonly">
			<label>~</label>
			<input type="text" id="endDate" placeholder="마지막 날짜" readonly="readonly">
			<button id="historySearch">조회</button>
			<table id="shippingHistoryGrid"></table>
			<div id="shippingHistoryPager"></div>

		</div>

	</div>
</center>
<br/>
</body>
</html>