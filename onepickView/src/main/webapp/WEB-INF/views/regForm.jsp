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
<div class="regForm form-signin m-auto">
	<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
	  <li class="nav-item w-50" role="presentation">
	    <button class="nav-link w-100 active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-user" aria-selected="true">개인회원</button>
	  </li>
	  <li class="nav-item w-50" role="presentation">
	    <button class="nav-link w-100" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-company" aria-selected="false">기업회원</button>
	  </li>
	  
	</ul>
	<div class="tab-content bg-white p-4 rounded " id="pills-tabContent">
	  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
	  	<input type="text" name="userusername" class="form-control mb-3" placeholder="아이디">
	   	<input type="password" name="userpassword" class="form-control mb-3" placeholder="비밀번호">
	  </div>
	  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">...</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>