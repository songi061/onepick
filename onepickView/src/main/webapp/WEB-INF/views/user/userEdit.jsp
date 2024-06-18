<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>1PICK!</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
			integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
		<link href="/css/style.css" rel="stylesheet">
		<link href="/css/company_myHome.css" rel="stylesheet">
	</head>

	<body class="d-flex flex-column h-100 min-h-100">
		<jsp:include page="../layout/header.jsp"></jsp:include>
		<div class="container">
			<div class='title'>내정보 수정</div>
			<div class="border rounded p-4 mb-3">
				<div class="row">
					<div class="col-md-6">
						<div class="mb-3">
							<label class="form-label">아이디</label>
							<input type="text" name="username" class="form-control" placeholder="아이디" readonly>
						</div>
						<div class="mb-3">
							<label class="form-label">비밀번호 <span class="form-text text-danger">* 변경하지 않을 경우 현재 비밀번호를
									입력하세요.</span></label>
							<input type="password" name="password" class="form-control" placeholder="비밀번호">
						</div>
						<div class="mb-3">
							<label class="form-label">비밀번호 재확인</label>
							<input type="password" name="passwordRecheck" class="form-control" placeholder="비밀번호">
						</div>
						<div class="mb-3">
							<label class="form-label">이름</label>
						   <input type="text" name="name" class="form-control" placeholder="이름">
					   </div>
						<div class="mb-3">
							<label class="form-label">생년월일</label>
							<input type="date" name="birthDate" class="form-control" placeholder="생년월일">
						</div>
					</div>
					<div class="col-md-6">
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
							<label class="form-label">성별</label><br />
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="gender1" value="남성">
								<label class="form-check-label" for="gender1">남성</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="gender2" value="여성">
								<label class="form-check-label" for="gender2">여성</label>
							</div>
						</div>
						<div class="mb-3">
							<label class="form-label">병역사항</label><br />
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="militaryService"
									id="militaryService1" value="있음">
								<label class="form-check-label" for="militaryService1">병역사항 있음</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="militaryService"
									id="militaryService2" value="없음">
								<label class="form-check-label" for="militaryService2">병역사항 없음</label>
							</div>
						</div>
					</div>

				</div>
			</div>
			<div class="mb-5 text-center">
				<button class="btn btn-onepick" onclick="editUser(event)">수정하기</button>
			</div>
		</div>
		<jsp:include page="../layout/footer.jsp"></jsp:include>

		<script>
			const token = localStorage.getItem("jwtToken");
			const token_username = localStorage.getItem("username");
			const token_role = localStorage.getItem("role");
			console.log(token_username);

			const username_ = document.querySelector("input[name='username']");
			const name_ = document.querySelector("input[name='name']");
			const password_ = document.querySelector("input[name='password']");
			const passwordRecheck_ = document.querySelector("input[name='passwordRecheck']");
			const birthDate_ = document.querySelector("input[name='birthDate']");
			//const gender_ = document.querySelector("input[name='gender']");
			const gender_checked = document.querySelector("input[name='gender']:checked");
			const email_ = document.querySelector("input[name='email']");
			const tel_ = document.querySelector("input[name='tel']");
			const addr_ = document.querySelector("input[name='addr']");
			//const militaryService_ = document.querySelector("input[name='militaryService']");
			const militaryService_checked = document.querySelector("input[name='militaryService']:checked");
			const user = {
				username : username_.value,
				name : name_.value,
				password : password_.value,
				birthDate : birthDate_.value,
				gender : gender_checked ? gender_checked.value : "",
				email : email_.value,
				tel : tel_.value,
				addr : addr_.value,
				militaryService : militaryService_checked ? militaryService_checked.value : ""
			}

			
			const xhttp2 = new XMLHttpRequest();
			xhttp2.onload = function () {

				let user = JSON.parse(this.responseText);
				console.log(user);
				username_.value = user.username;
				name_.value = user.name;
				birthDate_.value = user.birthDate;
				addr_.value = user.addr;
				//gender_.value = user.gender;
				if(user.gender == "남성"){
					document.querySelector("#gender1").checked = true;
					document.querySelector("#gender2").checked = false;
				}else{
					document.querySelector("#gender2").checked = true;
					document.querySelector("#gender1").checked = false;
				}
				email_.value = user.email;
				tel_.value = user.tel;
				//militaryService_.value = user.militaryService;
				if(user.militaryService == "있음"){
					document.querySelector("#militaryService1").checked = true;
					document.querySelector("#militaryService2").checked = false;
				}else{
					document.querySelector("#militaryService2").checked = true;
					document.querySelector("#militaryService1").checked = false;
				}
			}
			xhttp2.open("GET", "http://localhost:9001/api/v1/user/mydetail");
			xhttp2.setRequestHeader("Authorization", "Bearer " + token);
			xhttp2.setRequestHeader("username", token_username);
			xhttp2.setRequestHeader("role", token_role);
			xhttp2.setRequestHeader("Access-Control-Expose-Headers", "Authorization, username, role");
			xhttp2.send();

			function editUser(event) {

				if (password_.value != passwordRecheck_.value) {
					alert("비밀번호가 맞지 않습니다. 다시 확인해주세요");
				} else if (password_.value.length == 0 || passwordRecheck_.value.length == 0) {
					alert("비밀번호가 입력되지 않았습니다. 다시 확인해주세요");
				} else {
										
					const user = {
						username: username_.value,
						name: name_.value,
						password: password_.value,
						birthDate: birthDate_.value,
						addr: addr_.value,
						gender: "",
						email: email_.value,
						tel: tel_.value,
						militaryService: ""
					}
					// 성별 처리
					if (document.querySelector("#gender1").checked) {
						user.gender = "남성";
					} else if (document.querySelector("#gender2").checked) {
						user.gender = "여성";
					}

					// 병역사항 처리
					if (document.querySelector("#militaryService1").checked) {
						user.militaryService = "있음";
					} else if (document.querySelector("#militaryService2").checked) {
						user.militaryService = "없음";
					}

					const sendData = JSON.stringify(user);
					const xhttp = new XMLHttpRequest();
					xhttp.onload = function () {
						console.log(this.responseText);
						location.href = "/user/myHome";
					}
					xhttp.open("PUT", "http://localhost:9001/api/v1/user/", true);
					xhttp.setRequestHeader("Content-type", "application/json");
					xhttp.setRequestHeader("Authorization", "Bearer " + token);
					xhttp.setRequestHeader("username", token_username);
					xhttp.setRequestHeader("Access-Control-Expose-Headers", "Authorization, username");
					xhttp.send(sendData);
				}

			}

		</script>
	</body>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="/js/CloseBrowserClearlocalStorage.js"></script>
	<script src="/js/userInterceptor.js"></script>

	</html>