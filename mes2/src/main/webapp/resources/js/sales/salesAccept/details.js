var intNum = 0;
$(document).ready(function() {
    var pageFrm = $("#pageForm");

    $(".page-item a").on("click", function(e) {
        
        e.preventDefault(); //a태그기능막기
        var page = $(this).attr("href"); //페이지번호
        pageFrm.find("#page").val(page);
        pageFrm.submit();
    });
}); 

function goContent(order_code){
       
	  $.ajax({
		  url:"acceptContent",
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
	
		  $("#salesAcceptContent").html("");
	  }
 
 function mo(product_code,order_code,sales_quantity){
	 
	  $.ajax({
		  url:"stockCheck", 
		  type:"post",
		  dataType:"json",
		  data: {"product_code": product_code , "order_code" : order_code}, 
		  success: function (data) {
			  $("#salesModal").modal("show");
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
 
 function moStock(data, sales_quantity) {
	 
	 $("#salesStockCheck").modal('show');
	 $("#product_name").val(data.product_name);
	 $("#product_code").val(data.product_code);
	
	 if(data.stock_quantity < 0 ){
		 $("#stock_quantity").val('0');
	 }else{
		 $("#stock_quantity").val(data.stock_quantity); 
	 }
	 
	 if((sales_quantity - data.stock_quantity)<=0){
		 $("#lack_quantity").val('0');	
	 }else{
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

function infoClear(){
	
	 $("#checkUser").val('');
	 $("#user_pw").val('');
	
	 if ($("#reg-btn").length > 0) {
		  $("#reg-btn").remove();
		}
	 
	}

 function SalesDTO(order_code, sales_code, product_code, sales_quantity, processing_reg) {
	  this.order_code = order_code;
	  this.sales_code = sales_code;
	  this.product_code = product_code;
	  this.sales_quantity = sales_quantity;
	  this.processing_reg = processing_reg;
	}

 function save(){
	

	 var list = [];
	 
	 for (var i = 0; i < intNum; i++) {
		 var order = $(".order_code").val();
		 var scode = $(".sales_code").eq(i).val();
		 var pcode = $(".product_code").eq(i).val();
		 var salesQuantity = $(".sales_quantity").eq(i).val();
		 var processingReg = $(".product-processing").eq(i).val();
	 
	 
		 var dto = new SalesDTO(order, scode, pcode, salesQuantity, processingReg);
		 list.push(dto);


	 }
	
	 $.ajax({
		  url: "acceptSave",
		  method: "POST",
		  contentType: "application/json",
		  data: JSON.stringify(list), 
		  success: function(data) {
			 
			  Swal.fire({
				  title: "등록되었습니다!",				 
				  icon: "success"
				}).then((result) => {
					$("#mo-close").trigger('click');
					intNum = 0;
					goContent(data);
				});

			  
			 
			 
			},
		 
			error: function() {
		       
				  Swal.fire({
					  title: "관계자에게 문의하십시오.",
					  icon: "warning"
					});
		    }
		});
 }

 function saveCheck(order_code){
	 Swal.fire({
		  title: "등록하시겠습니까?",
		  icon: "question",
		  showCancelButton: true,
		  confirmButtonColor: "#6e9888",
		  cancelButtonColor: "#666666",
		  confirmButtonText: "등록",
		  cancelButtonText: "취소"
		}).then((result) => {
		  if (result.isConfirmed) {
			  $.ajax({
				  url:"getRegUser", 
				  type:"post",
				  dataType:"json", 
				  data: {"order_code" : order_code}, 
				  success: function (data) {
					  
					  moReg(data,order_code)
				      
				    },
				  error: function(){
					  Swal.fire({
						  title: "관계자에게 문의하십시오.",
						  icon: "warning"
						});
						
				  }
			  });
		  }
		});
	 
 }
 
 function moReg(data,order_code){
	 
	 $("#salesCheck").modal('show');
     $("#checkUser").val(data.user_id);
	 $("#salesCheckModal").append("<button type='button' class='btn dark-green-btn' id='reg-btn' onclick='return regPw(\""+data.user_id+"\")'>비밀번호 확인</button>");
	 
 }
 
 function regPw(user_id){
	 
	 var user_pw = $("#user_pw").val();
	  $.ajax({
		  url:"getRegPw", 
		  type:"post",
		  dataType:"text", 
		  data: {"user_id" : user_id, 
			  	"user_pw" : user_pw
		  }, 
		  success: function (data) {
			  if(data == 'true'){
				  save();  
			  } else{
				  Swal.fire({
					  title: "비밀번호 오류!",
					  text: "등록이 취소되었습니다.",
					  icon: "error"
					});
			  }
			 
		    },
		  error: function(){
			  Swal.fire({
				  title: "관계자에게 문의하십시오.",
				  icon: "warning"
				});
				
		  }
	  });
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
					  title: "관계자에게 문의하십시오.",
					  icon: "warning"
					});
					
			  }
	  });
 }
 
 function moInfo(data, order_code){
	
	 $("#salesInfo").modal('show');
	 var title = "<div>주문번호 : "+order_code+"</div>";
	
	 $("#salesInfoLabel").html(title);
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
 
 
  function content(data, order_code){ 
	  var listHtml = "<div class='content-box'>"
		  listHtml += "<div class='content-container'>"
	      listHtml += "<div class='content-title'>"	
		  listHtml += "<div>"
		  listHtml += "<p class='list-font' onclick='info(\""+order_code+"\")'>주문번호: "+order_code+"</p>";	  		 
		  listHtml += "</div>"		
		  listHtml += " <button type='button' class='btn-close' aria-label='Close' onclick='cancle()'></button>"
		  listHtml += "</div>";
		  if(data[0].instructions=='N'){
			  
			  listHtml += " <button type='button' class='btn' style='background-color:#619e6b; color: white;' id='save-btn' onclick='return saveCheck(\""+order_code+"\")'>저장</button>";
		  }
		  listHtml += "<div class='list-box'>";  
		  listHtml += "<table class='table table-hover'>";	  
		  listHtml += "<table class='table table-hover'>";
		  listHtml += "<thead>";
		  listHtml += "<tr class='table-success' >";
		  listHtml += "<th style='text-align: center;'>수주번호</th>";
		  listHtml += "<th>제품명</th>";
		  listHtml += "<th>수량</th>";
		  listHtml += "<th>재고조회</th>";
		  listHtml += "<th>처리상태</th>";
		  listHtml += "<th>수주처리</th>"; 
		  listHtml += "</tr>";
		  listHtml += "</thead>";  
		  listHtml += "<tbody>";  
	  
	  $.each(data,function(index,obj){
		  
		  intNum++;
		  
		  listHtml += "<tr>";
		  listHtml +="<input type='hidden' class='order_code' value='"+order_code+"'>";
		  listHtml +="<input type='hidden' name='sales_code' class='sales_code' value='"+obj.sales_code+"'>";
		  listHtml += "<td>"+obj.sales_code+"</td>";
		  if(obj.product_name == null){
			  listHtml += "<td>미정</td>"; 
		  }if(obj.product_name != null){
			  listHtml += "<td>"+obj.product_name+"</td>";
		  }
		  listHtml +="<input type='hidden' name='product_code' class='product_code' value='"+obj.product_code+"'>";
		  listHtml += "<td>"+obj.sales_quantity+"</td>";
		  listHtml +="<input type='hidden' name='product_code' class='sales_quantity' value='"+obj.sales_quantity+"'>";
		  listHtml += "<td><button type='button' class='btn mint-btn' onclick=\"mo('" + obj.product_code + "','"+obj.order_code+"','"+obj.sales_quantity+"')\">재고조회</button></td>";
		 
          if(obj.product_status == 'waiting'){
        	  listHtml += "<td><div class='gray-circle'/></div>  대기</td>";
          }
          if(obj.product_status == 'progressing'){
        	  listHtml += "<td><div class='yellow-circle'/></div>  진행중</td>";
          }
          if(obj.product_status == 'complete'){
        	  listHtml += "<td><div class='green-circle'/></div>  완료</td>";
          }
          
		  if(obj.processing_reg == 'N'){
			  listHtml += "<td class='back'><select name='processing_reg' aria-label='Default select example' class='form-select product-processing'>";
			  listHtml += "<option value='N' class='check-processing'>N</option>";
			  listHtml += "<option value='stock' class='check-processing'>재고처리</option>";
			  listHtml += "<option value='production' class='check-processing'>생산처리</option>";
			  listHtml += "<option value='multi' class='check-processing'>복합처리</option>";  
			  listHtml += "</select></td>";
			 
		  }  
		  if(obj.processing_reg != 'N'){
			  if(obj.processing_reg == 'stock'){
				  listHtml += "<td><div class='green-circle'/></div>  재고처리</td>";
			  }
			  if(obj.processing_reg == 'production'){
				  listHtml += "<td><div class='green-circle'/></div>  생산처리</td>";
			  }
			  if(obj.processing_reg == 'multi'){
				  listHtml += "<td><div class='green-circle'/></div>  복합처리</td>";
			  }
			
			

		  }
		  listHtml += "</tr>";
        	  
      
	  });
    
	
	  listHtml += "</tbody>";
	  listHtml += "</table>";
	 

	  $("#salesAcceptContent").html(listHtml);
	  
	 
     
  }