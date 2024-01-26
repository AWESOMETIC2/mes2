<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>salesModal</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

</head>
<body>

<!-- Modal -->

<div class="modal fade" id="salesInfo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="salesInfoLabel"></h1>
        
      </div>
      <div class="modal-body mo" id="salesInfoModal">
         <p>&lt;회사정보></p>	 
	     <div>회사명 : <input type='text' id='company_name' readonly/></div>
		 <div>회사코드 : <input type='text' id='company_code' readonly/></div>
		 <div>회사주소 : <input type='text' id='company_address' readonly/></div>
		 <div>회사전화번호 : <input type='text' id='company_call' readonly/></div>
		 
		 <p>&lt;담당자정보></p>
		 <div>담당자id : <input type='text' id='ifo_id'  readonly/></div>
		 <div>담당자이름 : <input type='text' id='user_name'  readonly/></div>
		 <div>담당자부서 : <input type='text' id='user_department'  readonly/></div>
		 <div>담당자직책: <input type='text' id='user_position'  readonly/></div>
		 <div>담당자부서 : <input type='text' id='user_auth'  readonly/></div>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="info-close" >닫기</button>      
      </div>
      
    </div>
  </div>
</div>



<div class="modal fade" id="salesCheck" tabindex="-1" aria-labelledby="checkModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="salesCheckModalLabel">비밀번호 확인</h1>
        
      </div>
      <div class="modal-body mo" id="salesCheckModal">
      
	 <div>아이디 : <input type='text' id='checkUser' disabled/> </div>
	
	 <div>비밀번호: <input type='password' id='user_pw'/></div>
	
      </div>
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="mo-close" onclick='infoClear()'>닫기</button>       
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="salesStockCheck" tabindex="-1" aria-labelledby="checkModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="salesStockCheckModalLabel">재고조회</h1>
        
      </div>
      <div class="modal-body mo" id="salesStockCheckModal">
     	
	     <div>제품명 : <input type='text' id='product_name' readonly/></div>
		 <div>제품코드 : <input type='text' id='product_code' readonly/></div>
		 <div>보유수량 : <input type='text' id='stock_quantity' readonly/></div>
		 <div>부족수량 : <input type='text' id='lack_quantity' readonly/></div> 
		 
		 
      </div>
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"  onclick='stockClear()'>닫기</button>       
      </div>
    </div>
  </div>
</div>



<div class="modal fade" id="salesPlanInfo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="salesPlanInfoLabel"></h1>
        
      </div>
      <div class="modal-body mo" id="salesPlanInfoModal">
         <p>&lt;회사정보></p>	 
	     <div>회사명 : <input type='text' id='planCompany_name' readonly/></div>
		 <div>회사코드 : <input type='text' id='planCompany_code' readonly/></div>
		 <div>회사주소 : <input type='text' id='planCompany_address' readonly/></div>
		 <div>회사전화번호 : <input type='text' id='planCompany_call' readonly/></div>	 
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="salesPlanInfo-close" >닫기</button>      
      </div>
      
    </div>
  </div>
</div>


</body>
</html>