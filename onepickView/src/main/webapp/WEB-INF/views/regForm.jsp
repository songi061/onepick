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
		   	<label class="form-label d-flex">아이디<button class="ms-auto btn btn-sm btn-onepick" onclick="userIdcheck()">중복확인</button></label>
	  		<input type="text" name="username" class="form-control" placeholder="아이디">
	  		<div id="userIdcheck_msg"></div>
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">비밀번호</label>
	  		<input type="password" name="password" class="form-control" placeholder="비밀번호">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">이름</label>
	  		<input type="text" name="name" class="form-control" placeholder="이름">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">생년월일</label>
	  		<input type="date" name="birthDate" class="form-control" placeholder="생년월일">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">이메일</label>
	  		<input type="email" name="email" class="form-control" placeholder="이메일">
		  </div>
	 	  <div class="mb-3">
		   	<label class="form-label">전화번호</label>
	  		<input type="tel" name="tel" class="form-control" placeholder="전화번호">
		  </div>
	   	  <div class="mb-3">
		   	<label class="form-label">주소</label>
	  		<input type="text" name="addr" class="form-control" placeholder="주소">
		  </div>
	   	  <div class="mb-3">
		   	<label class="form-label">성별</label><br/>
	  		<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" name="gender" id="gender1" value="남성" checked>
			  <label class="form-check-label" for="gender1">남성</label>
			</div>
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" name="gender" id="gender2" value="여성">
			  <label class="form-check-label" for="gender2">여성</label>
			</div>
		  </div>
	   	  <div class="mb-3">
		   	<label class="form-label">병역사항</label><br/>
	  		<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" name="militaryService" id="militaryService1" value="있음" checked>
			  <label class="form-check-label" for="militaryService1">병역사항 있음</label>
			</div>
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" name="militaryService" id="militaryService2" value="없음">
			  <label class="form-check-label" for="militaryService2">병역사항 없음</label>
			</div>
		  </div>
		  <button class="btn btn-onepick w-100" onclick="registUser()">회원가입</button>
	  </div>
	  <div class="tab-pane fade" id="pills-company" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
	  	<div class="mb-3">
		   	<label class="form-label d-flex">아이디<button class="ms-auto btn btn-sm btn-onepick" onclick="companyIdcheck()">중복확인</button></label>
	  		<input type="text" name="username" class="form-control" placeholder="아이디">
	  		<div id="companyIdcheck_msg"></div>
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">비밀번호</label>
	  		<input type="password" name="password" class="form-control" placeholder="비밀번호">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">회사명</label>
	  		<input type="text" name="name" class="form-control" placeholder="회사명">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">대표자</label>
	  		<input type="text" name="ceo" class="form-control" placeholder="대표자">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">사업자 번호</label>
	  		<input type="text" name="num" class="form-control" placeholder="사업자 번호">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">주소</label>
	  		<input type="text" name="addr" class="form-control" placeholder="주소">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">업종</label>
	  		<select id="sector" class="form-select" name="sector">
			</select>
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">사원수(명)</label>
	  		<input type="number" name="employeesNum" class="form-control" placeholder="사원수">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">기업 홈페이지</label>
	  		<input type="text" name="url" class="form-control" placeholder="기업 홈페이지">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">기업 규모</label>
	  		<select class="form-select" name="size">
	  			<option value="대기업">대기업</option>
	  			<option value="대기업 계열사·자회사">대기업 계열사·자회사</option>
	  			<option value="중소기업(300명이하)">중소기업(300명이하)</option>
	  			<option value="중견기업(300명이상)">중견기업(300명이상)</option>
	  			<option value="밴처기업">밴처기업</option>
	  			<option value="외국계(외국투자기업)">외국계(외국투자기업)</option>
	  			<option value="외국계(외국법인기업)">외국계(외국법인기업)</option>
	  			<option value="국내 공공기관·공기업">국내 공공기관·공기업</option>
	  			<option value="비영리단체·협회·교육재단">비영리단체·협회·교육재단</option>
	  			<option value="외국기관·비영리기구·단체">외국기관·비영리기구·단체</option>
			</select>
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">연 매출액</label>
	  		<input type="text" name="yrSales" class="form-control" placeholder="연 매출액">
		  </div>
		  <button class="btn btn-onepick w-100" onclick="registCompany()">회원가입</button>
	  </div>
	  <div class="d-flex pt-3 border-top mt-3">
	  	<div>이미 회원이세요?</div>
	  	<a class="ms-auto link-success" href="/loginForm">로그인</a>
	  </div>
	</div>
</div>
<script>
	const xhttp1 = new XMLHttpRequest();
	xhttp1.onload = function() {
	  let objs = JSON.parse(this.responseText);
	  //console.log(objs);
	  objs.forEach((obj)=>{
		  document.getElementById("sector").innerHTML += '<option value=' + obj["산업/업종명"] + '>' + obj["산업/업종명"] + '</option>';
	  });
	  //console.log(this.responseText);
	  }
	xhttp1.open("GET", "/json/sector_category.json", true);
	xhttp1.send();
	
	function userIdcheck(){
		const username = document.querySelector("#pills-user").querySelector("input[name='username']");
		console.log(username.value);
		const xhttp2 = new XMLHttpRequest();
		xhttp2.onload = function() {
			const responseText = this.responseText;
			document.getElementById("userIdcheck_msg").innerHTML = 
				  (responseText === "중복된 아이디입니다.") ? 
			                '<span class="text-danger">' + responseText + '</span>' :
			                '<span class="text-primary">' + responseText + '</span>';
		  }
		xhttp2.open("GET", "http://localhost:9001/api/v1/register/user?username=" + username.value, true);
		xhttp2.send();
	}
	
	function companyIdcheck(){
		const username = document.querySelector("#pills-company").querySelector("input[name='username']");
		console.log(username.value);
		const xhttp2 = new XMLHttpRequest();
		xhttp2.onload = function() {
			const responseText = this.responseText;
			document.getElementById("companyIdcheck_msg").innerHTML = 
				  (responseText === "중복된 아이디입니다.") ? 
			                '<span class="text-danger">' + responseText + '</span>' :
			                '<span class="text-primary">' + responseText + '</span>';
		  }
		xhttp2.open("GET", "http://localhost:9001/api/v1/register/company?username=" + username.value, true);
		xhttp2.send();
	}
	
	function registUser(){
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
	
	function registCompany(){
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