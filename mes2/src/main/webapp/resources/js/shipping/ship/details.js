
function goContent(order_code){
       
	  $.ajax({
		  url:"shipContent",  
		  type:"post",
		  dataType:"json", 
		  data: {"order_code": order_code }, 
		  success: function(data) {
			  content(data,order_code);
		  },
		  error: function(){ 
			  Swal.fire({
			  title: "관계자에게 문의하세요",
			  icon: "warning"
			});}
	  });
	  
	  
  }

 function cancle(){
	
		  $("#view2").html("");
	  }
 
 function info(order_code){
	 
	 
	  $.ajax({
		  url:"getOrderInfo", 
		  type:"post",
		  dataType:"json", 
		  data: {"order_code" : order_code}, 
		  success: function (data) {
			  
		      moInfo(data,order_code); 
		    },
		  error: function(){
			 
			  Swal.fire({
				  title: "정보입력중",
				  text: "잠시 후 다시 시도하세요",
				  icon: "warning"
				});
				
		  }
	  });
 }
 
 function moInfo(data, order_code){
	
	 $("#shippingInfo").modal('show');
	 var title = "<div>주문번호 : "+order_code+"</div>";
	
	 $("#shippingInfoLabel").html(title);
	 $("#company_name").val(data.company_name);
	 $("#company_code").val(data.company_code);
	 $("#company_address").val(data.company_address);
	 $("#company_call").val(data.company_call);
	 $("#ifo_id").val(data.user_id);
	 $("#user_name").val(data.user_name);
	 $("#user_department").val(data.user_department);
	 $("#user_position").val(data.user_position);
	 $("#user_auth").val(data.user_auth);

 }
 


 
 function moProduct(data){
	 	 
	 Swal.fire({
	   title: "1창고 A구역",
	   icon: "info"
	 });

 }
 

  function content(data,order_code){ 

	  var listHtml = "<div class='content-box'>"
		  listHtml += "<div class='content-container'>"
	      listHtml += "<div class='content-title'>"		 		 
		  listHtml += "<div class='content-tbtn'>"
		 
		  listHtml += "<p class='list-font'  onclick='info(\""+order_code+"\")'>주문번호: "+order_code+"</p>";	  		 
		  listHtml += "<button type='button' class='btn mint-btn btn-sm'  onclick='moProduct()'>위치</button>";	  		 
		  listHtml += "</div>"
		  listHtml += " <button type='button' class='btn-close' aria-label='Close' onclick='cancle()'></button>"
		  listHtml += "</div>";
		  listHtml += "<div class='list-box'>";
		  listHtml += "<table class='table table-hover'>";
		  listHtml += "<thead>";
		  listHtml += "<tr class='table-success'>";
		  listHtml += "<th style='text-align: center;'>수주번호</th>";
		  listHtml += "<th>제품명</th>";
		  listHtml += "<th>출하량</th>";
		  listHtml += "<th>처리등록</th>";
		  listHtml += "</tr>";
		  listHtml += "</thead>";
	  
		  listHtml += "<tbody>";
	  
	  $.each(data,function(index,obj){
		  listHtml += "<tr>";
		  listHtml += "<td>"+obj.sales_code+"</td>";				  
		  listHtml += "<td>"+obj.product_name+"</td>";
		  listHtml += "<td>"+obj.sales_quantity+"</td>";
		  listHtml += "<td>"
		  if(obj.processing_reg=="stock"){
			  listHtml += "재고출하"; 
		  }else if(obj.processing_reg=="production"){
		  listHtml += "생산처리";  
		  }else if(obj.processing_reg=="multi"){
		  listHtml += "복합처리";  
		  }
		  listHtml += "</td>"	  
		  listHtml += "</tr>";
	  });
    

	  listHtml += "</tbody>";
	  listHtml += "</table>";
	 
	
	  $("#view2").html(listHtml);
  }