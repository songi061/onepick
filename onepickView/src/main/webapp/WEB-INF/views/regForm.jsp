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
			  <label class="form-check-label" for="militaryService2">병역사항 있음</label>
			</div>
		  </div>
		  <button class="btn btn-onepick w-100">회원가입</button>
	  </div>
	  <div class="tab-pane fade" id="pills-company" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
	  	<div class="mb-3">
		   	<label class="form-label">아이디</label>
	  		<input type="text" name="username" class="form-control" placeholder="아이디">
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
	  		<input type="text" name="sector" class="form-control" placeholder="업종">
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
	  		<input type="text" name="size" class="form-control" placeholder="기업 규모">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">연 매출액</label>
	  		<input type="text" name="yrSales" class="form-control" placeholder="연 매출액">
		  </div>
		  <button class="btn btn-onepick w-100">회원가입</button>
	  </div>
	  <div class="d-flex pt-3 border-top mt-3">
	  	<div>이미 회원이세요?</div>
	  	<a class="ms-auto link-success" href="/loginForm">로그인</a>
	  </div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>