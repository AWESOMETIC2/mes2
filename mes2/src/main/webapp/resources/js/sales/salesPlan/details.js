 function goContent(order_code){
       
	  $.ajax({
		  url:"planContent", 
		  type:"post",
		  dataType:"json",
		  data: {"order_code": order_code }, 
		  success: function(data) {
			  content(data, order_code);
		  },
		  error: function(){
			  Swal.fire({
				  title: "관계자에게 문의하십시오.",
				  icon: "warning"
				});
		  }
	  });
	  
	  
  }

 function cancle(){
	
		  $("#salesPlanContent").html("");
	  }
 
 function mo(product_code,order_code,sales_quantity){
	 
	  $.ajax({
		  url:"stockCheck", 
		  type:"post",
		  dataType:"json",
		  data: {"product_code": product_code , "order_code" : order_code}, 
		  success: function (data) {
		      moStock(data, sales_quantity); 
		    },
		  error: function(){
			
			  Swal.fire({
				  title: "창고확인 필요",
				  text: "해당 상품은 현재 창고에 보유재고가 없습니다.",
				  icon: "warning"
				});
		  }
	  });
 }
 
 function moStock(data, sales_quantity){
	 
	 $("#salesStockCheck").modal('show');
	 $("#product_name").val(data.product_name);
	 $("#product_code").val(data.product_code);
	
	 if(data.stock_quantity < 0 ){
		 $("#stock_quantity").val('0');
	 }else{
		 $("#stock_quantity").val(data.stock_quantity); 
	 }
	 
	 if((sales_quantity - data.stock_quantity)<=0){
		 // 재고가 충분한 경우 
		 $("#lack_quantity").val('0');
		
	 }else{
		 // 재고가 부족한 경우
		 $("#lack_quantity").val(sales_quantity - data.stock_quantity );
		 $("#salesStockCheckModal").append("<button type='button' id='stockLack-btn' class='btn btn-danger'>재고부족</button>");
		 
				 
	 }

 }
 
 function stockClear() {
	 $("#product_name").val('');
	 $("#product_code").val('');
	 $("#stock_quantity").val('');
	 $("#lack_quantity").val('');
	 
	 if ($("#stockLack-btn").length > 0) {
		  $("#stockLack-btn").remove();
		}
	 
	
}
 
function info(order_code){
	 
	 
	  $.ajax({
		  url:"orderPlanInfo", 
		  type:"post",
		  dataType:"json", 
		  data: {"order_code" : order_code}, 
		  success: function (data) {
		
		      moInfo(data,order_code); 
		    },
		  error: function(){
			  
			  Swal.fire({
				  title: "관계자에게 문의하십시오.",
				  icon: "warning"
				});
			  
				
		  }
	  });
 }
 
 function moInfo(data, order_code){
	 $("#salesPlanInfo").modal('show');
	 var title = "<div>주문번호 : "+order_code+"</div>";
	 $("#salesPlanInfoLabel").html(title);
	 $("#planCompany_name").val(data.company_name);
	 $("#planCompany_code").val(data.company_code);
	 $("#planCompany_address").val(data.company_address);
	 $("#planCompany_call").val(data.company_call);
	 
 }
 
 
  function content(data, order_code){ 
	  var listHtml = "<div class='content-box'>"
		  listHtml += "<div class='content-container'>"
	      listHtml += "<div class='content-title'>"	
		  listHtml += "<div>"
		  listHtml += "<p class='list-font' onclick='info(\""+order_code+"\")'>주문번호: "+order_code+"</p>";	  		  
		  listHtml += "</div>"
		  listHtml += " <button type='button' class='btn-close' aria-label='Close' onclick='cancle()'></button>"		 
		  listHtml += "</div>";
	      listHtml += "<div class='list-box'>";
 
	
	  
		  listHtml += "<table class='table table-hover'>";
		  listHtml += "<thead>";
		  listHtml += "<tr class='table-success' >";
		  listHtml += "<th scope='col'>제품코드</th>";
		  listHtml += "<th scope='col'>제품명</th>";
		  listHtml += "<th scope='col'>수량</th>";
		  listHtml += "<th scope='col'></th>";
		  listHtml += "</tr>";
		  listHtml += "</thead>";  
		  listHtml += "<tbody>";
	  
	  $.each(data,function(index,obj){
		  listHtml += "<tr>";
		  listHtml += "<td>"+obj.product_code+"</td>";				  
		  listHtml += "<td>"+obj.product_name+"</td>";
		  listHtml += "<td>"+obj.sales_quantity+"</td>";
		  listHtml += "<td><button type='button' class='btn mint-btn'  onclick=\"mo('" + obj.product_code + "','"+obj.order_code+"','"+obj.sales_quantity+"')\">재고조회</button></td>";
		  listHtml += "</tr>";
	  });
    

	  listHtml += "</tbody>";
	  listHtml += "</table>";
	  listHtml += "</div>";
	  listHtml += "</div>";
	
	  $("#salesPlanContent").html(listHtml);
  }