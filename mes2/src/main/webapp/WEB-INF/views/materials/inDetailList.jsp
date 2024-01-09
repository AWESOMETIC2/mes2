<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/materials/searchList.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/materials/inDetailList.css">
</head>
<body>
	<%@ include file="../sidehead/sidehead.jsp"%>

	<div class="container">
		<section class="section1">
			<form action="/materials/inDetailList" method="get" class="search">
				<!-- <select name="searchType"> -->
				<select name="searchType" id="searchType" class="form-select"
					aria-label="Default select example">
					<option value="pd_lot">품목코드</option>
				</select>
				<div class="input-group searchSub" style="width: 50%;">
					<input type="text" name="search" id="keyword"
						class="form-control fm" aria-label="Recipient's username"
						aria-describedby="button-addon2">
					<button class="btn btn-secondary" type="submit" id="button-addon2">검색</button>
				</div>
			</form>
			<div class="col-md-13" style="text-align: right;">
				<a href="/materials/inventory" class="btn submitDetailButton"
					style="text-align: right;">Excel Download</a>
			</div>

			<div class="list-box">
				<table class="table table-hover">
					<thead>
						<tr>
							<td></td>
							<td>입고코드</td>
							<td>로트번호</td>
							<td>품목명</td>
							<td>수량</td>
							<td>단위</td>
							<td>자재유형</td>
							<td>입고등록일</td>
							<td>진행상황</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="in" items="${inDetailList}">
							<tr>
								<td><input type="hidden" class="product_code"
									value="${in.product_code}" /></td>
								<td><c:out value="${in.in_code}" /></td>
								<td><c:out value="${in.pd_lot}" /></td>
								<td><c:out value="${in.name}" /></td>
								<td><c:out value="${in.quantity}" /></td>
								<td><c:out value="${in.unit}" /></td>
								<td><c:out value="${in.category}" /></td>
								<td><fmt:formatDate value="${in.in_regdate}"
										pattern="yyyy-MM-dd" /></td>
								<td><c:if test="${in.status.equals('complete')}">
										<button type="button" class="btn complete statusButton">완료</button>
									</c:if></td>

							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<c:if test="${pageVO.prev }">
						<li class="page-item"><a class="page-link"
							href="/materials/inDetailList?page=${pageVO.startPage - 1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>

					<c:forEach var="i" begin="${pageVO.startPage }"
						end="${pageVO.endPage }" step="1">
						<li class="page-item ${pageVO.cri.page == i ? 'active' : ''}">
							<a class="page-link" href="/materials/inDetailList?page=${i}">${i}</a>
						</li>
					</c:forEach>

					<c:if test="${pageVO.next }">
						<li class="page-item"><a class="page-link"
							href="/materials/inDetailList?page=${pageVO.endPage + 1}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
			</nav>
		</section>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous">
		
	</script>



</body>
</html>