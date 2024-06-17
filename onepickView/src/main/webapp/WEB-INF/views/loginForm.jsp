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
	  	<form name="frmUser">
		  <div class="mb-3">
		   	<label class="form-label">아이디</label>
	  		<input type="text" name="username" class="form-control" placeholder="아이디">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">비밀번호</label>
	  		<input type="password" name="password" class="form-control" placeholder="비밀번호">
		  </div>
		  <button class="btn btn-onepick w-100" onclick="loginUser(event)">로그인</button>
		 </form>
	  </div>
	  <div class="tab-pane fade" id="pills-company" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
	  	<form name="frmCompany">
	  		<div class="mb-3">
			   	<label class="form-label">아이디</label>
		  		<input type="text" name="username" class="form-control" placeholder="아이디">
		  	</div>
		  	<div class="mb-3">
		   		<label class="form-label">비밀번호</label>
	  			<input type="password" name="password" class="form-control" placeholder="비밀번호">
		  	</div>
		  	<button class="btn btn-onepick w-100" onclick="loginCompany(event)">로그인</button>
		  </form>
	  </div>
	  
	  <div class="d-flex pt-3 border-top mt-3">
	  	<div>아직 회원이 아니세요?</div>
	  	<a class="ms-auto link-success" href="/regForm">회원가입</a>
	  </div>
	</div>
</div>
<script>
	function loginUser(e){
		e.preventDefault();
		const form = document.forms['frmUser'];
		var formData = new FormData(form);
		var params = new URLSearchParams();

	    for (var pair of formData.entries()) {
	        params.append(pair[0], pair[1]);
	    }
		
	    var serializedData = params.toString();
	    console.log(serializedData);
	
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function() {
			if (xhttp.status === 200) {
				var headers = xhttp.getAllResponseHeaders();
				console.log("headers : " + headers);
				var token = xhttp.getResponseHeader("Authorization");
				console.log("JWT Token: " + token.split(" ")[1]);
				
				localStorage.setItem("jwtToken", token.split(" ")[1]);
				// 헤더 값 읽기
				let role = xhttp.getResponseHeader("Role");
				let username = xhttp.getResponseHeader("username");
				if(role=="ROLE_COMPANY"){
					alert("로그인에 실패했습니다.");
					
				}else{
					localStorage.setItem("role", role);
					localStorage.setItem("username", username);
					
					console.log("role : " + role);
					console.log("username : " + username);
					location.href="/";
				}
				
			}else{
				 alert("로그인에 실패했습니다. 아이디와 비밀번호를 확인해주세요.");
			}
		}
		xhttp.open("POST", "http://localhost:9001/login");
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send(serializedData);
	}
	
	function loginCompany(e){
		e.preventDefault();
		const form = document.forms['frmCompany'];
		var formData = new FormData(form);
		var params = new URLSearchParams();

	    for (var pair of formData.entries()) {
	        params.append(pair[0], pair[1]);
	    }
		
	    var serializedData = params.toString();
	    console.log(serializedData);
	
	   
	    const xhttp = new XMLHttpRequest();
		xhttp.onload = function() {
			if (xhttp.status === 200) {
				var headers = xhttp.getAllResponseHeaders();
				console.log("headers : " + headers);
				var token = xhttp.getResponseHeader("Authorization");
				console.log("JWT Token: " + token.split(" ")[1]);
				
				localStorage.setItem("jwtToken", token.split(" ")[1]);
				// 헤더 값 읽기
				let role = xhttp.getResponseHeader("Role");
				let username = xhttp.getResponseHeader("username");
				localStorage.setItem("role", role);
				localStorage.setItem("username", username);
				
				if(role=="ROLE_USER"){
					alert("로그인에 실패했습니다.");
					
				}else{
					localStorage.setItem("role", role);
					localStorage.setItem("username", username);
					
					console.log("role : " + role);
					console.log("username : " + username);
					location.href="/";
				}
				
			}else{
				 alert("로그인에 실패했습니다. 아이디와 비밀번호를 확인해주세요.");
			}
		}
		xhttp.open("POST", "http://localhost:9001/login");
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send(serializedData);
		
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>