<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<link rel="stylesheet" href="/resources/css/production/request.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.1/dist/sweetalert2.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.1/dist/sweetalert2.all.min.js"></script>
</head>

<body>
	<%@ include file="../system/sidehead.jsp" %>
	<!-- 검색창 -->
	<div class="container">
		<section class="section1">
			<form class="search" action="/instructions/request">

				
				<input type="text" name="code" placeholder="수주번호 "   class="form-control aria-label="Recipient's username" aria-describedby="button-addon2" style="width:200px;"/>

				<input type="submit" value="검색" class="btn btn-secondary"/>
			</form>

			<!-- 표 -->
			<div class="list">
			
			
				<div class="list-btn">
					<button type="button" class="btn btn-secondary" id="deletebtn">긴급탈출버튼</button>
				</div>
				

				<div class="list-box">
						<table class="table table-hover">
							<colgroup>
								<col style="width: 3%" /> 
                    			<col style="width: 10%" /> 
                    			<col style="width: 7%" />
                    			<col style="width: 10%" />
                    			<col style="width: 20%" />
                    			<col style="width: 7%" />
                    			<col style="width: 7%" />
                			</colgroup>
							<thead>
								<tr class="table-success">
									<th></th>
									<th scope="col">작업지시번호</th>
									<th scope="col">라인</th>
									<th scope="col">제품번호</th>
									<th scope="col">수주번호</th>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${instructions}">
									<tr>
										<td scope="row"><input type="checkbox" class="ck" /></td>
										<td><a href="">${item.code}</a></td>
										<td>${item.line}</td>
										<td onclick="getMaterials('${item.mdpCode}')">${item.mdpCode}</td>
										<td onclick="getMaterials('${item.sopCode}','${item.salesQuantity }')">${item.sopCode}</td>
										<td>
										<!-- 현재 공백 -->
										</td>
										<td>
											<c:if test="${item.materialStatus.equals('Y') }">
												<input type="hidden" name="sopCode" value="${item.sopCode}">
												<button type="submit" class="btn btn-secondary" id="accept" onclick="window.open('/instructions/accept/${item.sopCode}','result','width=800px, height=640px')">수락</button>
											</c:if>
											<c:if test="${item.materialStatus.equals('N')}">
												자재필요
											</c:if>
											<c:if test="${item.materialStatus.equals('R')}">
												자재준비중
											</c:if>
										</td>
					
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
				</div>
			</div>
			
			
		</section>
		<br><br><br><br>
		<!-- 페이징 -->
			<div class="box-footer clearfix">
				<div style="margin: 0 auto; width: fit-content;">
				<ul class="pagination pagination-sm no-margin pull-right">
				
					<c:if test="${pageVO.prev }">
						<li><a href="/instructions/request?page=${pageVO.startPage - 1 }&searchType=${searchType }&searchStartDate=${startDate }&searchEndDate=${endDate}">«</a></li>
					</c:if>
					
					<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
						<li><a href="/instructions/request?page=${i }&searchType=${searchType}&searchStartDate=${startDate }&code=${code}&searchEndDate=${endDate}"> ${i }&nbsp;  </a></li>
					</c:forEach>
					
					<c:if test="${pageVO.next }">
						<li><a href="/instructions/request?page=${pageVO.endPage + 1 }&searchType=${searchType}&code=${code}&searchStartDate=${startDate}&searchEndDate=${endDate}">»</a></li>
					</c:if>
				</ul>
				</div>
			</div>
			<!-- 페이징 끝 -->
		
		<section class="section1">
			<div id="bottomContent">
		
		
			</div>
		</section>

	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous">
	</script>
	<script src="/resources/js/instructions/request.js"></script>
	
	<script>
	
    function openInput(){
        window.open("/instructions/save","save","width=800px, height=640px")
    }
    function openAccept(){
        window.open("/instructions/accept","accept","width=800px, height=640px")
    }
    
   
	</script>
	
</body>
</html>