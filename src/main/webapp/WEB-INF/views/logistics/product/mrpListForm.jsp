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
#regisMrpList, #mrpHistory {font-size: 18px;}
#mrpListGrid, #mrpGrid, #mrpHistoryListGrid {font-size: 15px;}
.ui-datepicker {font-size: 18px;}
input[type=text] {width: 130px;}
</style>
<script>
var emptyMpsBean;
var dataSetItem=[];
var mrpGatherBeanList = [];
var mrpBeanList = [];
var mpsBeanList=[];
var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	$(document).ready(function() {
		$("#tabs").tabs();													//UI
		$("#workPlaceName").click(workPlaceSearch);			//사업장 코드리스트
		$("#findMrpList").click(mrpListSearch);					//mps적용이 된 리스트 출력
		$("#unfold").click(mrpOpen);								//전개하기
		$("#gathering").click(doGatheringFunc);					//취합하기
		$("#saveAll").click(saveAllFunc);							//취합한 품목들 mrp테이블에 저장하기
		$("#findMrpHistoryList").click(mrpHistoryListSearch);			//mrp 내역 조회


		$('#startDate').datepicker({
			dateFormat:"yy/mm/dd"
		});
		$('#endDate').datepicker({
			dateFormat:"yy/mm/dd"
		});
		$('#startHisDate').datepicker({
			dateFormat:"yy/mm/dd"
		});
		$('#endHisDate').datepicker({
			dateFormat:"yy/mm/dd"
		});

	});

	function mrpListSearch(){
		var code=$('#workPlaceCode').val();
		var sDate=$('#startDate').val();
		var eDate=$('#endDate').val();
		$('#mrpListGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/product/mrpList.do',
			datatype : 'json',
			postData : {'oper':'findMpsSearchList', 'code': code, 'start': sDate, 'end': eDate },
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
					emptyMpsBean = data.mpsBean;
				}
			},
			colNames : [ '주문내역번호', '품목코드', '품목명', '계획수량', '납기요청일','사업장코드'],
			colModel : [
			    {name : 'orderListNo',width : 10, editable : false, align : "center"},
				{name : 'itemCode',	width : 10,	editable : false, align : "center"},
				{name : 'itemName',	width : 10,	editable : false, align : "center"},
				{name : 'planQuantity', width : 10,	 editable : false, align : "center"},
				{name : 'planDate',	width : 10,	editable : false, align : "center"},
				{name : 'workplaceCode',	width : 10,	editable : false, align : "center"}
			],
			width : 890,
			height : 200,
			viewrecords : true,
			rowNum : 100,
			multiboxonly : true,
			cellsubmit : 'clientArray',
			rownumbers : true,
			pager : '#mrpListPager',
			caption : 'MRP 리스트'
		});
	}
	// procedure 미적용
	/* function mpsUnfold(){
		var insertList = [];
		var rowid = $('#mrpListGrid').jqGrid('getDataIDs');
		for(var i=1; i<=rowid.length; i++){
		  var tempList = $('#mrpListGrid').jqGrid('getRowData', i);
			var mpsBean=ObjectCopy(emptyMpsBean);
			mpsBean.orderListNo=tempList.orderListNo;
			mpsBean.itemCode=tempList.itemCode;
			mpsBean.itemName=tempList.itemName;
			mpsBean.planQuantity=tempList.planQuantity;
			mpsBean.planDate=tempList.planDate;
			mpsBean.workplaceCode=tempList.workplaceCode;
			insertList.push(mpsBean);
			}
		var list='{"mpsBeanList":'+ $.toJSON(insertList)+'}';
		//alert(list);
		mrpOpen(list);
	} */
	function mrpOpen(){
		$.ajax({
		    url : '${pageContext.request.contextPath}/logistics/product/mrpOpen.do',
		    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		    type : 'post',
		    dataType : 'json',
		    cache : false,
		    data : {'oper':'mrpOpen', 'code': $('#workPlaceCode').val(), 'start': $('#startDate').val(), 'end': $('#endDate').val()},
		    success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("MRP 전개 완료 !!!");
		    		dataSetItem=data.list;
		    		mrpListOpenFunc();
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("MRP 전개 오류입니다!");
		    }
		});
	}

	function mrpListOpenFunc(){
		$.jgrid.gridUnload("#mrpGrid");
		$("#tabs").css("height","780px");
		$('#mrpGrid').jqGrid({
			data : dataSetItem,
			datatype : 'local',
			cache : false,
			colNames : [ '레벨', '품목코드', '품목명', '주문번호', '계획일자','계획수량', '모품목코드', '사업장', '구매처'],
			colModel : [
			    {name : 'level', width : 3, editable : false,align : "center"},
				{name : 'itemCode',	width : 12, editable : false,align : "center"},
				{name : 'itemName', width : 10, editable : false,align : "center"},
				{name : 'orderListNo', width : 12, editable : false,align : "center"},
				{name : 'orderDueDate', width : 10, editable : false,align : "center"},
				{name : 'orderQuantity', width : 4, editable : false,align : "center"},
				{name : 'parentCode', width : 10, editable : false,align : "center"},
				{name : 'workplaceCode',	width : 5, editable : false,align : "center"},
				{name : 'purchaseCode', width : 5, editable : false,align : "center"}
			],
			width : 890,
			height : 200,
			viewrecords : true,
			rowNum:100,
			multiboxonly : true,
			cellsubmit : 'clientArray',
			rownumbers : true,
			pager : '#mrpPager',
			caption : 'MRP 리스트'
		});
	}

	function doGatheringFunc(){
		var rowid = $('#mrpGrid').jqGrid('getDataIDs');
		for(var i=1; i<=rowid.length; i++){
		  var tempList = $('#mrpGrid').jqGrid('getRowData', i);
		  var mrpBean=new Object();
			mrpBean.level=tempList.level;
			mrpBean.itemCode=tempList.itemCode;
			mrpBean.itemName=tempList.itemName;
			mrpBean.orderListNo=tempList.orderListNo;
			mrpBean.orderDueDate=tempList.orderDueDate;
			mrpBean.orderQuantity=tempList.orderQuantity;
			mrpBean.workplaceCode=tempList.workplaceCode;
			mrpBean.purchaseCode=tempList.purchaseCode;
			mrpBean.parentCode=tempList.parentCode;
			mrpGatherBeanList.push(mrpBean);
		}
		//var list='{"mrpBeanList":'+ $.toJSON(insertList)+'}';
		//alert(list);
		mrpGathering();
	}

	function mrpGathering(){
		$.ajax({
		    url : '${pageContext.request.contextPath}/logistics/product/mrpGathering.do',
		    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		    type : 'post',
		    dataType : 'json',
		    cache : false,
		    data :{'oper':'mrpGathering', 'mrpGatherBeanList' : JSON.stringify(mrpGatherBeanList)},
		    success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("MRP 취합 완료 !!!");
		    		dataSetItem=data.list;
		    		mrpListOpenFunc();
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("MRP 취합 오류입니다!");
		    }
		});
	}

	function saveAllFunc(){
		var rowid=$("#mrpGrid").jqGrid('getDataIDs');
		for(var i=1 ; i<=rowid.length ; i++){
			var tempList=$("#mrpGrid").jqGrid('getRowData', i);
			var mrpBean=new Object();
			mrpBean.level=tempList.level;
			mrpBean.itemCode=tempList.itemCode;
			mrpBean.itemName=tempList.itemName;
			mrpBean.orderListNo=tempList.orderListNo;
			mrpBean.orderDueDate=tempList.orderDueDate;
			mrpBean.orderQuantity=tempList.orderQuantity;
			mrpBean.workplaceCode=tempList.workplaceCode;
			mrpBean.purchaseCode=tempList.purchaseCode;
			mrpBean.parentCode=tempList.parentCode;
			mrpBeanList.push(mrpBean);
		}
		//var mrpList='{"mrpBeanList":'+$.toJSON(mrpList)+'}';
		//alert(mrpList);
		saveMrp();


		var rowid=$("#mrpListGrid").jqGrid('getDataIDs');
		for(var i=1 ; i<= rowid.length ; i++){
			var tempList=$("#mrpListGrid").jqGrid('getRowData', i);
			var mpsBean=new Object();
			mpsBean.orderListNo=tempList.orderListNo;
			mpsBeanList.push(mpsBean);
		}
		//var mpsList='{"mpsBeanList":'+$.toJSON(mpsList)+'}';
		//alert(mpsList);
		modifyMrpUse();
	}
	//mrp테이블에 insert !!!
	function saveMrp(){
		$.ajax({
		    url : '${pageContext.request.contextPath}/logistics/product/mrpRegis.do',
		    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		    type : 'post',
		    dataType:'json',
		    cache:false,
		    data :{'oper':'mrpCrud', 'mrpBeanList' : JSON.stringify(mrpBeanList)},
		    complete : function(){
		    	alert("MRP 저장 완료 !!!");
		    }
		    /* success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("MRP 저장 완료 !!!");
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("MRP 저장 오류입니다!");
		    } */
		});
	}
	//MPS테이블에 mrp_use 데이터 'Y'로 수정 !!!
	function modifyMrpUse(mpsList){
		$.ajax({
		    url : '${pageContext.request.contextPath}/logistics/product/mpsModify.do',
		    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		    type : 'post',
		    dataType : 'json',
		    cache : false,
		    data :{'oper':'mpsModify', 'mpsBeanList' : JSON.stringify(mpsBeanList)},
		    complete : function(){
		    	alert("MPS > MRP_USE 수정 완료 !!!");
		    	location.href="${pageContext.request.contextPath}/logistics/product/mrpListForm.html";
		    }
		    /* success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("MPS > MRP_USE 수정 완료 !!!");
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("MPS > MRP_USE 수정 오류!");
		    } */
		});
	}

	function mrpHistoryListSearch(){
		$.jgrid.gridUnload("#mrpHistoryListGrid");
		$('#mrpHistoryListGrid').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/product/mrpHistoryList.do',
			datatype : 'json',
			postData : {'oper':'findMrpHistoryList', 'start': $('#startHisDate').val(), 'end':$('#endHisDate').val()},
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
			colNames : [ '전개번호','품목코드', '품목명', '주문번호','계획일자', '계획수량', '모품목코드','사업장코드', '구매처','발주적용'],
			colModel : [ {
				name : 'mrpNo',width : 3, editable : false, align : "center"},
				{name : 'itemCode', width : 10, editable : false, align : "center"},
				{name : 'itemName', width : 10, editable : false, align : "center"},
				{name : 'orderListNo', width : 10, editable : false, align : "center"},
				{name : 'orderDueDate', width : 10, editable : false, align : "center"},
				{name : 'orderQuantity', width : 5, editable : false, align : "center"},
				{name : 'parentCode', width : 10, editable : false, align : "center"},
				{name : 'workplaceCode', width : 5, editable : false, align : "center"},
				{name : 'purchaseCode', width : 5, editable : false, align : "center"},
				{name : 'orderUse', width : 3, editable : false, align : "center"}
			],
			width : 900,
			height : 200,
			viewrecords : true,
			rowNum : 10,
			rowList : [10,20,30],
			multiboxonly : true,
			cellsubmit : 'clientArray',
			rownumbers : true,
			pager : '#mrpHistoryListPager',
			caption : 'MRP 내역 조회'
		});
	}


	//사업장 검색 시 코드확인 및 불러오는 새창열기
	function workPlaceSearch(){
		location.href="${pageContext.request.contextPath}/logistics/product/mrpListForm.html";
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
			<li><a href="#regisMrpList" id="mrp">MRP관리</a></li>
			<li><a href="#mrpHistory" id="history">MRP이력조회</a></li>
		</ul>
		<div id="regisMrpList">
			<input type="hidden" id="workPlaceCode">
  			<input type="text" id="workPlaceName" placeholder="사업장 선택">
  			<input type="text" id="startDate" placeholder="시작 날짜" readonly="readonly">
			<label>~</label>
			<input type="text" id="endDate" placeholder="마지막 날짜" readonly="readonly">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button id="findMrpList">조회</button>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;
			<button id="unfold">전개</button>
			<button id="gathering">취합</button>
			<button id="saveAll">저장</button>
			<br/><br/>
			<table id="mrpListGrid"></table>
			<div id="mrpListPager"></div>
			<br/>
			<table id="mrpGrid"></table>
			<div id="mrpPager"></div>

		</div>
		<div id="mrpHistory">
			<input type="text" id="startHisDate" placeholder="시작 날짜" readonly="readonly">
			<label>~</label>
			<input type="text" id="endHisDate" placeholder="마지막 날짜" readonly="readonly">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button id="findMrpHistoryList">조회</button>
			<br/><br/>
			<table id="mrpHistoryListGrid"></table>
			<div id="mrpHistoryListPager"></div>
		</div>

	</div>
</center>
<br/>
</body>
</html>