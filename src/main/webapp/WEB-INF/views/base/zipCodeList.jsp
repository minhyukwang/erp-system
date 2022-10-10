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
body {text-align: center;font-size: 15px;}
#zipCodeComp {display: inline-table;}
#zipCodeComp td {font-size: 20px; border: 3px solid chocolate; width: 80px; height: 40px; cursor: default;}
#zipCodeComp tr:hover {background: chocolate;}
#zipCodeComp tr:nth-child(1) {background: #a85517; color: white;}
#zipCodeComp td:nth-child(5n+1), #zipCodeComp td:nth-child(5n+4), #zipCodeComp td:nth-child(5n+5) {width: 100px;}
#zipCodeComp td:nth-child(5n+3) {width: 150px;}
</style>
<script>
	$(document).ready(function() {
		$("input").button();
		$("#findDongButton").click(findZipCode);

		$("#findDongTxt").focus().keydown(function(event){
			if(event.which == 13)
				findZipCode();
		});

	});
	function findZipCode(){
		$("#zipCodeComp").html("");
		$.ajax({
			url : "${pageContext.request.contextPath}/base/zipCodeList.do",
			cache : false,
			data : {"oper":"findZipCodeList", "dong" : $("#findDongTxt").val()},
			success : function(data){
				$("<tr>",{"id":"trTag"}).appendTo("#zipCodeComp");
				$("<td>",{"html": "우편번호"}).appendTo("#trTag");
				$("<td>",{"html": "시/도"}).appendTo("#trTag");
				$("<td>",{"html": "구/군"}).appendTo("#trTag");
				$("<td>",{"html": "동"}).appendTo("#trTag");
				$("<td>",{"html": "리"}).appendTo("#trTag");
				$("<td>",{"html": "번지"}).appendTo("#trTag");
				$.each(data.addr, function(index, value){
					//alert(value.gugun);
					$("<tr>",{"id":"tr"+index}).appendTo("#zipCodeComp").click(selectAddr);
					$("<td>",{"id":"td"+value.zipcode,"html":value.zipcode}).appendTo("#tr"+index);
					$("<td>",{"id":"td"+value.sido,"html":value.sido}).appendTo("#tr"+index);
					$("<td>",{"id":"td"+value.gugun,"html":value.gugun}).appendTo("#tr"+index);
					$("<td>",{"id":"td"+value.dong,"html":value.dong}).appendTo("#tr"+index);
					$("<td>",{"id":"td"+value.ri,"html":value.ri}).appendTo("#tr"+index);
					$("<td>",{"id":"td"+value.bunji,"html":value.bunji}).appendTo("#tr"+index);
				});

			},
			error : function(a, b, c){
				alert(a+" , "+b+" , "+c);
			}
		});
	}
	function selectAddr(){
		var zip=$(this).children().eq(0).html();
		var addr1=$(this).children().eq(1).html();
		var addr2=$(this).children().eq(2).html();
		var addr3=$(this).children().eq(3).html();
		var addr4=$(this).children().eq(4).html();
		var addr=addr1+" "+addr2+" "+addr3+" "+addr4;

		opener.document.getElementById("zipCode").value = zip;
		opener.document.getElementById("address").value = addr;
		window.close();
	}
</script>
</head>
<body>
	<input type="text" id="findDongTxt" placeholder="읍/면/동">
	<input type="button" id="findDongButton" value="검색"><br/><br/>
	<table id="zipCodeComp"></table>
</body>
</html>