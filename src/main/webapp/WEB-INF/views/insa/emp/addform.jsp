<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="${pageContext.request.contextPath}/jqGrid/jquery.json-2.3.js"></script>
<title>Insert title here</title>
<style type="text/css">
input[type=text] {width: 200px; font-size: 18px;}
input[type=button], input[type=reset] {font-size: 18px;}
label {font-size: 20px;}
.addTable {display: inline-table;}
.detailTable td:nth-child(2n+1) {width: 130px; text-align: left;}
.detailTable td:nth-child(2n+2) {width: 350px; text-align: left;}
.imgComp {display: inline-block; border: 1px solid black; width: 200px; height: 250px;}
.imgComp img {display: inline-block; width: 200px; height: 250px;}
.ui-datepicker {font-size: 18px;}
#startEmail, #endEmail {width: 100px;}
select {width: 130px;}
</style>
<script>
	var empBean;
	var empBeanList;
	var features = "width=390px; height=340px; left=550px; top=150px; titlebar=no; status=no";
	$(document).ready(function(){
		var imgFilename; //템프파일이름
		var realFileName; //실제파일이름
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
				reader.onload = function(e) {
					//파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
					$('#targetImg').attr('src', e.target.result);
					//이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
					//(아래 코드에서 읽어들인 dataURL형식)
				}
				reader.readAsDataURL(input.files[0]);
				//File내용을 읽어 dataURL형식의 문자열로 저장
			}
		}//readURL()--

		$("#tmpfile").change(function() {
			//alert(this.value); //선택한 이미지 경로 표시
			readURL(this);
		});

		$("#hireDate").datepicker({dateFormat:"yy/mm/dd"});

		$('#deptCodeButton').click(function(){
	        window.open('${pageContext.request.contextPath}/base/codeList.html?code=DP','부서 검색',features);
		});
		$('#deptTelButton').click(function(){
	        window.open('${pageContext.request.contextPath}/base/codeList.html?code=DT','부서 검색',features);
		});
		$('#titleButton').click(function(){
	        window.open('${pageContext.request.contextPath}/base/codeList.html?code=RK','직급 검색',features);
		});
		$('#zipButton').click(function(){
			var features = "width=630px; height=400px; left=400px; top=150px; titlebar=no; status=no;";
	        window.open('${pageContext.request.contextPath}/base/zipCodeList.html','우편번호 검색',features);
		});

		$("#saveButton").click(function(){
			//alert($("#tmpfile").val());
			$("#addImgForm").submit();
		});

		setEmpId();
		$("#addEmpButton").click(empInsert);

	});

	$('#addImgForm').ajaxForm({
		dataType:'json',
	    success: function(responseText, statusText, xhr, $form){
			if(responseText.errorCode<0){
				alert(responseText.errorMsg);
			}else{
		    	imgFilename=responseText.imgFilename; //내가 정한 파일의 이름을 리턴해줌.
		    	realFileName=responseText.realFileName;
		    	//alert(realFileName);
		    	//부모창에 이미지 파일이름을 전달해준다.
		    	$("#tempFilename").val(imgFilename);
		    	$("#realImgFileName").val(realFileName);
		    	alert($("#tempFilename").val());
		    	alert($("#realImgFileName").val());
	    		alert('사진이 저장되었습니다.');
	    	}
		}
	});

	function setEmpId(){
		$.ajax({
			url: '${pageContext.request.contextPath}/insa/emp/empId.do',
			dataType:'json',
			data : {"oper":"getEmptyBean"},
			cache:false,
		 	success: function(data){
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
	 				empBean=ObjectCopy(data.emptyEmpBean);
	 			}
		 	}
		});
	}
	//오브젝트 카피
	function ObjectCopy(obj){
		 return JSON.parse(JSON.stringify(obj));
	}
	//사원등록하기
	function empInsert(){

		empBeanList=[];
		empBean.empId=$("#empId").val();
		empBean.empName=$("#empName").val();
		empBean.gender=$("#gender :checked").val();
		empBean.hiredate=$("#hireDate").val();
		empBean.empTel=$("#empTel").val();
		empBean.empPhone=$("#empPhone").val();
		empBean.zipcode=$("#zipCode").val();
		empBean.address=$("#address").val();
		empBean.email=$("#email").val();
		empBean.position=$("#position").val();
		empBean.deptNo=$("#deptCode").val();
		empBean.empPw=$("#empPw").val();
		empBean.image=$("#realImgFileName").val();
		empBean.detailAddr=$("#addressDetail").val();
		empBean.tempImage=$("#tempFilename").val();
		empBean.status="insert";
		empBeanList.push(empBean);	//empBean에 세팅한 값을 List에 push.
		//var list='{"empBeanList":'+$.toJSON(empBeanList)+'}'; //json형태로 만듬.
		//alert(JSON.stringify(empBeanList));
		empRegis();
	}
	//리스트 받아서 Controller에 넘겨주기 ajax
	function empRegis(){
		var check=confirm("사원 정보를 등록하시겠습니까?");	//변수에 담아서 확인해야함. 아니면 안나옴
		if(check){}else{
			location.href='${pageContext.request.contextPath}/insa/emp/addform.html';
			return false;
		}
		$.ajax({
		    url : '${pageContext.request.contextPath}/insa/emp/empRegis.do',
		    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		    type : 'post',
		    cache : false,
		    data :{'oper':'empCrud', 'empBeanList':JSON.stringify(empBeanList)},
		    success : function(data, textStatus, jqXHR) {
				if(data.errorCode<0){
					alert(data.errorMsg);
				}else{
		    		alert("등록 되었습니다.");
		    		/* location.href="${pageContext.request.contextPath}/emp/addform.html"; */
		    		window.location.reload(true);
		    	}
		    },
		    error : function(jqXHR, textStatus, error) {
		     	alert("일괄처리 오류입니다!");
		    }
		});
	}

</script>
</head>
<body>
<br/><br/>
	<table class="addTable">
		<tr>
			<td style="width: 300px;">
			<table><tr><td>
			<form  id='addImgForm' action="${pageContext.request.contextPath}/base/imageSave.do?oper=imgUpload"
														enctype="multipart/form-data" name="addImgForm" method="post">
				<input type="hidden" id="tempFilename" name="tempImgFilename">
				<input type="hidden" id="realImgFileName" name="realImgFileName">
				<div class="imgComp">
					<img id="targetImg" src="#"/>
				</div>
				<input type=file id="tmpfile" name="tmpfile" style="display: none;"><br/>
				<input type="button" onclick="document.getElementById('tmpfile').click();" id='findB' value="찾아보기">
				<input type="button" id='saveButton' value="저장">
			</form>
				</td></tr></table>
			</td>
			<td>
				<table class="detailTable">
					<tr>
						<td><label>아이디</label></td>
						<td><input type=text id="empId" name="empId" placeholder="아이디를 입력해 주세요"></td>
					</tr>
					<tr>
						<td><label>비밀번호</label></td>
						<td><input type=text id="empPw" name="empPw" placeholder="비밀번호를 입력해 주세요"></td>
					</tr>
					<tr>
						<td><label>이름</label></td>
						<td><input type=text id="empName" name="empName" placeholder="이름을 입력해 주세요"></td>
					</tr>
					<tr>
						<td><label>부서코드</label></td>
						<td><input type=text id="deptCode" name="deptCode" readonly="readonly" placeholder="부서코드를 선택해 주세요">
						<input type="button" id="deptCodeButton" value="+"></td>
					</tr>
					<tr>
						<td><label>전화번호</label></td>
						<td><input type=text id="empTel" name="empTel" readonly="readonly" placeholder="부서코드를 선택해 주세요">
						<input type="button" id="deptTelButton" value="+"></td>
					</tr>
					<tr>
						<td><label>직급</label></td>
						<td><input type=text id="position" name="position" readonly="readonly" placeholder="직급을 선택해 주세요">
						<input type="button" id="titleButton" value="+"></td>
					</tr>
					<tr>
						<td><label>성별</label></td>
						<td>
							<div id="gender"><input type="radio" id="male" name="gender" value="남성"><label for="male" style="font-size: 18px;">남성</label>
							<input type="radio" id="female" name="gender" value="여성"><label for="female" style="font-size: 18px;">여성</label></div>
						</td>
					</tr>
					<tr>
						<td><label>입사일</label></td>
						<td><input type=text id="hireDate" name="hireDate" readonly="readonly" placeholder="입사일을 선택해 주세요"></td>
					</tr>
					<tr>
						<td><label>E-Mail</label></td>
						<td><input type="text" id="email" name="email" placeholder="E-Mail을 입력해 주세요"></td>
					</tr>
					<tr>
						<td><label>우편번호</label></td>
						<td><input type=text id="zipCode" name="zipCode" readonly="readonly" placeholder="우편번호 선택해 주세요">
						<input type="button" id="zipButton" value="우편번호"></td>
					</tr>
					<tr>
						<td><label>주소</label></td>
						<td><input type=text id="address" name="address" readonly="readonly" placeholder="우편번호를 선택해 주세요"></td>
					</tr>
					<tr>
						<td><label>상세주소</label></td>
						<td><input type=text id="addressDetail" name="addressDetail" size=25 placeholder="상세주소를 선택해 주세요"></td>
					</tr>
					<tr>
						<td><label>휴대폰번호</label></td>
						<td><input type=text id="empPhone" name="empPhone"  placeholder="휴대폰 번호를 입력해 주세요"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table><br/>
	<input type="reset" value="취소">
	<input type="button" id="addEmpButton" value="사원등록">
<br/><br/>
</body>
</html>