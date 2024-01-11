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

<link rel="stylesheet" href="/resources/css/production/productList.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>

<body>
	<%@ include file="../system/sidehead.jsp" %>
	<!-- 검색창 -->
	<div class="container">
		<section class="section1">
      <form action="/product/search" class="search" method="GET">
        <select id="boundary">
          <option value="">-- 검색선택 --</option>
          <option value="ship">수주번호</option>
          <option value="order">주문번호</option>
          <option value="order">거래항목</option>
          <option value="order">수주처</option>
          <option value="order">수주일</option>
          <option value="order">납기요청일</option>
        </select>

        <div>
          <span class="search-font">검색시작일</span>
          <input id="startDate" type="date" min="2023-12-01" max="2024-12-31" name="startDate" value="${startDate}"/>

          <span class="search-font">검색종료일</span>
          <input
            id="endDate"
            type="date"
            min="2020-01-01"
            max="2030-12-31"
            width="100px"
            name="endDate"
            value="${endDate}"
          />
        </div>

        <input type="text"  placeholder="검색어를 입력하세요" name="name"/>
        <input type="submit" value="검색" />
      </form>

      <!-- 표 -->
      <div class="list">
      
        <div class="list-btn">
          <button type="button" class="btn btn-secondary" id="delete-btn">긴급탈출버튼</button>
        </div>

        <div class="list-box">
          <form id="main-form" class="list-form">
            <table class="table table-hover">
            
             <colgroup>
				<col style="width: 3%" /> 
                <col style="width: 15%" /> 
                <col style="width: 7%" />
                <col style="width: 30%" />
                <col style="width: 10%" />
                <col style="width: 10%" />
                <col style="width: 15%" />
              </colgroup>
              <thead>
                <tr class="table-success">
                  <th></th>
                  <th scope="col">LOT No.</th>
                  <th scope="col">생산품</th>
                  <th scope="col">수주번호</th>
                  <th scope="col">수량</th>
                  <th scope="col">사용기한</th>
                  <th scope="col">생산날짜</th>
              
                </tr>
              </thead>
              <tbody>
              <c:forEach var="product" items="${productList}">
              	<tr>
                  <td scope="row"><input type="checkbox" class="ck" name="lot" value="${product.pd_lot}"/></td>
                  <td><a href="상세보기확인">${product.pd_lot}</a></td>
                  <td>${product.pd_mdp_code}</td>
                  <td>${product.pd_soi_id}</td>
                  <td>${product.pd_quantity}</td>
                  <td>${product.pd_period}</td>
                  <td>${product.pd_date}</td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </form>
        </div>
      </div>
      
      <!-- 페이징 -->
			<div class="box-footer clearfix">
				<div style="margin: 0 auto; width: fit-content;">
				<ul class="pagination pagination-sm no-margin pull-right">
				
					<c:if test="${pageVO.prev }">
						<li><a href="/instructions/search?page=${pageVO.startPage - 1 }&searchType=${searchType }&startDate=${startDate }&endDate=${endDate}">«</a></li>
					</c:if>
					
					<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
						<li><a href="/instructions/search?page=${i }&searchType=${searchType}&startDate=${startDate }&searchState=${searchState}&endDate=${endDate}">${i }</a></li>
					</c:forEach>
					
					<c:if test="${pageVO.next }">
						<li><a href="/instructions/search?page=${pageVO.endPage + 1 }&searchType=${searchType}&searchState=${searchState}&startDate=${startDate }&endDate=${endDate}">»</a></li>
					</c:if>
				</ul>
				</div>
			</div>
			<!-- 페이징 끝 -->
    </section>

		<div id="bottomContent"></div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous">
	</script>
	<script src="/resources/js/platform/orderList.js"></script>
	
	<script>
	
    function openIsSave(){
        window.open("/instructions/save","save","width=800px, height=640px")
    }
	</script>
	
</body>
</html>