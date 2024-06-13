<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="/css/style.css" rel="stylesheet">
<link href="/css/registLogin.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100 bg-light">
<div class="regForm form-signin m-auto py-3">
	<a href="/" class="d-block header_logo_size mx-auto mb-3">
		<img class="img-fluid" src="/img/logo.png" alt="logo">
	</a>
	<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
	  <li class="nav-item w-50" role="presentation">
	    <button class="nav-link w-100 active" id="pills-user-tab" data-bs-toggle="pill" data-bs-target="#pills-user" type="button" role="tab" aria-controls="pills-user" aria-selected="true">개인회원</button>
	  </li>
	  <li class="nav-item w-50" role="presentation">
	    <button class="nav-link w-100" id="pills-company-tab" data-bs-toggle="pill" data-bs-target="#pills-company" type="button" role="tab" aria-controls="pills-company" aria-selected="false">기업회원</button>
	  </li>
	  
	</ul>
	<div class="tab-content bg-white p-4 rounded " id="pills-tabContent">
	  <div class="tab-pane fade show active" id="pills-user" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
		  <div class="mb-3">
		   	<label class="form-label">아이디</label>
	  		<input type="text" name="username" class="form-control" placeholder="아이디">
	  		<div id="userIdcheck_msg"></div>
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">비밀번호</label>
	  		<input type="password" name="password" class="form-control" placeholder="비밀번호">
		  </div>
		  <button class="btn btn-onepick w-100" onclick="loginUser()">로그인</button>
	  </div>
	  <div class="tab-pane fade" id="pills-company" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
	  	<div class="mb-3">
		   	<label class="form-label">아이디</label>
	  		<input type="text" name="username" class="form-control" placeholder="아이디">
	  		<div id="companyIdcheck_msg"></div>
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">비밀번호</label>
	  		<input type="password" name="password" class="form-control" placeholder="비밀번호">
		  </div>
		  <button class="btn btn-onepick w-100" onclick="loginCompany()">로그인</button>
	  </div>
	  <div class="d-flex pt-3 border-top mt-3">
	  	<div>아직 회원이 아니세요?</div>
	  	<a class="ms-auto link-success" href="/regForm">회원가입</a>
	  </div>
	</div>
</div>
<script>
	function logintUser(){
		const username = document.querySelector("#pills-user").querySelector("input[name='username']");
		const name = document.querySelector("#pills-user").querySelector("input[name='name']");
		const password = document.querySelector("#pills-user").querySelector("input[name='password']");
		const birthDate = document.querySelector("#pills-user").querySelector("input[name='birthDate']");
		const gender = document.querySelector("#pills-user").querySelector("input[name='gender']");
		const email = document.querySelector("#pills-user").querySelector("input[name='email']");
		const tel = document.querySelector("#pills-user").querySelector("input[name='tel']");
		const addr = document.querySelector("#pills-user").querySelector("input[name='addr']");
		const militaryService = document.querySelector("#pills-user").querySelector("input[name='militaryService']");
		const user = {
			username : username.value,
			name : name.value,
			password : password.value,
			birthDate : birthDate.value,
			gender : gender.value,
			email : email.value,
			tel : tel.value,
			addr : addr.value,
			militaryService : militaryService.value
		}
		const sendData = JSON.stringify(user);
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function() {
		  console.log(this.responseText);
		  }
		xhttp.open("POST", "http://localhost:9001/api/v1/register/user", true);
		xhttp.setRequestHeader("Content-type", "application/json");
		xhttp.send(sendData);
	}
	
	function loginCompany(){
		const username = document.querySelector("#pills-company").querySelector("input[name='username']");
		const name = document.querySelector("#pills-company").querySelector("input[name='name']");
		const password = document.querySelector("#pills-company").querySelector("input[name='password']");
		const ceo = document.querySelector("#pills-company").querySelector("input[name='ceo']");
		const num = document.querySelector("#pills-company").querySelector("input[name='num']");
		const addr = document.querySelector("#pills-company").querySelector("input[name='addr']");
		const sector = document.querySelector("#pills-company").querySelector("select[name='sector']");
		const employeesNum = document.querySelector("#pills-company").querySelector("input[name='employeesNum']");
		const url = document.querySelector("#pills-company").querySelector("input[name='url']");
		const size = document.querySelector("#pills-company").querySelector("select[name='size']");
		const yrSales = document.querySelector("#pills-company").querySelector("input[name='yrSales']");
		console.log(sector.value);
		
		const company = {
				username : username.value,
				name : name.value,
				password : password.value,
				ceo : ceo.value,
				num : num.value,
				addr : addr.value,
				sector : sector.value,
				employeesNum : employeesNum.value,
				url : url.value,
				size : size.value,
				yrSales : yrSales.value
			}
			const sendData = JSON.stringify(company);
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
			  console.log(this.responseText);
			  }
			xhttp.open("POST", "http://localhost:9001/api/v1/register/company", true);
			xhttp.setRequestHeader("Content-type", "application/json");
			xhttp.send(sendData);
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>