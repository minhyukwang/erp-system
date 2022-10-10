<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/jqGrid/jquery.json-2.3.js"></script>
<title>Insert title here</title>
<style type="text/css">
#itemGroupCodeList {font-size: 18px;}
#itemList {font-size: 18px;}
#gridCode {font-size: 18px;}
.itemGroupList {display: inline-table; width: 950px;}
input[type=text],input[type=button] {font-size: 20px;}
#itemGroupName {cursor:pointer; width: 120px;}
.ui-dialog-titlebar{height: 10px; }
</style>
<script>
var bomBeanList;
var index;
var row;
var emptyBomBean;
var lastselect;
var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	$(document).ready(function() {
		$("#itemGroupName").click(findCodeListFunc);
		$("#findItemListButton").click(itemListFunc);
		$("#addItemListButton").click(addRowFunc);
		$("#processItemListButton").click(processFunc);
	});

	function findCodeListFunc(){
	        window.open('${pageContext.request.contextPath}/base/codeList.html?code=IG','코드 검색',features);
	}

	function addRowFunc(){
		var nextRowId=$("#itemList").getGridParam("records");
		//emptyBomBean=ObjectCopy(emptyBomBean);
		emptyBomBean.status="insert";
		$("#itemList").addRowData(nextRowId+1,emptyBomBean);
	}

	function itemListFunc(){
		$.jgrid.gridUnload("#itemList");
		var code=$("#itemGroupCode").val();
		$('#itemList').jqGrid({
			url : '${pageContext.request.contextPath}/logistics/item/itemBomList.do',
			datatype : 'json',
			postData : {'oper':'findItemBomList', 'code':code},
			jsonReader : {
				page : 'page',
				total : 'total',
				root : 'list'
			},
			beforeProcessing : function(data) {
				if (data.errorCode < 0) {
					alert(data.errorMsg);
				} else {
					dataSetItem=data.list;
		            emptyBomBean = ObjectCopy(data.bomBean);
				}
			},
			editurl : 'clientArray',
			colNames : [ '품목코드', '품명', '모품목코드', '대개', '단위', '구매처코드', '단가', '손실률', '소요일', '고객코드', '계정','조달', '상태' ],
			colModel : [
				{name : 'itemCode', width : 20, editable : true, align : "center"},
				{name : 'itemName', width : 10, editable : true, align : "center"},
				{name : 'parentCode', width : 20, editable : false, align : "center"},
				{name : 'quantity', width : 5, editable : true, align : "center"},
				{name : 'unit', width : 5, editable : true, align : "center"},
				{name : 'purchaseCode', width : 10, editable : false, align : "center"},
				{name : 'price', width : 10, editable : true, align : "right"},
				{name : 'lossFactor', width : 5, editable : true, align : "center"},
				{name : 'leadTime', width : 5, editable : true, align : "center"},
				{name : 'clientCode', width : 10, editable : false, align : "center"},
				{name : 'grade', width : 5, editable : false, align : "center"},
				{name : 'procurementCode', width : 5, editable : false, align : "center"},
				{name : 'status', width : 10, editable : false, align : "center"}
			],
			ondblClickRow : function(id) {
				if(id && id !== lastselect) {
	                  $(this).restoreRow(lastselect);
	                   lastselect = id;
				}
				$(this).editRow(id, true);
			},
			onCellSelect: function(rowid, iCol, cellcontent, e) {
                var status = $(this).getCell(rowid, "status");
                  if(iCol ==1){
                     if(status != "insert") {
                     if($(this).getCell(rowid, "status") == "delete"){
                       }else{
                          $(this).setCell(rowid, "status", "delete");
                       }
                     }
                  }else{
                   if(iCol ==11){
                      row=rowid;
                      codeInfo("CL");
                      $("#dialogCode").dialog();
                   }else if(iCol==12){
                      row=rowid;
                      codeInfo("GD");
                      $("#dialogCode").dialog();
                   }else if(iCol==13){
                      row=rowid;
                      codeInfo("PE");
                      $("#dialogCode").dialog();
                   }else if(iCol==4){
                       row=rowid;
                       codeInfo("PI");
                       $("#dialogCode").dialog();
                    }else if(iCol==7){
                        row=rowid;
                        codeInfo("PC");
                        $("#dialogCode").dialog();
                     }
                   if(status != "insert") {
                        $(this).setCell(rowid, "status", "update");
                   }

                   }
           },
			width : 950,
			height : 200,
			rowNum : 7,
			rowList : [7,14,21],
			multiselect: true,
			clearGridData :true,
			rownumbers : true,
			cellEdit:true,
			sortname : 'itemCode',
			sortorder : 'desc',
			sortable : true,
			cellsubmit : 'clientArray',
			pager : '#pager',
			caption : '품목리스트'
		});

	}


	function codeInfo(ci){
	    $.jgrid.gridUnload("#gridCode");
	     $("#gridCode").jqGrid({
	           url:'${pageContext.request.contextPath}/base/detailCodeList.do?oper=getCodeList&code='+ci,
	           datatype : 'json',
	           jsonReader : {page:'page',root:'list',total:'total'},
	           colNames : ["코드","코드명"],
	           colModel : [
	            {name:'detailCode',width:10, align:'center', editable:false},
	            {name:'detailCodeName',width:5, align:'center', editable:false}
	           ],
	           width : 255,
	           height : 160,
	           onSelectRow : function (id){
	           if(ci=='CL'){
	              $("#itemList").setCell(row, "clientCode",  $('#gridCode').getCell(id, 'detailCode'));
	           }else if(ci=='GD'){
	              $("#itemList").setCell(row, "grade",  $('#gridCode').getCell(id, 'detailCode'));
	           }else if(ci=='PI'){
	              $("#itemList").setCell(row, "parentCode",  $('#gridCode').getCell(id, 'detailCode'));
	           }else if(ci=='PC'){
	              $("#itemList").setCell(row, "purchaseCode",  $('#gridCode').getCell(id, 'detailCode'));
	           }else if(ci=='PE'){
	              $("#itemList").setCell(row, "procurementCode",  $('#gridCode').getCell(id, 'detailCode'));
	           }
	             $('#dialogCode').dialog('close');
	           },
	           rowNum:10,
	           caption:'코드리스트',
	           rowList:[3,6,9]
	           });
	     }

	function processFunc(){
		bomBeanList=[];

		var rowId = $("#itemList").jqGrid('getDataIDs');

		for(var i=1; i<=rowId.length; i++){
			var updateList=$("#itemList").jqGrid('getRowData', i);
			if(updateList.status != ""){
			emptyBomBean=ObjectCopy(emptyBomBean);

			emptyBomBean.itemCode=updateList.itemCode;
			emptyBomBean.itemName=updateList.itemName;
			emptyBomBean.parentCode=updateList.parentCode;
			emptyBomBean.quantity=updateList.quantity;
			emptyBomBean.unit=updateList.unit;
			emptyBomBean.purchaseCode=updateList.purchaseCode;
			emptyBomBean.price=updateList.price;
			emptyBomBean.lossFactor=updateList.lossFactor;
			emptyBomBean.leadTime=updateList.leadTime;
			emptyBomBean.clientCode=updateList.clientCode;
			emptyBomBean.grade=updateList.grade;
			emptyBomBean.procurementCode=updateList.procurementCode;
			emptyBomBean.status=updateList.status;

			bomBeanList.push(emptyBomBean);
			}
		}
			//var list='{"emptyBomBean":'+$.toJSON(insertDataList)+'}';
			//alert(list);
			//alert(JSON.stringify(bomBeanList));
			doProcess();

	}

	function doProcess(){			//일괄처리를 하면 item, bom, detailcode 테이블이 추가,수정,삭제가 됨!!!
		var check=confirm("등록 하시겠습니까?");	//변수에 담아서 확인해야함. 아니면 안나옴
		if(check){}else{
			location.href='${pageContext.request.contextPath}/logistics/item/itemListForm.html';
			return false;
		}
		$.ajax({
	        url: '${pageContext.request.contextPath}/logistics/item/bomRegis.do',
	        data:{"oper":"bomCrud", "bomBeanList":JSON.stringify(bomBeanList)},
	 		type : 'post',
	    	dataType:'json',
	        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	        complete:function(){
	        	 alert("일괄 처리 되었습니다.");
	             $("#itemList").trigger('reloadGrid');
	          }
	      });
	        /* success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("등록 되었습니다.");
		    		 $("#itemList").trigger('reloadGrid');
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("일괄처리 오류입니다!>>");
		    }
		}); */
	}

	function ObjectCopy(obj){		//copy
	 	 return JSON.parse(JSON.stringify(obj));
	 }
</script>
</head>
<body>
<br/><br/>
	<table class="itemGroupList">
		<tr>
			<td>
				<input type="text" id="itemGroupName" placeholder="품목군 확인" readonly="readonly">&nbsp;&nbsp;&nbsp;
				<input type="hidden" id="itemGroupCode">
				<input type="button" id="findItemListButton" value="조회">&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;
				<input type="button" id="addItemListButton" value="추가">
				<input type="button" id="processItemListButton" value="일괄처리">
				<input type="hidden" id="itemGroupCode">
			</td>
		</tr>
		<tr>
			<td style="height: 350px;">
				<br/>
				<center>
					<table id="itemList"></table>
					<div id="pager"></div>
				</center>
				&nbsp;
			</td>
		</tr>
	</table>
<br/><br/>
	<div id="dialogCode">
		 <center>
         <table id="gridCode"></table>
         </center>
      </div>
</body>
</html>