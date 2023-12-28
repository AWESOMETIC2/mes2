<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>품목관리</title>

<!-- jqery js입니다. (ajax랑 js에 있는 여러가지 js라이브러리 쓸려고)-->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- 부트스트랩 css cdn입니다. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />

<!--  부트스트랩 js cdn입니다. -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous">
</script>

<!-- 추가 css 입니다. -->
<link rel="stylesheet" href="/resources/css/metadata/product.css">

<!-- 추가 js 입니다. -->
<script src="/resources/js/metadata/productinfo.js"></script>


<!--  추가 버튼 스크립트 -->
<!-- 저장버튼을 클릭하면 (추,수,삭)3개버튼은 사라지고 저장,취소 버튼이 나오게 되는 js 입니다.  -->
<!--  밑부분은  추가되는 행이 보이게 하거나 숨기는 js입니다. -->
<script>
		function replaceButton() {
            
            var addbtn = document.getElementById('addbtn');
            var updatebtn = document.getElementById('updatebtn');
            var eletebtn = document.getElementById('eletebtn');
            addbtn.style.display = 'none';
            updatebtn.style.display = 'none';
            deletebtn.style.display = 'none';

            // 두 번째 버튼을 보임
            var canclebtn = document.getElementById('canclebtn');
            var submitbtn = document.getElementById('submitbtn');
            
            canclebtn.style.display = 'inline-block'; // 또는 'block' 등을 사용할 수 있음
            submitbtn.style.display = 'inline-block'; // 또는 'block' 등을 사용할 수 있음
       
            var row = document.getElementById("inserthang");
            
         // 현재 행의 상태를 확인하고 반대로 설정
            if (row.style.display === "none") {
                row.style.display = "table-row";
            } else {
                row.style.display = "none";
            }
            
        }
</script>


<!--  수정 버튼 스크립트 -->
<!-- 저장버튼을 클릭하면 (추,수,삭)3개버튼은 사라지고 저장,취소 버튼이 나오게 되는 js 입니다.  -->
<!--  밑부분은  추가되는 체크박스를 보이게 하거나 숨기는 js입니다. -->
<script>
		function replaceButton2() {
            
            var addbtn = document.getElementById('addbtn');
            var updatebtn = document.getElementById('updatebtn');
            var eletebtn = document.getElementById('eletebtn');
            addbtn.style.display = 'none';
            updatebtn.style.display = 'none';
            deletebtn.style.display = 'none';

            
            var canclebtn = document.getElementById('canclebtn');
            var submitbtn2 = document.getElementById('submitbtn2');
            
            canclebtn.style.display = 'inline-block'; // 또는 'block' 등을 사용할 수 있음
            submitbtn2.style.display = 'inline-block'; // 또는 'block' 등을 사용할 수 있음
       		
            
            //체크박스 보이게 하는 법!
            var checkboxes = document.querySelectorAll(".updatecheckbox");
            
            
            checkboxes.forEach(function(checkbox) {
            	
            	if (checkbox.style.display === "none") {
                    checkbox.style.display = "block";
                }
            	else {
                checkbox.style.display = "none";
                }
           
            	
            	checkbox.addEventListener('change', () => {
            	      
            	      checkboxes.forEach(otherCheckbox => {
            	        
            	    	  if (otherCheckbox !== checkbox) {
            	          otherCheckbox.checked = false;
            	          }
            	      
            	      });
            	})
            });
           
        }
</script>



<!--  다른체크박스 클릭시 창닫는 js -->
<script>
    function a(checkbox) {
        var row = checkbox.closest('tr');

        if (row) {
            var classAElements = row.getElementsByClassName('a');
            var classBElements = row.getElementsByClassName('b');

            if (checkbox.checked) {
                // 체크될 때
                for (var i = 0; i < classAElements.length; i++) {
                    classAElements[i].style.display = 'none';
                }
                for (var i = 0; i < classBElements.length; i++) {
                    classBElements[i].style.display = 'table-cell'; // 또는 다른 display 값으로 설정
                }
            } else {
                // 체크가 해제될 때
                for (var i = 0; i < classAElements.length; i++) {
                    classAElements[i].style.display = 'table-cell'; // 또는 다른 display 값으로 설정
                }
                for (var i = 0; i < classBElements.length; i++) {
                    classBElements[i].style.display = 'none';
                }
            }
        }
        
        var allRows = document.getElementsByTagName('tr');
        for (var j = 0; j < allRows.length; j++) {
            if (allRows[j] !== row) {
                var otherClassAElements = allRows[j].getElementsByClassName('a');
                var otherClassBElements = allRows[j].getElementsByClassName('b');

                // class="a"인 열 보이게 설정
                for (var i = 0; i < otherClassAElements.length; i++) {
                    otherClassAElements[i].style.display = 'table-cell';
                }

                // class="b"인 열 감추기
                for (var i = 0; i < otherClassBElements.length; i++) {
                    otherClassBElements[i].style.display = 'none';
                }
            }
        }
        
        
    }
</script>



<!--  추가 ajax -->
<script>
function submitData() {
    // 입력 필드의 값을 가져오기
    var productCode = $('input[name="product_code"]').val();
    var name = $('input[name="name"]').val();
    var category = $('input[name="category"]').val();
    var unit = $('input[name="unit"]').val();
    var cost = $('input[name="cost"]').val();
    var price = $('input[name="price"]').val();
    var productionStatus = $('input[name="production_status"]').val();

    // Ajax를 사용하여 서버에 데이터 전송
    $.ajax({
        url: '/meta_data/insertproduct',
        type: 'POST',
        data: {
            product_code: productCode,
            name: name,
            category: category,
            unit: unit,
            cost: cost,
            price: price,
            production_status: productionStatus
            // 추가 필요한 데이터가 있다면 여기에 추가
        },
        async: false,
        success: function() {
            

            // 추가적인 동작 수행
            // 예를 들어, 페이지 리로드 등
            alert('추가완료');
            location.reload();
            
        },
        error: function(error) {
            // 에러 처리
        	console.error('에러 발생:', error);
        }
    });
}    
</script>


<!-- 수정 ajax -->
<script>
    function submitData2(submitbtn2) {
		
    	var row = $(submitbtn2).closest('tr');

        // 수정된 값 가져오기
        var hiddenProductCode = row.find('.b:eq(0)').text();
        var hiddenName = row.find('.b input[name="name"]').val();
        var hiddenCategory = row.find('.b input[name="category"]').val();
        var hiddenUnit = row.find('.b input[name="unit"]').val();
        var hiddenCost = row.find('.b input[name="cost"]').val();
        var hiddenPrice = row.find('.b input[name="price"]').val();
        var hiddenProductionStatus = row.find('.b input[name="production_status"]').val();

        // AJAX를 사용하여 서버로 데이터 전송
        $.ajax({
            url: '/meta_data/updateproduct', // 실제 서버 엔드포인트로 변경해야 합니다.
            type: 'POST',
            data: {
                product_code: hiddenProductCode,
                name: hiddenName,
                category: hiddenCategory,
                unit: hiddenUnit,
                cost: hiddenCost,
                price: hiddenPrice,
                production_status: hiddenProductionStatus
                // 나머지 필드들 추가
            },
            success: function(response) {
                // 서버로부터의 응답 처리
                alert('수정완료');
                location.reload();
            },
            error: function(error) {
                // 에러 처리
                console.error(error);
            }
        });
    	
    }
</script>

<!-- 취소버튼 js -->
<script>
function redirectToFirstPage() {
    window.location.href = '/meta_data/firstpage'; // 이동할 페이지의 URL로 변경
}
</script>


</head>
<body>

<%@ include file="../../sidehead/sidehead.jsp" %>
	<!-- 검색창 -->
	<div class="son_container">
			
		<div class="son_serch">
			
			
			<form id="dateForm" action="/meta_data/filter" onsubmit="" method="POST">
				<span class="son_search-font">등록기간</span>
				<input id="dtIp" type="date" name="startDate" min="2023-12-01" max="2024-12-31" />
				<input id="dtIp" type="date" name="endDate" min="2020-01-01" max="2030-12-31" width="100px"/>					
				<input type="text" name="search" placeholder="검색어를 입력하세요" />
				<input type="submit" value="검색" onchange="submitForm()"/>
			</form>
			
		
		<!-- 추가 수정 삭제 form 버튼 -->
		<div class="son_list-btn">
			<form  action="">
				<button type="button" class="btn btn-secondary" id="addbtn" name="" onclick="replaceButton()">추가</button>
			</form>
		</div>	
		<div>
			<form  action="">	
				<button type="button" class="btn btn-secondary" id="updatebtn" onclick="replaceButton2()">수정</button>
			</form>
		</div>
		<div>
			<form  action="">	
				<button type="button" class="btn btn-secondary" id="deletebtn" onclick="">삭제</button>
			</form>
		</div>
			
		<div>
			
				<button type="button" class="btn btn-secondary" id="submitbtn" onclick="submitData()" style="display: none;">추가저장</button>
			
		</div>
		<div>
			<form  action="">	
					
			</form>
		</div>
		<div>
			<button type="button" class="btn btn-secondary" id="canclebtn" onclick="redirectToFirstPage()" style="display: none; margin-right: 70px;" >돌아가기</button>
		</div>

			
			
		</div>		
			
			

			<!-- 표 -->
			<div class="list">
				

				<div class="son_list-box">	
						<table class="table table-hover" >
							<thead>
								<tr class="table-success" >
									<th scope="col">C</th> <!-- 체크박스 -->
									<th scope="col">품목코드</th>
									<th scope="col">품명</th>
									<th scope="col">카테고리</th>
									<th scope="col">재고단위</th>
									<th scope="col">원가</th>
									<th scope="col">단가</th>
									<th scope="col">취급유무</th>
									<th scope="col">등록일</th>
									<th scope="col">사진</th>
									
									
								</tr>
							</thead>
							
							<tbody >
								
								
								<!-- 품목추가버튼 누를시 나옴 -->
								<tr id="inserthang" style="display: none;">	
									
									<td></td>							
									<td><input type="text" name="product_code" size="5"></td>
									<td><input type="text" name="name" size="5"></td>
									<td><input type="text" name="category" size="5"></td>
									<td><input type="text" name="unit" size="5"></td>
									<td><input type="text" name="cost" size="5"></td>
									<td><input type="text" name="price" size="5"></td>
									<td><input type="text" name="production_status" size="5"></td>
									<td></td>
									<td>업로드 링크</td>
								
								</tr>	
								
								
								
								<!-- 모든물품 검색하기 productList를 가져오면 실행됨 -->
								<c:if test="${!empty productList }">
								<c:forEach var="plist" items="${productList }">
								<tr>
									<td><input type="checkbox" class="updatecheckbox" style="display: none;" onchange="a(this)"/></td>									
									
									
									<td class="a">${plist.product_code }</td>
									<td class="a">${plist.name }</td>
									<td class="a">${plist.category }</td>
									<td class="a">${plist.unit }</td>
									<td class="a">${plist.cost }</td>
									<td class="a">${plist.price }</td>
									<td class="a">${plist.production_status }</td>
									<td class="a">${plist.regdate }</td>
									<td class="a">${plist.regdate }</td> <!-- 사진 -->
									
									
									
															
									<td class="b" style="display: none;">${plist.product_code }</td>
									<td class="b" style="display: none;"><input type="text" name="name" size="5" value="${plist.name }"></td>
									<td class="b" style="display: none;"><input type="text" name="category" size="5" value="${plist.category }"></td>
									<td class="b" style="display: none;"><input type="text" name="unit" size="5" value="${plist.unit }"></td>
									<td class="b" style="display: none;"><input type="text" name="cost" size="5" value="${plist.cost }"></td>
									<td class="b" style="display: none;"><input type="text" name="price" size="5" value="${plist.price }"></td>
									<td class="b" style="display: none;"><input type="text" name="production_status" size="5" value="${plist.production_status }"></td>
									<td class="b" style="display: none;">${plist.regdate }</td>
									<td class="b" style="display: none;">업로드 링크 </td>
									<td class="b" style="display: none; width: 80px;">
									<button type="button" class="btn btn-secondary" id="submitbtn2" onclick="submitData2(this)" >수정</button>
									
									</td>
								</tr>
								
								</c:forEach>
								</c:if>
								<!-- 모든물품 검색하기 productList를 가져오면 실행됨 -->
							</tbody>
							
						</table>
				</div>
			</div>

	
	
	
	</div>
	
	

<br><br><br><br>

</body>
</html>