<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
ul {list-style: none;}
.nav_menu {clear:both; position:relative; background:#aa8472; height:40px; line-height:40px; width:980px; margin:0 auto;}
.nav_menu a {color: white;}
.nav_menu > ul > li > a {cursor: default;}
.nav_menu .menu {float:left; width:140px; height:40px; /*border-right:1px solid #CCC;*/ font-size:20px; color:#333; margin-left: 0px;} /* 대분류 메뉴 */
.nav_menu .menu:hover {background:#513e22; font-weight:bold; color:white;}  /* 대분류 메뉴에 마우스를 오버했을때 */
.nav_menu .menu:hover a {color:white;}
.nav_menu .menu:hover .open_menu{display:block;} /* 대분류에 마우스를 오버하면 서브메뉴는 */

.nav_menu .menu .open_menu {clear:both; display:none; background:#fdefe8; width:450px;}
/* .nav_menu .menu .open_menu li {border-top:1px solid #fff; } */
.nav_menu .menu .open_menu li {float: left; border: 2px dashed #9B470D; padding-left: 10px; padding-right: 10px;}
.nav_menu .menu .open_menu li a{color: #9B470D;}
.nav_menu .menu .open_menu li:hover {background:#674f2c;}
.nav_menu .menu .open_menu li:hover a {color: white;}
</style>
<script type="text/javascript">
	$(document).ready(function() {

	});
</script>
</head>
<body>
<c:if test="${! empty sessionScope.name}">
	<div class="nav_menu">
		<ul>
			<li class="menu">
				<a>인사관리</a>
				<div class="open_menu">
					<ul>
						<li><a href="${pageContext.request.contextPath}/insa/emp/addform.html">사원등록</a></li>
						<li><a href="${pageContext.request.contextPath}/insa/emp/listform.html">사원관리</a></li>
					</ul>
				</div>
			</li>
			<li class="menu">
				<a>기초정보</a>
				<div class="open_menu">
					<ul>
						<li><a href="${pageContext.request.contextPath}/logistics/item/stockListForm.html">재고관리</a></li>
						<li><a href="${pageContext.request.contextPath}/logistics/item/itemListForm.html">품목관리</a></li>
						<li><a href="${pageContext.request.contextPath}/logistics/item/bomListForm.html">BOM조회</a></li>
					</ul>
				</div>
			</li>
			<li class="menu">
				<a>생산관리</a>
				<div class="open_menu">
					<ul>
						<li><a href="${pageContext.request.contextPath}/logistics/product/mpsListForm.html">MPS관리</a></li>
						<li><a href="${pageContext.request.contextPath}/logistics/product/mrpListForm.html">MRP관리</a></li>
						<li><a href="${pageContext.request.contextPath}/logistics/product/productListForm.html">생산실적관리</a></li>
					</ul>
				</div>
			</li>
			<li class="menu">
				<a>영업관리</a>
				<div class="open_menu">
					<ul>
						<li><a href="${pageContext.request.contextPath}/logistics/business/contractListForm.html">수주관리</a></li>
						<li><a href="${pageContext.request.contextPath}/logistics/business/shippingListForm.html">납품관리</a></li>
					</ul>
				</div>
			</li>
			<li class="menu">
				<a>구매관리</a>
				<div class="open_menu">
					<ul>
						<li><a href="${pageContext.request.contextPath}/logistics/product/purchaseListForm.html">구매계획관리</a></li>
						<li><a href="${pageContext.request.contextPath}/logistics/product/purchasePrintForm.html">발주서출력</a></li>
					</ul>
				</div>
			</li>
			<li class="menu">
				<a>거래처관리</a>
				<div class="open_menu">
					<ul>
						<li><a href="#">고객사관리</a></li>
						<li><a href="#">구매처관리</a></li>
					</ul>
				</div>
			</li>
			<li class="menu">
				<a href="#" style="cursor: pointer;">사내게시판</a>
			</li>
		</ul>
	</div>
</c:if>
</body>
</html>