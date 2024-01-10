
// salesPlan의 자바스크립트 list
  var updateBtn = false;
 
 $(document).ready(function(){
	  loadList();
  });


  function loadList(){
	  
	  $.ajax({
		  
		  url:"salesPlanList", //목록 담아오기 (리스트 DTO랑 연결)
		  type:"get",
		  dataType:"json",
		  success: list,
		  error: function(){alert("error");}
	  });
	  
	  
  } 


 function list(data){
	 // loadList()에서 가져온 데이터로 리스트만들기
	 
	  var listHtml = "<table class='table table-hover'>";
	  listHtml += "<thead>";
	  listHtml += "<tr class='table-success'>";
	  //listHtml += "<th></th>";
	  listHtml += "<th scope='col'>주문번호</th>";
	  listHtml += "<th scope='col'>수주처</th>";
	  listHtml += "<th scope='col'>납기요청일</th>";
	  listHtml += "<th scope='col'>수주신청일</th>";
	  listHtml += "<th scope='col'></th>";
	  listHtml += "</tr>";
	  listHtml += "</thead>";
	  listHtml += "<tbody>";
	  

	// 반복문 돌면서 가져온 데이터 넣어주기 obj.변수명으로 입력하면 된다. 
	  $.each(data,function(index,obj){
		  listHtml += "<tr>";
		  //listHtml += "<td scope='row'><input type='checkbox' class='ck' name='idx' value='"+obj.order_code+"' id='"+obj.order_code+"'/></td>";		  
          listHtml += "<td><a href='javascript:goContent(\"" + obj.order_code + "\")'>" + obj.order_code + "</a></td>";

		  listHtml += "<td>"+obj.company_name+"</td>";
		  listHtml += "<td>"+obj.order_date+"</td>";
		  listHtml += "<td>"+obj.request_date+"</td>";
		  listHtml += "<td><button type='button' class='btn btn-secondary' onclick='reject(\"" + obj.order_code + "\")'>거절</button></td>";
		  listHtml += "</tr>";
	  });
	  listHtml += "</tbody>"; 
	  listHtml += "</table>";
	 
	// 위 리스트가 들어갈 곳의 아이디를 가져와서 넣어주기 
	  
	  $("#view").html(listHtml);
  } 