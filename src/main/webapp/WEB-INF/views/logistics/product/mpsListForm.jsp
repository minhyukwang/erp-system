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
#regisMpsList, #mpsHistory {font-size: 18px;}
#mpsListGrid {font-size: 15px;}
.ui-datepicker {font-size: 18px;}
input[type=text] {width: 140px;}
</style>
<script>
var row;
var lastselect;
var emptyMpsBean;
var mpsBeanList = [];
var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	$(document).ready(function() {
		$("#tabs").tabs();													//UI
		$("#workPlaceName").click(workPlaceSearch);			//사업장 코드리스트
		$("#findMpsList").click(mpsListSearch);					//그리드에 리스트 출력!!!
		$("#addMps").click(addRowMps);								//새 행 추가
		$("#saveMps").click(regisMps);

		mpsListSearch();

	});

	function mpsListSearch(){
		$.jgrid.gridUnload("#mpsListGrid");
		$("#mpsListGrid").jqGrid({
			url : '${pageContext.request.contextPath}/logistics/product/mpsList.do',
			datatype : 'json',
			postData : {'oper':'findMpsList', 'code' : $("#workPlaceCode").val()},
			cache:false,
			jsonReader:{
				page : 'page',
				total : 'total',
				root : 'list'
			},
			beforeProcessing : function(data){
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
					emptyMpsBean = data.mpsBean;
				}
			},
			editurl: "clientArray",
			colNames:[ "주문내역번호","품목코드","품목명", "주문수량","납기예정일", "현재고","계획수량","사업장", "상태"],
			colModel:[
		               {name:'orderListNo',width:12, align:'center', editable:false},
		               {name:'itemCode',width:12, align:'center', editable:false},
		               {name:'itemName',width:10, align:'center', editable:false},
		               {name:'orderQuantity',width:4, align:'center', editable:false},
		               {name:'demandDate',width:10, align:'center', editable:true},
		               {name:'stockQuantity',width:4, align:'center', editable:false},
		               {name:'planQuantity',width:4, align:'center', editable:false},
		               {name:'workplaceCode',width:5, align:'center', editable:false},
		               {name:'status',width:5, align:'center', editable:false}
		               ],
		        caption : 'MPS 관리',
		        width : 890,
		        height : 200,
		        rowNum : 8,
		        cellsubmit : "clientArray",
		        rowList : [8,16,24],
		        pager : '#mpsListPager',
		        onSelectRow: function(id) {
		            if(id && id !== lastselect) {
		               $(this).restoreRow(lastselect);
		                lastselect = id;
		            }
		            if($(this).getCell(id, "status"))
			               $(this).editRow(id, true);

		        },
		        onCellSelect : function(rowid, iCol, cellcontent, e){
		        	if(iCol == 0 || iCol == 1 || iCol == 2 || iCol == 3){					//주문내역 column
		        		row=rowid;
		        		var features = "width=580px; height=350px; left=550px; top=150px; titlebar=no; status=no";
		    	        window.open('${pageContext.request.contextPath}/logistics/business/orderList.html',
		    	        '주문내역 검색',features);
		        	}
		        	else if(iCol == 5){			//현 재고 column
		        		row=rowid;
		        		var code=$(this).getCell(rowid, "itemCode");
		        		var features = "width=580px; height=350px; left=550px; top=150px; titlebar=no; status=no";
		    	        window.open('${pageContext.request.contextPath}/logistics/item/stockQuantityList.html?code='+code,
		    	        '현재고 검색',features);
		        	}

		        }

		});
	}
	//사업장 검색 시 코드확인 및 불러오는 새창열기
	function workPlaceSearch(){
	        window.open('${pageContext.request.contextPath}/base/codeList.html?code=WP',
	        '사업장코드 검색',features);
	}
	//주문내역코드창에서 매개변수로 정보를 넘겨받음!!!
	function addOrderListInfo(data){
		$("#mpsListGrid").setCell(row, "orderListNo", data.orderListNo);
		$("#mpsListGrid").setCell(row, "itemCode", data.itemCode);
		$("#mpsListGrid").setCell(row, "itemName", data.itemName);
		$("#mpsListGrid").setCell(row, "orderQuantity", data.orderQuantity);
		$("#mpsListGrid").setCell(row, "demandDate", data.demandDate);
	}
	//현 재고 코드창에서 매개변수로 정보를 넘겨받음!!!
	function addStockQuantityListInfo(data){
		var stockQuantity=data.stockQuantity;
		var quantity=data.quantity;
		var planQuantity=$("#mpsListGrid").getCell(row, "orderQuantity")-quantity;
		//alert(planQuantity);
		if(planQuantity < 0)		//계획수량을 알기 위해 주문수량에서 현재고를 뺀다.
			planQuantity = 0;		//0보다 작으면 생산할 계획수량이 필요없어서 0으로 재할당!!
		else if(planQuantity > $("#mpsListGrid").getCell(row, "orderQuantity")){
			planQuantity = $("#mpsListGrid").getCell(row, "orderQuantity");
		}
		$("#mpsListGrid").setCell(row, "stockQuantity", stockQuantity);
		$("#mpsListGrid").setCell(row, "planQuantity", planQuantity);

	}
	//리드타임 column 에 값 넣기
	function addLeadTime(codeName){
		$("#mpsListGrid").setCell(row, "leadTime", codeName);
	}
	//MPS 행 추가
	function addRowMps(){
		if(!$("#workPlaceCode").val().trim()){
			alert("사업장 코드를 선택하세요!!");
		}else{
		 var rowNo = Number($("#mpsListGrid").getGridParam("records"));
		 	emptyMpsBean = ObjectCopy(emptyMpsBean);
		 	emptyMpsBean.status = "insert";
		    emptyMpsBean.workplaceCode=$('#workPlaceCode').val();
		       $("#mpsListGrid").addRowData(rowNo+1, emptyMpsBean);
		}
	}
	function regisMps(){
	    var rowid = $('#mpsListGrid').jqGrid('getDataIDs');
	    for(var i=1; i<=rowid.length; i++){
	        var insertList = $('#mpsListGrid').jqGrid('getRowData',i);
	      if(insertList.status !=""){
	    	  var mpsBean=ObjectCopy(emptyMpsBean);
	    	  mpsBean.orderListNo=insertList.orderListNo;
				mpsBean.itemCode=insertList.itemCode;
				mpsBean.itemName=insertList.itemName;
				mpsBean.orderQuantity=insertList.orderQuantity;
				mpsBean.demandDate=insertList.demandDate;
				mpsBean.stockQuantity=insertList.stockQuantity;
				mpsBean.planQuantity=insertList.planQuantity;
				mpsBean.workplaceCode=insertList.workplaceCode;
				mpsBean.status=insertList.status;
				mpsBeanList.push(mpsBean);
	      }
	    }
	    //var list='{"mpsBeanList":'+ $.toJSON(insertMpsList)+'}';
	    //alert(list);
	    mpsCrud();
	}
	function mpsCrud(){
		var check=confirm("등록하시겠습니까?");
		if(check){}else{
			location.href='${pageContext.request.contextPath}/logistics/product/mpsListForm.html';
			return false;
		}
		$.ajax({
		    url : '${pageContext.request.contextPath}/logistics/product/mpsRegis.do',
		    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		    type : 'post',
		    cache : false,
		    data :{'oper':'mpsCrud', 'mpsBeanList':JSON.stringify(mpsBeanList)},
		    success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("mps 등록이 완료 되었습니다.");
		    		location.href="${pageContext.request.contextPath}/logistics/product/mpsListForm.html";
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("일괄처리 오류입니다!");
		    }
		});
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
			<li><a href="#regisMpsList" id="mps">MPS관리</a></li>
			<li><a href="#mpsHistory" id="history">MPS이력조회</a></li>
		</ul>
		<div id="regisMpsList">
			<input type="hidden" id="workPlaceCode">
  			<input type="text" id="workPlaceName" placeholder="사업장 선택">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button id="findMpsList">조회</button>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;
			<button id="addMps">행 추가</button>
			<button id="saveMps">처리</button>
			<br/><br/>
			<table id="mpsListGrid"></table>
			<div id="mpsListPager"></div>

		</div>
		<div id="mpsHistory">
			<table id="mpsHistoryGrid"></table>
			<div id="mpsHistoryPager"></div>
		</div>

	</div>
</center>
<br/>
</body>
</html>