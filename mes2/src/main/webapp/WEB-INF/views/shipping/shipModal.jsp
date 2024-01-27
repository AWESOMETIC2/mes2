<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shipModal</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

</head>
<body>

<!-- Modal -->

<div class="modal fade" id="shippingInfo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="shippingInfoLabel"></h1>
        
      </div>
      <div class="modal-body mo" id="shippingInfoModal">
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



<div class="modal fade" id="shippingCheck" tabindex="-1" aria-labelledby="checkModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="shippingCheckModalLabel">비밀번호 확인</h1>
        
      </div>
      <div class="modal-body mo" id="shippingCheckModal">
      
	 <div>담당자 아이디 : <input type='text' id='checkUser' disabled/> </div>
	 <div>담당자 이름 : <input type='text' id='checkName'  disabled/> </div>
	 <div>비밀번호: <input type='password' id='user_pw'/></div>
	<!--  <button type='button' class='btn dark-green-btn' onclick='return updatePw()'>비밀번호 확인</button> -->
      </div>
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="mo-close" onclick='infoClear()'>닫기</button>       
      </div>
    </div>
  </div>
</div>



</body>
</html>