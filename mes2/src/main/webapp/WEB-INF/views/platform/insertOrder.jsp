<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Document</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />
<link rel="stylesheet" href="/resources/css/platform/insertOrder.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>

<body>
	<div class="container">
		<section class="section2">
			<h1>발주 신청</h1>
			<form method="post">
				<span class="list-btn2">
					<button type="button" class="btn btn-secondary" id="addBtn"
						onclick="openProductList()">품목 추가</button>
					<button type="submit" class="btn btn-secondary">신청</button>
					<button type="button" class="btn btn-secondary">취소</button>
				</span> <br> 납품 요청일: <input id="dtIp" type="date" name="startDate"
					min="2023-12-01" max="2024-12-31" /><br> 발주 품목 <br>
				<div class="list">
					<div class="list-box">
						<table class="table table-hover">
							<thead>
								<tr class="table-success">
									<th></th>
									<th scope="col">품목코드</th>
									<th scope="col">품목명</th>
									<th scope="col">단가</th>
									<th scope="col">수량</th>
									<th scope="col">합계</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td scope="row"><input type="checkbox" class="ck" /></td>
									<td>품목코드</td>
									<td>품목명</td>
									<td>단가</td>
									<td>수량</td>
									<td>합계</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</form>
		</section>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous">
		
	</script>
	<script src="/resources/js/platform/insertOrder.js"></script>
</body>
</html>