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
#purchasePrint, #purchasePrintHistory {font-size: 18px;}
#purchaseListGrid, #purchasePrintHistoryGrid, #purchaseDetailListGrid {font-size: 15px;}
.ui-datepicker {font-size: 18px;}
input[type=text] {width: 140px;}
</style>
<script>
var lastselect;
var emptyPurchaseOrderBean;
var purchaseOrderNoCode;
var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	$(document).ready(function() {
		$("#tabs").tabs();														//UI
		$("#purchaseName").click(purchaseCodeSearch);			//거래처코드 받아오기
		$("#findPurchase").click(purchaseSearch);
		purchaseSearch();
		$("#printPdf").click(printPdfFunc);								//PDF 출력
		$("#savePurchase").click(saveFunc);							//저장하기
		$("#findPurchasePrintHistory").click(printHistorySearch);	//PDF 출력 이력조회

		$('#startDate').datepicker({
			dateFormat:"yy/mm/dd"
		});
		$('#endDate').datepicker({
			dateFormat:"yy/mm/dd"
		});

	});

	function purchaseSearch(){
		$.jgrid.gridUnload("#purchaseListGrid");
		$('#purchaseListGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/product/purchaseOrderPrint.do',
			datatype : 'json',
			postData : {'oper':'findPurchasePrintList', 'code': $('#purchaseCode').val()},
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
			colNames : [ '발주번호', '발주일', '구매처명', '발주상태'],
			colModel : [
			    {name : 'purchaseOrderNo', width : 14, editable : false, align : "center"},
				{name : 'orderDate', width : 10, editable : false, align : "center"},
				{name : 'purchaseName', width : 10, editable : false, align : "center"},
				{name : 'orderStatus', width : 10, editable : false, align : "center"}
			],
			width : 500,
			height : 70,
			viewrecords : true,
			rowNum : 3,
			rowList : [3,6,9],
			multiboxonly : true,
			cellsubmit : 'clientArray',
			rownumbers : true,
			pager : '#purchaseListPager',
			caption : '발주리스트',
			onSelectRow : function(id) {
                if(id && id !== lastselect) {
                   $(this).restoreRow(lastselect);
                    lastselect = id;
                }
                purchaseDetail($(this).getCell(id, "purchaseOrderNo"));
            }
		});
	}
	//발주상세정보 보기
	function purchaseDetail(purchaseOrderNo){
		 $("#tabs").css("height","650px");
		 $.jgrid.gridUnload("#purchaseDetailListGrid");
		$('#purchaseDetailListGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/product/purchaseOrderPrintDetail.do',
			datatype : 'json',
			postData : {'oper':'findPurchasePrintDetailList', 'code' : purchaseOrderNo},
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
					emptyPurchaseOrderBean = data.purchaseOrderBean;
				}
			},
			colNames : [ '발주번호', '발주일', '품목코드', '품목명', '수량', '단위', '담당자', '전화번호', '납품요구일','구매처명', '구매처담당자', '구매처전화번호'],
			colModel : [
			    {name : 'purchaseOrderNo', width : 13, editable : false, align : "center"},
				{name : 'orderDate', width : 12, editable : false, align : "center"},
				{name : 'itemCode', width : 15, editable : false, align : "center"},
				{name : 'itemName', width : 10, editable : false, align : "center"},
				{name : 'quantity',	width : 3, editable : false, align : "center"},
				{name : 'unit', width : 3, editable : false, align : "center"},
				{name : 'empName', width : 7, editable : false, align : "center"},
				{name : 'empTel', width : 15, editable : false, align : "center"},
				{name : 'targetDate', width : 12, editable : false, align : "center"},
				{name : 'purchaseName', width : 10, editable : false, align : "center"},
				{name : 'operator',	width : 7, editable : false, align : "center"},
				{name : 'purchaseTel', width : 15, editable : false, align : "center"},
			],
			width : 900,
			height : 200,
			viewrecords : true,
			rowNum:100,
			multiboxonly : true,
			cellsubmit : 'clientArray',
			rownumbers : true,
			pager : '#purchaseDetailListPager',
			caption : '발주서 출력 상세 리스트'
		});

	}
	//PDF출력하기
	function printPdfFunc(){
		var rowId = $('#purchaseDetailListGrid').jqGrid('getRowData', 1);
		purchaseOrderNoCode=rowId.purchaseOrderNo;
		//alert(code);
		pdfFunc(purchaseOrderNoCode);
		$("#savePurchase").css("visibility","visible");
	}

	function pdfFunc(code){
		var check=confirm("출력 하시겠습니까?");
		if(check){}else{
			location.href='${pageContext.request.contextPath}/logistics/product/purchasePrintForm.html';
			return false;
		}
		window.open("${pageContext.request.contextPath}/base/pdfPrint.do?code=" + code, "발주서 출력", "width=1080, height=800, top=100");
	}
	//저장하기
	function saveFunc(){
		//alert(purchaseOrderNoCode);
		var check=confirm("저장 하시겠습니까?");
		if(check){}else{
			location.href='${pageContext.request.contextPath}/logistics/product/purchasePrintForm.html';
			return false;
		}
		$.ajax({
		    url : '${pageContext.request.contextPath}/logistics/product/purchaseOrderRegis.do',
		    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		    type : 'post',
		    cache : false,
		    data :{'oper':'purchaseOrderCrud', 'code' : purchaseOrderNoCode },
		    success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("purchaseOrder 저장 완료 되었습니다.");
		    		location.href="${pageContext.request.contextPath}/logistics/product/purchasePrintForm.html";
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("일괄처리 오류입니다!");
		    }
		});
	}


	function printHistorySearch(){
		$.jgrid.gridUnload("#purchasePrintHistoryGrid");
		$('#purchasePrintHistoryGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/product/purchaseOrderPrintHistory.do',
			datatype : 'json',
			postData : {'oper':'findPurchaseOrderPrintHistoryList', 'start': $('#startDate').val(), 'end':$('#endDate').val()},
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
			colNames : [ '발주번호', '발주일', '품목코드', '품목명', '수량', '단위', '담당자','구매처명', '구매처담당자','발주상태'],
			colModel : [
				{name : 'purchaseOrderNo', width : 15, editable : false, align : "center"},
				{name : 'orderDate', width : 13, editable : false, align : "center"},
				{name : 'itemCode', width : 13, editable : false, align : "center"},
				{name : 'itemName', width : 10, editable : false, align : "center"},
				{name : 'quantity',	width : 5, editable : false, align : "center"},
				{name : 'unit', width : 5, editable : false, align : "center"},
				{name : 'empName', width : 10, editable : false, align : "center"},
				{name : 'purchaseName', width : 10, editable : false, align : "center"},
				{name : 'operator',	width : 10,	editable : false, align : "center"},
				{name : 'orderStatus', width : 5, editable : false, align : "center"}
			],
			width : 900,
			height : 200,
			viewrecords : true,
			rowNum : 10,
			rowList : [10,20,30],
			multiboxonly : true,
			cellsubmit : 'clientArray',
			rownumbers : true,
			pager : '#purchasePrintHistoryPager',
			caption : '발주서 출력 내역 조회'
		});
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
			<li><a href="#purchasePrint">발주서출력</a></li>
			<li><a href="#purchasePrintHistory">발주서조회</a></li>
		</ul>
		<div id="purchasePrint">
			<input type="hidden" id="purchaseCode">
  			<input type="text" id="purchaseName" placeholder="구매처 선택">&nbsp;&nbsp;&nbsp;
			<button id="findPurchase">조회</button>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;
			<button id="printPdf">출력</button>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;
			<button id="savePurchase" style="visibility : hidden;">저장</button>
			<br/><br/>
			<table id="purchaseListGrid"></table>
			<div id="purchaseListPager"></div>
			<br>
  				<table id="purchaseDetailListGrid"></table>
  				<div id="purchaseDetailListPager"></div>
		</div>

		<div id="purchasePrintHistory">
			<input type="text" id="startDate" placeholder="시작 날짜" readonly="readonly">
			<label>~</label>
			<input type="text" id="endDate" placeholder="마지막 날짜" readonly="readonly">
			<input type="button" id="findPurchasePrintHistory" value="조회">
			<br/><br/>
			<table id="purchasePrintHistoryGrid"></table>
			<div id="purchasePrintHistoryPager"></div>
		</div>

	</div>
</center>
<br/>
</body>
</html>