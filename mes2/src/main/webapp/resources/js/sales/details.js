 function goContent(order_code){
 
    
	  $.ajax({
		  url:"planContent", // 
		  type:"post",
		  dataType:"json", // Jackson Databind사용해서 json으로 받기
		  data: {"order_code": order_code }, // 받은 매개변수 전달
		  success:content,
		  error: function(){alert("error");}
	  });
	  
	  
  }

  
  function content(data){ //에이젝스에서 받은 값으로 출력하기 
	 
	  var listHtml ="<div class='list-box'>";

	  listHtml += "<table class='table table-hover'>";
	  listHtml += "<thead>";
	  listHtml += "<tr class='table-success' >";
	  listHtml += "<th scope='col'>제품코드</th>";
	  listHtml += "<th scope='col'>제품명</th>";
	  listHtml += "<th scope='col'>수량</th>";
	  listHtml += "<th scope='col'>현재고</th>";
	  listHtml += "<th scope='col'>부족수량</th>";
	  listHtml += "</tr>";
	  listHtml += "</thead>";
	  
	  listHtml += "<tbody>";
	  
	  $.each(data,function(index,obj){
		  listHtml += "<tr>";
		  listHtml += "<td>"+obj.product_code+"</td>";				  
		  listHtml += "<td>"+obj.product_name+"</td>";
		  listHtml += "<td>"+obj.sales_quantity+"</td>";
		  listHtml += "<td>"+obj.stock_quantity+"</td>";
		  listHtml += "<td>"+obj.lack_quantity+"</td>";	
		  listHtml += "</tr>";
	  });
    

	  listHtml += "</tbody>";
	  listHtml += "</table>";
	 
	//위 표가 들어갈 자리의 아이디값 가져와서 입력하기 
	  $("#view2").html(listHtml);
  }