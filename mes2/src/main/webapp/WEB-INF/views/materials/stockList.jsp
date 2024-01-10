<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>재고 조회</title>
<sec:csrfMetaTags/>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/materials/stockList.css">
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.1/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.1/dist/sweetalert2.all.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@700&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- 글씨체 -->
</head>

<body>
	<div class="container2">
		<%@ include file="../system/sidehead.jsp" %>
		<section class="section1">
			<form class="search" id="searchForm">
				<select name="searchType" id="searchType" class="form-select" aria-label="Default select example">
					<option value="default">구분</option>
					<option value="품목코드">품목코드</option>
					<option value="품목명">품목명</option>
				</select>
				<div class="input-group searchSub">
					<input type="text" name="search" id="search" class="form-control" placeholder="검색어를 입력하세요" aria-label="Recipient's username" aria-describedby="button-addon2">
				</div>
				<button class="btn btn-secondary" type="button" id="button-addon2" onclick="searchStock();">검색</button>
				<a href="/materials/stockList"><i class="fa-solid fa-rotate-right" id="reset"></i></a>
			</form>

			<!-- 표 -->
			<div class="list">
				<div class="list-box">
					<form class="list-form">
							<table class="table table-hover">
								<thead>
									<tr class="table-success">
										<th scope="col">품목코드</th>
										<th scope="col">품목명</th>
										<th scope="col">형상정보</th>
										<th scope="col">카테고리</th>
										<th scope="col">현재 재고</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="stockDTO" items="${stockList }">
											<tr onclick="getStockDetail('${stockDTO.product_code}');" class="selectStock">
												<td><input type="hidden" name="product_code${loop.index}" value="${stockDTO.product_code}">${stockDTO.product_code}</td>
												<td><input type="hidden" name="product_code${loop.index}" value="${stockDTO.name}">${stockDTO.name}</td>
												<td><input type="hidden" name="image${loop.index}" ><img alt="형상정보" src="" ></td>
												<td><input type="hidden" name="name${loop.index}" value="${stockDTO.category}">${stockDTO.category}</td>
												<td><input type="hidden" name="price${loop.index}" value="${stockDTO.quantity}">${stockDTO.quantity} ${stockDTO.unit}</td>
											</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 페이징 -->
							<div class="box-footer clearfix">
								<div style="margin: 0 auto; width: fit-content;">
								<ul class="pagination pagination-sm no-margin pull-right">
								
									<c:if test="${pageVO.prev }">
										<li><a href="/materials/stockList?page=${pageVO.startPage - 1 }&searchType=${searchDTO.searchType }&search=${searchDTO.search }">«</a></li>
									</c:if>
									
									<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
										<li><a href="/materials/stockList?page=${i }&searchType=${searchDTO.searchType }&search=${searchDTO.search }">${i }</a></li>
									</c:forEach>
									
									<c:if test="${pageVO.next }">
										<li><a href="/materials/stockList?page=${pageVO.endPage + 1 }&searchType=${searchDTO.searchType }&search=${searchDTO.search }">»</a></li>
									</c:if>
								</ul>
								</div>
							</div>
							<!-- 페이징 끝 -->
					</form>
				</div>
			</div>
		</section>
	</div>
	
	<script src="${pageContext.request.contextPath}/resources/js/materials/stock/stockList.js"></script>
</body>
</html>