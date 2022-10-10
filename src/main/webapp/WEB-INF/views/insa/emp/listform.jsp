<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
#grid {
	font-size: 20px;
}
#pager {z-index: 1;}
#dialog {z-index: 2;}
input[type=button] {font-size: 20px;}
.listTable {display: inline-table;}
#deptSearch {font-size: 20px; text-align: center; overflow: hidden; width: 100px;}
</style>
<script>
	$(document).ready(function(){
		$("#searchEmpList").click(empListFunc);
		empListFunc();
	});

	function empListFunc(){
		var deptList='';
		$('#deptSearch option:selected').each(function (x, selected){
			deptList += $.trim($(selected).val())+',';
		});
		$.jgrid.gridUnload("#grid");
		$('#grid').jqGrid({
			url:'${pageContext.request.contextPath}/insa/emp/list.do',
			cache : false,
			datatype:'json',
			postData : {'oper':'findEmpList','dept':deptList},
			jsonReader:{
				page : 'page',
				total : 'total',
				root : 'list'
			},
			beforeProcessing : function(data) {
				if (data.errorCode < 0) {
					alert(data.errorMsg);
				} else {
					dataset = data.list;//emplist
					empBean = data.empBean; //사원정보보기에서 텍스트에 데이터 넣어주기 위해 빈 필요.
				}
			},
			rowNum:3,
			colNames:['사원번호','이름','직급','부서명','전화번호'],
			colModel:[
				{name:'empNo',width:30, align:"center", editable:true},
				{name:'empName',width:30, align:"center", editable:true},
				{name:'position',width:30, align:"center", editable:true},
				{name:'deptName',width:20, align:"center", editable:true},
				{name:'empTel',width:50, align:"center", editable:true}
			],
			ondblClickRow : function(id) {
				index = id - 1;
				empDetailFunc();
			},
			width:'650',
			height:'170',
			rowNum: 6,
			viewrecords: true,
			rowList:[3,6,9],
			pager:'#pager',
			caption:'직원리스트'
			/* multiselect: true */
		});
		listDept=[];
	}

	function empDetailFunc(){
		var empId=dataset[index].empId;
		var empNo=dataset[index].empNo;
		var features = "width=800px; height=560px; left=300px; top=70px; titlebar=no; status=no";
        var detailWin=window.open('${pageContext.request.contextPath}/insa/emp/detailform.html?empId='+empId+'&empNo='+empNo,'직원 상세정보',features);
        $("#grid").trigger("reloadGrid");
    }
</script>
</head>
<body>
<br/>

	<table class="listTable">
		<tr>
			<td style="width:130px;">
			<center>
				<select id="deptSearch" multiple="multiple" size="7">
				  <option value="10">경영부</option>
				  <option value="20">영업부</option>
				  <option value="30">생산부</option>
				  <option value="40">구매부</option>
				  <option value="50">관리부</option>
				  <option value="60">품질관리부</option>
				  <option value="70">연구개발부</option>
				</select>
				<button id="searchEmpList" style="font-size: 15px; margin-top: 5px;">SEARCH</button>
			</center>
			</td>
			<td style="width:700px; ">
			<center>
				<table id="grid"></table>
				<div id="pager"></div>
			</center>
			</td>
		</tr>
	</table>





<br/>
</body>
</html>