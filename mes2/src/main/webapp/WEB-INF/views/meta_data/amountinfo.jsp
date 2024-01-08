<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>BOM기준정보</title>

<!--  sweetalert cdn입니다. -->
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.1/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.1/dist/sweetalert2.all.min.js"></script>


<!-- jqery cdn입니다-->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- 부트스트랩 css cdn입니다. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />

<!-- 추가 css 입니다. -->
<link rel="stylesheet" href="/resources/css/metadata/amount.css">

<!--  부트스트랩 js cdn입니다. -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous">
</script>

<!-- 추가 js 입니다. -->
<script src="/resources/js/metadata/amount.js"></script>
</head>

<body>
<%@ include file="../system/sidehead.jsp" %>
	<!-- 내용 칸 -->
	<div class="son_container">
		<!-- 검색창,추가 버튼,취소 버튼 -->	
		<div class="son_serch">
			<form action="/amount/firstpage" method="POST">
				<span></span>			
				<input type="text" name="search" placeholder="완제품 코드를 입력하세요" />
				<input type="submit" value="검색"/>
			</form>
			
			<div class="son_list-btn">			
				<button type="button" class="btn btn-secondary" id="addbtn" onclick="replaceButton()">추가</button>							
				<button type="button" class="btn btn-secondary" id="updatebtn" onclick="replaceButton2()">수정</button>						
				<button type="button" class="btn btn-secondary" id="canclebtn" onclick="redirectToFirstPage()" style="display: none;">취소</button>
			</div>			
		</div>		
			
			

		<!-- 테이블 -->									
		<table class="table table-hover">
			
			<!--테이블 헤드 -->
			<thead>
				<tr class="table-success" id="table_head">
					<th scope="col"></th>
					<th scope="col" style="width: 0px; "></th>
					<th scope="col">완제품코드</th>
					<th scope="col">원재료코드</th>
					<th scope="col">용량</th>
					<th scope="col">단위</th>
					<th scope="col">등록날짜</th>
					<th scope="col">수정날짜</th>													
					<th scope="col"></th>									
				</tr>
			</thead>
			
			<!-- 테이블 바디 -->				
			<tbody>
				<!-- 거래처 추가시 생기는 행 -->				
				<tr id="insert_hang" style="display: none; text-align: center; vertical-align: middle;">										
					<td></td>							
					<td></td>																				
					<td><select id="ins_pcode" name="ins_productcode"></select></td>
					<td><select id="ins_mcode" name="ins_meterialcode"></select></td>										    								      												
					<td><input type="text" id="amount" name="amount" size="5"></td>
					<td><select id="ins_unit" name="ins_unit"></select></td>
					<td>[등록날짜]</td>				
					<td>[수정날짜]</td>																															
					<td><button type="button" class="btn btn-secondary" id="submitbtn" onclick="submitData()" style="display: none;">저장</button></td>														
				</tr>	
						
				<!-- 거래처리스트 행들을 가져옴 -->								
				<c:forEach var="alist" items="${amountList }">
				<tr style="text-align: center; vertical-align: middle; ">
					
					<!-- 거래처 리스트 -->
					<td><input type="checkbox" class="updatecheckbox" style="display: none;" onchange="a(this)"/></td>															
					<td class="a"></td>
					<td class="a">${alist.product_code }</td>
					<td class="a">${alist.material_code }</td>
					<td class="a">${alist.amount }</td>
					<td class="a">${alist.amount_unit }</td>
					<td class="a">${alist.registration_date }</td>
					<td class="a">${alist.modification_date }</td>					
					<td class="a" style="content: '\00a0'"></td>				
									
					<!-- 거래처 수정 시 나타나는 행 -->									
					<td class="b" style="display: none;"><input type="hidden" name="index" value="${alist.index }"></td>
					<td class="b" style="display: none;"><select id="upd_pcode" name="product_code"></select></td>
					<td class="b" style="display: none;"><select id="upd_mcode" name="material_code"></select></td>
					<td class="b" style="display: none;"><input type="text" name="amount" size="5" value="${alist.amount }"></td>
					<td class="b" style="display: none;"><select id="upd_unit" name="amount_unit"></select></td>
					<td class="b" style="display: none;">${alist.registration_date }</td>
					<td class="b" style="display: none;">${alist.modification_date }</td>					
					<td class="b" style="display: none; width: 80px; ">
						<button type="button" style="margin: 10px 0;" class="btn btn-secondary" id="submitbtn2" onclick="submitData2(this)" >수정</button>
						<button type="button" style="margin: 10px 0;" class="btn btn-secondary" id="submitbtn3" onclick="submitData3(this)" >삭제</button>																		 									
					</td>									
				</tr>
				</c:forEach>
			</tbody>
		</table>

			
		<!-- 페이징 -->
		<div class="box-footer clearfix">
			<div style="margin: 0 auto; width: fit-content;" class="pagination-container">
				<ul class="pagination pagination-sm no-margin pull-right">
				
				<c:if test="${pageVO.prev }">
					<li><a href="/amount/firstpage?page=${pageVO.startPage - 1 }">«</a></li>
				</c:if>
				
				<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
					<li class=${pageVO.cri.page == i ? "active":"" }>
						<a href="/amount/firstpage?page=${i }&search=${aDTO.search }">
							${i }
						</a>
					</li>
				</c:forEach>
				
				<c:if test="${pageVO.next }">
					<li><a href="/amount/first?page=${pageVO.endPage + 1 }">»</a></li>
				</c:if>
			
				</ul>
			</div>
		</div>
		<!-- 페이징 끝 -->
	</div>


</body>
</html>