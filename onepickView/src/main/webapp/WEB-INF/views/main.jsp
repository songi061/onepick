<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>1PICK!</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
			integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link href="/css/style.css" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	</head>

	<body class="d-flex flex-column h-100 min-h-100">
		<jsp:include page="layout/header.jsp"></jsp:include>
		<div class="container my-3">
			<div id="receipt_close_dt_list" class="row">
				<div class="col-md-6 col-xl-4 mb-3">
					<a class="d-block border text-decoration-none rounded p-4 pointer recruit_box" href="#">
						<div class="logo">
							<img src="" alt="회사로고">
						</div>
						<div class="companyName fs-6">회사명</div>
						<div class="recruitTitle fs-4 fw-blod">공고제목</div>
						<div class="recruitInfo fs-6 text-secondary">
							공고내용 나열
						</div>
					</a>
				</div>
			</div>
		</div>

		<script>
			const token = localStorage.getItem("jwtToken");
			const token_username = localStorage.getItem("username");
			const token_role = localStorage.getItem("role");

			const xhttp = new XMLHttpRequest();
			xhttp.onload = function () {
				console.log(this.responseText);
				let objs = JSON.parse(this.responseText);
				console.log(objs);
				objs.forEach(obj => {
					let logoSrc = obj.company.fileName == null ? "/img/no_img" : "/images/" + obj.company.fileName;
					let html = `
						<div class='col-md-6 col-xl-4 mb-3'>
							<a class='d-block border text-decoration-none rounded p-4 pointer recruit_box' href='#'>
								<div class='logo'><img src='${logoSrc}' alt='회사로고'></div>
								<div class='companyName fs-6'>${obj.company.name}</div>
								<div class='recruitTitle fs-4 fw-bold'>${obj.wantedTitle}</div>
								<div class='recruitInfo fs-6 text-secondary'>${obj.sector1}</div>
							</a>
						</div>`;
					document.querySelector("#receipt_close_dt_list").innerHTML += html;
				});
				
			}
			xhttp.open("GET", "http://localhost:9001/api/v1/main/recruit/receipt-closedate");
			xhttp.setRequestHeader("Authorization", "Bearer " + token);
			//xhttp.setRequestHeader("username", token_username);
			//xhttp.setRequestHeader("role", token_role);
			xhttp.setRequestHeader("Access-Control-Expose-Headers", "Authorization");
			xhttp.send();
		</script>
		<jsp:include page="layout/footer.jsp"></jsp:include>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
			crossorigin="anonymous"></script>
	</body>

	</html>