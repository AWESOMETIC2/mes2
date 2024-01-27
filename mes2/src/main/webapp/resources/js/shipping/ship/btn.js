var selectedOrder; 
var radioCnt;
$(document).ready(function() {
  
	radioCnt =0;
	
	$('.waite-btn').each(function(index, element) {
		  var shipDateValue = $(element).closest('tr').find('.ship-date').text();
		  var shipDate = moment(shipDateValue, 'YYYY-MM-DD');
		  var today = moment();
		  
		  console.log('shipDate:', shipDate.format('YYYY-MM-DD'));
		  console.log('today:', today.format('YYYY-MM-DD'));
		  
	  if (shipDate.isSame(today, 'day')||shipDate.isBefore(today, 'day')) {
		    // 대기 버튼 클래스 활성화
		   $(element).removeClass('btn-secondary').addClass('btn-warning');

		    
		  }
	
		  
		});



  
  $('.ck').on('change', function() {
   // 라디오버튼에 저장된 주문번호 가져오기
    selectedOrder = $('input[name="order_code"]:checked').val();

  });
  
  
  

  
});
 
function showStatus() {
	radioCnt++;
	  const inputOptions = new Promise((resolve) => {
	    setTimeout(() => {
	      resolve({
	        "waiting": "출하대기",
	        "shipping": "배송",
	        "complete": "출하완료"
	      });
	    }, 1000);
	  });

	  Swal.fire({
	    title: "진행현황을 선택하세요.",
	    input: "radio",
	    inputOptions,
	    inputValidator: (value) => {
	      if (!value) {
	        return "선택한 항목이 없습니다. ";
	      }
	    }
	  }).then((result) => {
	    if (!result.isConfirmed) {
	      return;
	    }

	    const progressStatus = result.value;
	    if (progressStatus) {
	      $("#progressSta").val(progressStatus);
	      $("#sfrm").submit();
	    }
	  });
	}

function complete(order_code,ship_date){
	
	   var shipDate = moment(ship_date, "ddd MMM DD HH:mm:ss Z YYYY").format("YYYY-MM-DD");
	   var today = moment(); 
	    
	   if (moment(shipDate).isAfter(today)) {
	
	        Swal.fire({
			    title: "대기상태",
			    text: "배송을 지시할 수 없습니다.",
			    icon: "error"
			});
	        return;
	    }
	    
	  else{ 
		  
	 Swal.fire({
		  title: "배송처리",
		  text: "주문번호 "+order_code+"의 배송처리하시겠습니까?",
		  icon: "info",
		  showCancelButton: true,
		  cancelButtonText: "취소",
		  confirmButtonColor: "#6e9888",
		  cancelButtonColor: "#666666",
		  confirmButtonText: "확인"
		}).then((result) => {
		
		  if (result.isConfirmed) {
			  $.ajax({
	 			  url:"updateIdCheck", 
	 			  type:"post",
	 			  dataType:"json",
	 			  data: {"order_code":order_code},
	 			  success: function(data) {
	 				
	 				    deliverReg(data,order_code);
	 			  }, 
	 			  error: function(){
	 				 Swal.fire({
	 					  title: "관계자에게 문의하세요",				
	 					  icon: "warning"
	 					});
	 			  }
	 		  });
			 
		  }

		  
		});
}
}

function deliverReg(data,order_code){
	
	$("#shippingCheck").modal('show');
	$("#checkUser").val(data.user_id);
	$("#checkName").val(data.user_name);
	$("#shippingCheckModal").append("<button type='button' class='btn dark-green-btn' id='deliver-btn' onclick='return deliverPw(\"" + order_code + "\")'>비밀번호 확인</button>");

}

function deliverPw(order_code){
	 var user_id = $("#checkUser").val();
	 var user_pw = $("#user_pw").val();
	 $.ajax({
		  url: "updatePwCheck",
		  type:"post",
		  dataType: "json",
		  data: {"user_pw": user_pw, "order_code":order_code, "user_id": user_id},
		  success: function(data) {
			    deliverCheck(data,order_code);
		  }, 
		  error: function() {
			  Swal.fire({
				  title: "관계자에게 문의하세요",				
				  icon: "warning"
				});
		  }
		});
	 
}

function deliverCheck(data,order_code){
	 
	 
	 if(data.check=="true"){
		
		 $("#mo-close").trigger('click');
		 infoClear();
		 $.ajax({
			  url:"outComplete", 
			  type: "POST",
			  dataType:"text",
			  data: {"order_code": order_code},
			  success: function(data) {	
				 
				  Swal.fire({
					    title: "배송처리 되었습니다.",
					    text: data,
					    icon: "success"
					}).then(() => {
						
						$("#pageForm").submit();
					});
			  }, 
			  error: function(){
				  Swal.fire({
					  title: "관계자에게 문의하세요",				
					  icon: "warning"
					});
			  }
		  });
	 }else{
		 Swal.fire({
			  title: "비밀번호 오류",
			  text: "담당자 비밀번호를 확인하세요.",
			  icon: "error"
			});
		 
	 }
}



 function update(){
	 var ckArr = $(".ck");
	 var count = ckArr.filter(":checked").length; 
	 
	// 선택된 라디오 버튼의 값을 가져옴
	 var selectedOrderCode = $("input[name='order_code']:checked").val();

	 // 선택된 행에서 클래스가 'pf'인 td 엘리먼트의 텍스트를 가져옴
	 var pfText = $("input[name='order_code'][value='" + selectedOrderCode + "']").closest('tr').find('.pf').text().trim();

	 // 텍스트가 '대기'인 경우 처리
	 if (pfText === '완료') {
	     Swal.fire({
			  title: "수정 불가능",
			  text:"이미 출하처리되었습니다.",
			  icon: "error"
			});

	     return;
	 } 
	 if (pfText === '배송') {

	     Swal.fire({
			  title: "수정 불가능",
			  text:"배송 중입니다.",
			  icon: "error"
			});

	     return;
	 }
	 
	 
	 
	 
	 if(count==0){	 	
		 Swal.fire({
			  title: "선택된 항목이 없습니다.",
			  icon: "warning"
			});
	 	
	 }
	 
	 else{
	 	 if(count==1){
	 		Swal.fire({
	 			  title: "출하일정을 수정하시겠습니까?",
	 			  text: "이미 예약출하가 지시된 상태입니다. 출하일정을 수정을 진행하시겠습니까?",
	 			  icon: "warning",
	 			  showCancelButton: true,
	 			  confirmButtonColor: "#6e9888",
	 			  cancelButtonColor: "#666666",
	 			  confirmButtonText: "진행"
	 			}).then((result) => {
	 			  if (result.isConfirmed) {
	 				
	 				  $.ajax({
	 					 url:"updateIdCheck", 
			 			  type:"get",
			 			  dataType:"json",
			 			  data: {"order_code":selectedOrder},
			 			  success:moUpdate,
			 			  error: function(){
			 				 Swal.fire({
			 					  title: "수정오류",
			 					  text: "해당 주문 건의 관리자에게 문의하십시오.",
			 					  icon: "warning"
			 					});

	 				  }	 
	 				 });
	 		 
	 	 }

	 });
 }
 
	 }
 
 }
 


function infoClear(){
	
	 $("#checkUser").val('');
	 $("#checkName").val('');
	 $("#user_pw").val('');
	
	 if ($("#update-btn").length > 0) {
		  $("#update-btn").remove();
		}
	 if($("#deliver-btn").length > 0){
		 $("#deliver-btn").remove();
	 }
	 
	}
 
 function moUpdate(data){
	$("#shippingCheck").modal('show');
	$("#checkUser").val(data.user_id);
	$("#checkName").val(data.user_name);
	$("#shippingCheckModal").append("<button type='button' class='btn dark-green-btn' id='update-btn' onclick='return updatePw()'>비밀번호 확인</button>");

		
 }
 
 function updatePw(){
	 var user_id = $("#checkUser").val();
	 var user_pw = $("#user_pw").val();
	 $.ajax({
		  url: "updatePwCheck",
		  type:"post",
		  dataType: "json",
		  data: {"user_pw": user_pw, "order_code":selectedOrder, "user_id": user_id},
		  success: function(data) {
			    moUpdateCheck(data);
		  }, 
		  error: function() {
			  Swal.fire({
				  title: "관계자에게 문의하세요",				
				  icon: "warning"
				});
		  }
		});
	 
 }
 
 function moUpdateCheck(data){
	 var ship_date = data.ship_date;
	
	 
	 if(data.check == "true"){	
		 $("#mo-close").trigger('click');
		 // 오늘 날짜
		 var today = new Date();	 
		    
		// 마지막일 설정 
		    var orderDate = new Date(data.order_date);
          
		    var maxDate = new Date(orderDate);
		    maxDate.setDate(orderDate.getDate() - 3);
		

		    
		    
		 Swal.fire({
			  title: "출하예정일을 입력하세요.",
			  input: "date",
			  didOpen: () => {
		            // date input의 max 속성 설정
		            const input = $('input[type="date"]');
		            
		            // maxDate를 'YYYY-MM-DD' 형식의 문자열로 변환하여 설정
		            input.attr('max', maxDate.toISOString().split('T')[0]);
		            
		         // date input의 min 속성 설정
		            input.attr('min', today.toISOString().split('T')[0]);
		        }
		    }).then((result) => {
			  if (result.value) {
			    const scheduled_date = result.value; 
			    
			    $.ajax({
					  url: "checkSchedule",
					  type: "post",
					  dataType: "json",
					  data: {"scheduled_date": scheduled_date},
					  success: function(data) {
						  scheduleCheck(data,scheduled_date,ship_date);
					  },
					  error: function() {
						  Swal.fire({
							  title: "관계자에게 문의하세요",				
							  icon: "warning"
							});
					  }
					});
			  }
			});
			
			
	 }else if(data.check == "false"){
		 Swal.fire({
			  title: "비밀번호 오류",
			  text: "담당자 비밀번호를 확인하세요.",
			  icon: "error"
			});
	 }
 }
 
 function scheduleCheck(data,scheduled_date,ship_date){
	 var date = new Date(ship_date);
	 var sd =date.toISOString().split('T')[0];
	 Swal.fire({
		  title: "예약출하 일정을 변경하시겠습니까?",
		  text: "해당 주문건의 예약출하일정은 "+sd+" 입니다.",
		  icon: "info",
		  showCancelButton: true,
		  cancelButtonText: "취소",
		  confirmButtonColor: "#6e9888",
		  cancelButtonColor: "#666666",
		  confirmButtonText: "확인"
		}).then((result) => {
		  if (result.isConfirmed) {
				 Swal.fire({
					  title: "예약출하 일정을 변경",
					  text: "현재 "+scheduled_date+" 에 예정된 출하건은 "+data+"개 입니다. 해당일에 추가하시겠습니까?",
					  icon: "info",
					  showCancelButton: true,
					  cancelButtonText: "취소",
					  confirmButtonColor: "#6e9888",
					  cancelButtonColor: "#666666",
					  confirmButtonText: "확인"
					}).then((result) => {
					  if (result.isConfirmed) {
						  $.ajax({
							  url: "changeShipSchedule",
							  dataType: "text",
							  type: "post",
							  data: {"scheduled_date": scheduled_date, "order_code":selectedOrder},
							  success: scheduledUpdateSuccess,
							  error: function() {
								  Swal.fire({
									  title: "관계자에게 문의하세요",				
									  icon: "warning"
									});
							  }
							});
					  }
					});
		  }
		});

 }
 
function scheduledUpdateSuccess(data){
	Swal.fire({
	    title: "수정완료",
	    text: "주문번호 " + data + "의 출하예정일이 변경되었습니다.",
	    icon: "success"
	}).then(() => {
		$("#pageForm").submit();
		
	});
}



function checkSearchSub(e){
	if(radioCnt>=1){
		return true;
	}
	else if($("#searchType").val() === ""){
		 Swal.fire({
		        title: "검색타입을 선택하세요.",
		        icon: "warning"
		    }).then((result) => {
		        if (result.isConfirmed) {
		            $("#searchType").focus();
		        }       
		    });
	             return false;
		
		
	}
	
	else if($("#searchType").val() == "ship_code" && $("#putSearch").val() == ""){
		Swal.fire({
	        title: "검색어를 입력하세요.",
	        icon: "warning"
	    }).then((result) => {
	        if (result.isConfirmed) {
	            $("#putSearch").focus();
	        }       
	    });
             return false;
	}
	
	else if($("#searchType").val() == "company_name" && $("#putSearch").val() == ""){
		Swal.fire({
			title: "검색어를 입력하세요.",
	        icon: "warning"
	    }).then((result) => {
	        if (result.isConfirmed) {
	            $("#putSearch").focus();
	        }       
	    });
             return false;
	}
	

	
	
}