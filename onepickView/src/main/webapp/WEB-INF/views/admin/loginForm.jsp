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
<body class="d-flex flex-column h-100 min-h-100 text-bg-dark">
<div class="regForm form-signin m-auto py-3">
	<a href="/" class="d-block header_logo_size mx-auto mb-3 text-center" style="text-decoration:none;">
		<img class="img-fluid" src="/img/logo_white.png" alt="logo">
		<span class="text-white">관리자 서비스</span>
	</a>
	  <div>
	  	<form name="frmAdmin">
		  <div class="mb-3">
		   	<label class="form-label">아이디</label>
	  		<input type="text" name="username" class="form-control" placeholder="아이디">
		  </div>
		  <div class="mb-3">
		   	<label class="form-label">비밀번호</label>
	  		<input type="password" name="password" class="form-control" placeholder="비밀번호">
		  </div>
		  <button class="btn btn-primary w-100" onclick="loginAdmin(event)">로그인</button>
		 </form>
	  </div>
</div>
<script>
	function loginAdmin(e){
		
		e.preventDefault();
		const form = document.forms['frmAdmin'];
		var formData = new FormData(form);
		var params = new URLSearchParams();
		
		const id = document.querySelector("input[name='username']");
		console.log(id.value);
		if(id.value == "admin"){
		    for (var pair of formData.entries()) {
		        params.append(pair[0], pair[1]);
		    }
			
		    var serializedData = params.toString();
		    console.log(serializedData);
		
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				console.log(xhttp.status);
	
				if (xhttp.status === 200) {
			        // 로그인 성공
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
					
					console.log("role : " + role);
					console.log("username : " + username);
					location.href="/admintest";
			    } else {
			        // 로그인 실패
			        alert("로그인에 실패했습니다. 아이디와 비밀번호를 확인해주세요.");
			    }
				
			}
			xhttp.open("POST", "http://localhost:9001/login");
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send(serializedData);
			xhttp.onerror = function() {
			    alert("서버와의 통신 중 오류가 발생했습니다.");
			    // 오류 처리를 위한 추가 작업을 수행할 수 있습니다.
			};
		}else{
			alert("잘못된 접근입니다!");
		}
		
	}
	
	
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>