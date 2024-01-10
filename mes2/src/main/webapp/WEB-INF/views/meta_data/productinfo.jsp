<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>품목기준정보</title>

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
<link rel="stylesheet" href="/resources/css/metadata/product.css">

<!--  부트스트랩 js cdn입니다. -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous">
</script>

<!-- 추가 js 입니다. -->
<script src="/resources/js/metadata/product.js"></script>

</head>

<body>
<%@ include file="../system/sidehead.jsp" %>
	<!-- 내용 칸 -->
	<div class="son_container">
		<!-- 검색창,추가 버튼,취소 버튼 -->	
		<div class="son_serch">
			
			<form action="/product/firstpage" method="POST">
				<span>등록기간</span>
				<input type="date" name="startDate" min="2023-12-01" max="2024-12-31" />
				<input type="date" name="endDate" min="2020-01-01" max="2030-12-31" width="100px"/>					
				<input type="text" name="search" placeholder="검색어를 입력하세요" />
				<input type="submit" value="검색"/>
			</form>
			<a><i class="fa-solid fa-rotate-right" onclick="redirectToFirstPage()" style="cursor: pointer; font-size: 20px;"></i></a>
			
			
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
					<th scope="col">품목코드</th>
					<th scope="col">품명</th>
					<th scope="col">카테고리</th>
					<th scope="col">재고단위</th>
					<th scope="col">원가</th>
					<th scope="col">단가</th>
					<th scope="col">생산여부</th>
					<th scope="col">등록일</th>
					<th scope="col" width="100px">사진</th>
					<th scope="col"></th>									
				</tr>
			</thead>
			
			<!-- 테이블 바디 -->				
			<tbody>
				<!-- 품목 추가시 생기는 행 -->				
				<tr id="insert_hang" style="display: none; text-align: center; vertical-align: middle;">										
					<td></td>							
					<td>[코드자동생성]</td>
					<td><input type="text" name="name" size="5"></td>																				
					<td><select id="ins_cate" name="ins_cate"></select></td>										    								      												
					<td><select id="ins_unit" name="ins_unit"></select></td>
					<td><input type="text" name="cost" size="5"></td>
					<td><input type="text" name="price" size="5"></td>				
					<td><i class="fa-solid fa-circle fa-2xs" style="color: #439f1d;"></i>생산 중</td>				
					<td>[현재날짜]</td>				
					<td>													
						<img id="img" width="250px"/> 						
						<input type="file"  value="사진 추가" id="file_insert" style="width: 200px;">									
					</td>
					<td><button type="button" class="btn btn-secondary" id="submitbtn" onclick="submitData()" style="display: none;">저장</button></td>														
				</tr>	
													
				<!-- 품목리스트 행들을 가져옴 -->								
				<c:forEach var="plist" items="${productList }">
				<tr style="text-align: center; vertical-align: middle; ">
					
					<!-- 품목리스트 -->
					<td><input type="checkbox" class="updatecheckbox" style="display: none;" onchange="a(this)"/></td>															
					<td class="a">${plist.product_code }</td>
					<td class="a">${plist.name }</td>
					<td class="a">${plist.category }</td>
					<td class="a">${plist.unit }</td>
					<td class="a">${plist.cost }</td>
					<td class="a">${plist.price }</td>
					<td class="a">
					<c:choose>
                       <c:when test="${plist.production_status eq '1' }">
                          <i class="fa-solid fa-circle fa-2xs" style="color: #439f1d;"></i> 생산 중
                       </c:when>
                       <c:when test="${plist.production_status eq '0' }">
                          <i class="fa-solid fa-circle fa-2xs" style="color: #848484;"></i> 생산 중단
                       </c:when>
                    </c:choose>					
					</td>
					<td class="a">${plist.regdate }</td>
					<td class="a">
					<img src="../../../../resources/img/metadata/${plist.ofileName }" width="130px" height="100px"
					onerror="this.onerror=null; this.src='../../../../resources/img/metadata/default.png';">
					</td>
					<td class="a" style="content: '\00a0'"></td>
									
									
					<!-- 품목수정 시 나타나는 행 -->									
					<td class="b" style="display: none;">${plist.product_code }</td>
					<td class="b" style="display: none;"><input type="text" name="name" size="5" value="${plist.name }"></td>	
					<td class="b" style="display: none;"><select id="upd_cate" name="upd_cate"></select></td>
					<td class="b" style="display: none;"><select id="upd_unit" name="upd_unit"></select></td>
					<td class="b" style="display: none;"><input type="text" name="cost" size="5" value="${plist.cost }"></td>
					<td class="b" style="display: none;"><input type="text" name="price" size="5" value="${plist.price }"></td>
					<td class="b" style="display: none;">
						<select id="upd_status" name="upd_status">
							<option>생산유무</option>
							<option value="1">생산 중</option>
							<option value="0">생산 중단</option>
						</select>
					</td>
					<td class="b" style="display: none;">${plist.regdate }</td>
					<td class="b" style="display: none; width: 80px;">								
						<img id="img2" src="../../../../resources/img/metadata/${plist.ofileName }" width="200px">						
						<input type="file" id="file_update" style="width: 200px;">
					</td>
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
					<li><a href="/product/firstpage?page=${pageVO.startPage - 1 }">«</a></li>
				</c:if>
				
				<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
					<li class=${pageVO.cri.page == i ? "active":"" }>
						<a href="/product/firstpage?page=${i }&search=${aDTO.search }&startDate=${aDTO.startDate }&endDate=${aDTO.endDate }">
							${i }
						</a>
					</li>
				</c:forEach>
				
				<c:if test="${pageVO.next }">
					<li><a href="/product/first?page=${pageVO.endPage + 1 }">»</a></li>
				</c:if>
			
				</ul>
			</div>
		</div>
		<!-- 페이징 끝 -->
	</div>


</body>
</html>