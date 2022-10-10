<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- jqGrid CSS & SCRIPT -->
<script src="${pageContext.request.contextPath}/jqGrid/js/jquery-1.11.0.min.js"></script>
<script src="${pageContext.request.contextPath}/jqGrid/js/i18n/grid.locale-en.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/jqGrid/css/ui.jqgrid.css" />
<script src="${pageContext.request.contextPath}/jqGrid/js/jquery.jqGrid.min.js"></script>
<!-- jQuery-ui CSS & SCRIPT -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui/jquery-ui.css" />
<script src="${pageContext.request.contextPath}/jquery-ui/jquery-ui.js"></script>
<style type="text/css">
#codeList {font-size: 20px;}
</style>
<script>
var rowid = $("#orderListGrid", opener.document).jqGrid('getGridParam', 'selrow');
	$(document).ready(function() {
		codeList();
	});
	function codeList() {
		$('#codeList').jqGrid({
			url : '${pageContext.request.contextPath}/base/detailCodeList.do',
			datatype : 'json',
			postData : {"oper" : "getCodeList", "code":"${param.code}"},
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
				}
			},
			colNames : [ '코드', '코드명'],
			colModel : [ {
				name : 'detailCode',
				width : 20,
				editable : false,
				align : "center"
			}, {
				name : 'detailCodeName',
				width : 20,
				editable : false,
				align : "center"
			} ],
			onSelectRow : function(id) {
				index = id - 1;
				var code="${param.code}";
				if(code.match("IG"))
					insertItemGroup();
				else if(code.match("RK"))
					insertTitle();
				else if(code.match("PI"))
					insertParentItem();
				else if(code.match("CI"))
					insertChildItem();
				else if(code.match("DP"))
					insertDeptNo();
				else if(code.match("DT"))
					insertDeptTel();
				else if(code.match("CL"))
					insertClient();
				else if(code.match("WP"))
					insertWorkPlace();
				else if(code.match("LT"))
					insertLeadTime();
				else if(code.match("PC"))
					insertPurchase();

			},
			width : 400,
			height : 300,
			viewrecords : true,
			multiboxonly : true,
			cellsubmit : 'clientArray',
			rowNum : 100,
			rownumbers : true,
			sortname : 'detailCode',
			sortorder : 'desc',
			sortable : true,
			/* pager : '#pager', */
			caption : '코드검색'
		});
		function insertItemGroup() {
			var codeName = dataset[index].detailCodeName;
			var codeNum = dataset[index].detailCode;
			//opener.document.getElementById("itemGroupName").value = codeName;
			//opener.document.getElementById("itemGroupCode").value = codeNum;
			$("#itemGroupCode",opener.document).val(codeNum);
			$("#itemGroupName",opener.document).val(codeName);
			window.close();
		}
		function insertTitle() {
			var codeName = dataset[index].detailCodeName;
			//opener.document.getElementById("position").value = position;
			$("#position",opener.document).val(codeName);
			window.close();
		}
		function insertParentItem() {
			var codeName = dataset[index].detailCodeName;
			var codeNum = dataset[index].detailCode;
			if(opener.document.getElementById("parentItemCode")){
				opener.document.getElementById("parentItemCode").value = codeNum;
				opener.document.getElementById("pItemName").value = codeName;
			}else{
				opener.parent.addCode(codeNum, codeName);
			}
				window.close();

		}
		function insertChildItem() {
			var codeName = dataset[index].detailCodeName;
			var codeNum = dataset[index].detailCode;
			opener.document.getElementById("childItemCode").value = codeNum;
			opener.document.getElementById("cItemName").value = codeName;
			window.close();
		}
		function insertDeptNo() {
			var codeNum = dataset[index].detailCode;
			opener.document.getElementById("deptCode").value = codeNum;
			window.close();
		}
		function insertDeptTel() {
			var codeName = dataset[index].detailCodeName;
			opener.document.getElementById("empTel").value = codeName;
			window.close();
		}
		function insertClient() {
			var codeNum = dataset[index].detailCode;
			var codeName = dataset[index].detailCodeName;
			if(opener.document.getElementById("clientCode")){
				opener.document.getElementById("clientCode").value = codeNum;
				opener.document.getElementById("clientCodeName").value = codeName;
				}else{
					opener.parent.addCode(codeNum, '${param.code}');
				}
				window.close();
		}
		function insertWorkPlace(){
			var codeNum = dataset[index].detailCode;
			var codeName = dataset[index].detailCodeName;
			if(opener.document.getElementById("workPlaceCode")){
				$("#workPlaceCode",opener.document).val(codeNum);
				$("#workPlaceName",opener.document).val(codeName);
			}else{
				opener.parent.addWorkPlaceCode(codeName);
			}
			window.close();
		}
		function insertLeadTime(){
			var codeName = dataset[index].detailCodeName;
			opener.parent.addLeadTime(codeName);
			window.close();
		}
		function insertPurchase(){
			var codeNum = dataset[index].detailCode;
			var codeName = dataset[index].detailCodeName;
			$("#purchaseCode", opener.document).val(codeNum);
			$("#purchaseName", opener.document).val(codeName);
			window.close();
		}
	}
</script>
</head>
<body>
	<center>
	<table id="codeList"></table>
	<div id="pager"></div>
	</center>
</body>
</html>