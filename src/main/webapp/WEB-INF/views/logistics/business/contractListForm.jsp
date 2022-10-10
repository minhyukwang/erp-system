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
#contractListGrid, #orderListGrid,#orderHistoryGrid {font-size: 15px;}
.ui-datepicker {font-size: 18px;}
#regisContractList, #orderHistory {font-size: 18px;}
</style>
<script>
var row;
var lastselect;
var emptyContractBean;
var emptyOrderBean;
var contractBeanList = [];
var orderBeanList = [];
var ContractBean = [];
var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	$(document).ready(function() {
		$("#tabs").tabs();									//UI
		contractListSearch();								//orderList 그리드 출력
		orderListSearch();
		$('#addContract').click(contractRowAdd);		//contractList 행추가 하기
		$('#addOrder').click(orderRowAdd);		//orderList 행추가 하기
		$("#contractCrud").click(saveContract);
		$("#historySearch").click(orderHistorySearch);

		$('#startDate').datepicker({
			dateFormat:"yy/mm/dd"
		});
		$('#endDate').datepicker({
			dateFormat:"yy/mm/dd"
		});

	});

	// 오브젝트 카피
	  function ObjectCopy(obj){
	     return JSON.parse(JSON.stringify(obj));
	  }
	function contractListSearch(){
	    $.jgrid.gridUnload("#contractListGrid");
	    $("#contractListGrid").jqGrid({
	      url : '${pageContext.request.contextPath}/logistics/business/contractList.do',
	      datatype : 'json',
	      postData : {'oper':'findOrderList'},
	      cache : false,
	      jsonReader :{
	        page : 'page',
	        total : 'total',
	        root : 'list'
	      },
	      beforeProcessing : function(data){
	        if(data.errorCode<0){
	          alert(data.errorMsg);
	        }else{
	        	ContractBean = data.list;
	          	emptyContractBean = data.contractBean;
	          	emptyOrderBean = data.orderBean;
	        }
	      },
	      colNames:["수주번호", "주문날짜","고객코드", "상태", "상세"],
	      colModel:[
	                   {name:'contractNo',width:20, align:'center', editable:true},
	                   {name:'contractDate',width:20, align:'center', editable:true,
	                     editoptions:{size:15,
	                    	dataInit:function(date){
	                       		$(date).datepicker({dateFormat:'yy/mm/dd'});
	                     		}
	                   		}
	                   },
	                   {name:'clientCode',width:20, align:'center', editable:false},
	                   {name:'status',width:10, align:'center', editable:false},
	                   {name:'orderBeanList',hidden:true}
	                   ],
	            caption : '수주등록관리',
	            width : 890,
	            height : 100,
	            clearGridData :true,
	            rowNum : 3,
	            rowList : [3,6,9],
	            cellsubmit : 'clientArray',
	            pager : '#contractListPager',
	            onSelectRow : function(id){
	            	if(id && id !== lastselect) {
		                  $(this).restoreRow(lastselect);
		                   lastselect = id;
					}
	            	if($(this).getCell(id, "status")){				//status에 무언가 들어오면 edit 할수있게 함!!
						$(this).editRow(id, true);
	            	}else{
	            		orderListSearch(id);
	            	}
	            },
	            onCellSelect: function(rowid, iCol, cellcontent, e) {
	            	if(iCol ==2){
	                      row=rowid;
	          	        window.open('${pageContext.request.contextPath}/base/codeList.html?code=CL',
	          	        '고객사코드 검색',features);
	            	}
	            }

	    });
	  }

	function addCode(code, name){				//새창에서 받은 코드를 그리드에 넣는 함수!!!
		if(name.match("CL")){
			$("#contractListGrid").setCell(row, "clientCode", code);
			$("#orderListGrid").setCell(row, "clientCode", code);
		}else{
			$("#orderListGrid").setCell(row, "itemCode", code);
		    $("#orderListGrid").setCell(row, "itemName", name);
		}
	}

	function saveContract(){
	    var rowid = $('#contractListGrid').jqGrid('getDataIDs');
	    for(var i=1; i<=rowid.length; i++){
	        var insertList = $('#contractListGrid').jqGrid('getRowData',i);
	      if(insertList.status != ""){
	        var contractBean=ObjectCopy(emptyContractBean);
	        if(insertList.contractNo != "")
	        contractBean.contractNo=insertList.contractNo;
	        else{alert("수주번호 미기입 !!"); return false;}
	        if(insertList.contractDate != "")
	        contractBean.contractDate=insertList.contractDate;
	        else{alert("주문번호 미기입 !!"); return false;}
	        if(insertList.clientCode != "")
	        contractBean.clientCode=insertList.clientCode;
	        else{alert("고객사코드 미기입 !!"); return false;}
	        contractBean.status=insertList.status;
	        contractBeanList.push(contractBean);
	      }
	    }

	    var rowid = $('#orderListGrid').jqGrid('getDataIDs');
	    for(var i=1; i<=rowid.length; i++){
	        var insertList = $('#orderListGrid').jqGrid('getRowData',i);
	      if(insertList.status !=""){
	        var orderBean=ObjectCopy(emptyOrderBean);
	        orderBean.itemCode=insertList.itemCode;
	        orderBean.orderQuantity=insertList.orderQuantity;
	        orderBean.demandDate=insertList.demandDate;
	        orderBean.contractNo=insertList.contractNo;
	        orderBean.orderListNo=insertList.orderListNo;
	        orderBean.status=insertList.status;
	        orderBeanList.push(orderBean);
	      }
	    }

	    //var list='{"contractBeanList":'+ $.toJSON(insertContractList)+',"orderBeanList":'+ $.toJSON(insertOrderList)+'}';
	    //alert(list);
	    contractCrud();
	  }

	  function contractCrud(){
	    var check=confirm("등록하시겠습니까?");
	    if(check){}else{
	      location.href='${pageContext.request.contextPath}/logistics/business/contractListForm.html';
	      return false;
	    }
	    $.ajax({
	        url : '${pageContext.request.contextPath}/logistics/business/contractRegis.do',
	        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	        type : 'post',
	        cache : false,
	        data :{'oper':'contractCrud', 'contractBeanList' : JSON.stringify(contractBeanList),'orderBeanList':JSON.stringify(orderBeanList)},
	        success : function(data, textStatus, jqXHR) {
	            alert("수주등록이 정상처리 되었습니다.");
	            location.href="${pageContext.request.contextPath}/logistics/business/contractListForm.html";
	        },
	        error : function(jqXHR, textStatus, error) {
	           alert("일괄처리 오류입니다!");
	        }
	    });
	  }

	  function orderListSearch(id){
		  $("#tabs").css("height","600px");
		  $.jgrid.gridUnload("#orderListGrid");
		    $("#orderListGrid").jqGrid({
		      data : (isNaN(id))?[]:ContractBean[id-1].orderBeanList,
		      datatype : 'local',
		      cache : false,
		      beforeProcessing : function(data){
		        if(data.errorCode<0){
		          alert(data.errorMsg);
		        }else{
		        }
		      },
		      editurl: "clientArray",
		      colNames:["주문내역번호", "주문날짜", "품목코드","품명","수량","납기예정일", "수주번호","고객코드", "납품상태", "MPS적용","상태"],
		      colModel:[
		                   {name:'orderListNo',width:15, align:'center', editable:true},
		                   {name:'contractDate',width:10, align:'center', editable:true,
		                	   editoptions:{size:15, dataInit:function(date){
									$(date).datepicker({dateFormat:'yy/mm/dd'});
									}
		                   		}
		                   },
		                   {name:'itemCode',width:15, align:'center', editable:false},
		                   {name:'itemName',width:10, align:'center', editable:false},
		                   {name:'orderQuantity',width:3, align:'center', editable:true},
		                   {name:'demandDate',width:10, align:'center', editable:true,
								editoptions:{size:15, dataInit:function(date){
									$(date).datepicker({dateFormat:'yy/mm/dd'});
									}
		                   		}
		                   },
		                   {name:'contractNo',width:10, align:'center', editable:true},
		                   {name:'clientCode',width:5, align:'center', editable:false},
		                   {name:'shippingStatus',width:5, align:'center', editable:false},
		                   {name:'mpsUse',width:5, align:'center', editable:false},
		                   {name:'status',width:5, align:'center', editable:false}
		                   ],
		            caption:'주문내역관리',
		            width:890,
		            height:160,
		            rowNum:6,
		            rowList:[6,12,18],
		            pager:'#orderListPager',
		            onSelectRow: function(id) {
		                if(id && id !== lastselect) {
		                   $(this).restoreRow(lastselect);
		                    lastselect = id;
		                }
		                if($(this).getCell(id, "status"))
		               $(this).editRow(id, true);
		                else{
		                }
		            },
		             onCellSelect: function(rowid, iCol, cellcontent, e) {
		                 var status = $(this).getCell(rowid, "status");
		                  if(iCol == 2 || iCol == 3){
		                	  row=rowid;
		                      var features = "width=320px; height=280px; left=550px; top=150px; titlebar=no; status=no";
		          	        window.open('${pageContext.request.contextPath}/base/codeList.html?code=PI',
		          	        '모품목코드 검색',features);
		                  }
		                  if(iCol == 7){
		                      row=rowid;
		                      var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
		          	        window.open('${pageContext.request.contextPath}/base/codeList.html?code=CL',
		          	        '고객사코드 검색',features);
		            	}
		            },
		            loadComplete: function(data) {

		            }
		    });
	  }

		function orderHistorySearch(){
			$.jgrid.gridUnload("#orderHistoryGrid");
			var sDate=$("#startDate").val();
			var eDate=$("#endDate").val();
		    $("#orderHistoryGrid").jqGrid({
		      url : '${pageContext.request.contextPath}/logistics/business/orderHistoryList.do',
		      datatype:'json',
		      postData : {'oper':'findOrderHistoryList', 'start':sDate,'end':eDate},
		      cache : false,
		      jsonReader:{
		        page:'page',
		        total:'total',
		        root:'list'
		      },
		      beforeProcessing : function(data){
		        if(data.errorCode<0)
		          alert(data.errorMsg);
		      },
		      editurl: "clientArray",
		      colNames:["주문내역번호", "주문날짜", "품목코드","품명","수량","납기예정일", "수주번호","고객코드","납품상태"],
		      colModel:[
		                   {name:'orderListNo',width:12, align:'center', editable:false},
		                   {name:'contractDate',width:10, align:'center', editable:false},
		                   {name:'itemCode',width:12, align:'center', editable:false},
		                   {name:'itemName',width:10, align:'center', editable:false},
		                   {name:'orderQuantity',width:3, align:'center', editable:false},
		                   {name:'demandDate',width:10, align:'center', editable:false},
		                   {name:'contractNo',width:10, align:'center', editable:false},
		                   {name:'clientCode',width:5, align:'center', editable:false},
		                   {name:'shippingStatus',width:3, align:'center', editable:false}
		                   ],
		            caption:'수주이력조회',
		            width:890,
		            height:200,
		            rowNum:10,
		            rowList:[10,20,30],
		            pager:'#orderHistoryPager'
		    });
		}

		function contractRowAdd(){						//새 행 추가!!!
		     var rowNo = Number($("#contractListGrid").getGridParam("records"));
		     emptyContractBean.status = "insert";
		           $("#contractListGrid").addRowData(rowNo+1, emptyContractBean);
		  }

	  function orderRowAdd(){						//새 행 추가!!!
		  var rowNo = Number($("#orderListGrid").getGridParam("records"));
		  	emptyOrderBean.status = "insert";
		  	emptyOrderBean.contractNo = $("#contractListGrid").getCell(row, "contractNo");
		    emptyOrderBean.shippingStatus = 'N';
		    emptyOrderBean.mpsUse = 'N';
		   $("#orderListGrid").addRowData(rowNo+1, emptyOrderBean);
	  }

</script>
</head>
<body>
<br/><br/>
<center>
	<div id="tabs">
		<ul>
			<li><a href="#regisContractList" id="contract">수주등록관리</a></li>
			<li><a href="#orderHistory" id="order">수주이력조회</a></li>
		</ul>
		<div id="regisContractList">

  			<button id="addContract">수주 행추가</button>&nbsp;&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;&nbsp;
  			<button id="addOrder">주문 행추가</button>&nbsp;&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;&nbsp;
  			<button id="contractCrud">일괄처리</button><br>
  			<table id="contractListGrid"></table>
 			<div id="contractListPager"></div>
			<br>
 			<div id="orderList">
  				<table id="orderListGrid"></table>
  				<div id="orderListPager"></div>
  			</div>

		</div>
		<div id="orderHistory">

			<input type="text" id="startDate" placeholder="시작 날짜" readonly="readonly">
			<label>~</label>
			<input type="text" id="endDate" placeholder="마지막 날짜" readonly="readonly">
			<button id="historySearch">조회</button>
			<table id="orderHistoryGrid"></table>
			<div id="orderHistoryPager"></div>

		</div>

	</div>
</center>
<br/>
</body>
</html>