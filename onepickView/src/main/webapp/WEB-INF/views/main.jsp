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
		<link href="/css/main.css" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	</head>

	<body class="d-flex flex-column h-100 min-h-100">
		<jsp:include page="layout/header.jsp"></jsp:include>
		<div class="container my-3">
			<h3 class="page_title">채용공고 <span class="fs-6">⏰마감일 순</span></h3>
			<div id="receipt_close_dt_list" class="row mb-5">
			</div>
			<div id="suggestion_section">
				<h3 class="page_title">추천 채용공고</h3>
				<div id="suggestion_list" class="row mb-5">
				</div>
			</div>
			<h3 class="page_title">전체 채용공고</h3>
			<div id="allJobAdList" class="row mb-5">
			</div>
		</div>

		<script>
			const token = localStorage.getItem("jwtToken");
			const token_username = localStorage.getItem("username");
			const token_role = localStorage.getItem("role");
			const suggestionSection = document.querySelector("#suggestion_section");

			const xhttp = new XMLHttpRequest();
			xhttp.onload = function () {
				let objs = JSON.parse(this.responseText);
				objs.forEach(obj => {
					console.log(obj);
					let logoSrc = obj.company.fileName == null ? "/img/no_img.jpg" : "/images/" + obj.company.fileName;
					console.log(logoSrc);
					document.querySelector("#receipt_close_dt_list").innerHTML += 
						"<div class='col-md-6 col-xl-4 mb-3'>"
					+ "<a class='d-block d-flex align-items-center border text-decoration-none rounded p-4 pointer recruit_box' href='/company/recruitDetail?jno=" + obj.jno + "''>"
					+ "<div class='logo w-25 me-3'><img src='" + logoSrc + "' alt='회사로고'></div>"
					+ "<div class='w-75'>"
					+ "<div class='companyName fs-6'>" + obj.company.name + "</div>"
					+ "<div class='recruitTitle fs-4 fw-bold'>" + obj.wantedTitle + "</div>"
					+ "<div class='fs-6 text-secondary'> 공고 마감일 " + obj.receiptCloseDt + "</div>"
					+ "<div class='recruitInfo text-ellipsis fs-6 text-secondary'> 모집 인원 " + obj.collectPsncnt + ", " + obj.position1 + ", " + obj.position2 + ", " + obj.region1 + ", " + obj.region2  + "</div>"
					+ "</div></a></div>";
				});
				
			}
			xhttp.open("GET", "http://localhost:9001/api/v1/main/recruit/receipt-closedate");
			xhttp.setRequestHeader("Authorization", "Bearer " + token);
			xhttp.setRequestHeader("Access-Control-Expose-Headers", "Authorization");
			xhttp.send();
			
			
			if(token_username != null && token_role == "ROLE_USER"){
				//alert("유저 확인!!!");
				const xhttp2 = new XMLHttpRequest();
				xhttp2.onload = function () {
					if(xhttp2.status == 200){
						let objs = JSON.parse(this.responseText);
						objs.forEach(obj => {
							console.log(obj);
							let logoSrc = obj.company.fileName == null ? "/img/no_img.jpg" : "/images/" + obj.company.fileName;
							console.log(logoSrc);
							document.querySelector("#suggestion_list").innerHTML += 
								"<div class='col-md-6 col-xl-4 mb-3'>"
							+ "<a class='d-block d-flex align-items-center border text-decoration-none rounded p-4 pointer recruit_box' href='/company/recruitDetail?jno=" + obj.jno + "''>"
							+ "<div class='logo w-25 me-3'><img src='" + logoSrc + "' alt='회사로고'></div>"
							+ "<div class='w-75'>"
							+ "<div class='companyName fs-6'>" + obj.company.name + "</div>"
							+ "<div class='recruitTitle fs-4 fw-bold'>" + obj.wantedTitle + "</div>"
							+ "<div class='fs-6 text-secondary'> 공고 마감일 " + obj.receiptCloseDt + "</div>"
							+ "<div class='recruitInfo text-ellipsis fs-6 text-secondary'> 모집 인원 " + obj.collectPsncnt + ", " + obj.position1 + ", " + obj.position2 + ", " + obj.region1 + ", " + obj.region2  + "</div>"
							+ "</div></a></div>";
						});
					}else{
						document.querySelector("#suggestion_section").style.display="none";
					}
				}
				xhttp2.open("GET", "http://localhost:9001/api/v1/main/recruit/suggestion");
				xhttp2.setRequestHeader("Authorization", "Bearer " + token);
				xhttp2.setRequestHeader("username", token_username);
				xhttp2.setRequestHeader("Access-Control-Expose-Headers", "Authorization, username");
				xhttp2.send();
			}else{
				document.querySelector("#suggestion_section").style.display="none";
			}
			
			const xhttp3 = new XMLHttpRequest();
			xhttp3.onload = function () {
				let objs = JSON.parse(this.responseText);
				objs.forEach(obj => {
					console.log(obj);
					let logoSrc = obj.company.fileName == null ? "/img/no_img.jpg" : "/images/" + obj.company.fileName;
					console.log(logoSrc);
					document.querySelector("#allJobAdList").innerHTML += 
						"<div class='col-md-6 col-xl-4 mb-3'>"
					+ "<a class='d-block d-flex align-items-center border text-decoration-none rounded p-4 pointer recruit_box' href='/company/recruitDetail?jno=" + obj.jno + "''>"
					+ "<div class='logo w-25 me-3'><img src='" + logoSrc + "' alt='회사로고'></div>"
					+ "<div class='w-75'>"
					+ "<div class='companyName fs-6'>" + obj.company.name + "</div>"
					+ "<div class='recruitTitle fs-4 fw-bold'>" + obj.wantedTitle + "</div>"
					+ "<div class='fs-6 text-secondary'> 공고 마감일 " + obj.receiptCloseDt + "</div>"
					+ "<div class='recruitInfo text-ellipsis fs-6 text-secondary'> 모집 인원 " + obj.collectPsncnt + ", " + obj.position1 + ", " + obj.position2 + ", " + obj.region1 + ", " + obj.region2  + "</div>"
					+ "</div></a></div>";
				});
				
			}
			xhttp3.open("GET", "http://localhost:9001/api/v1/main/recruit/allList");
			xhttp3.setRequestHeader("Authorization", "Bearer " + token);
			xhttp3.setRequestHeader("Access-Control-Expose-Headers", "Authorization");
			xhttp3.send();
			
		</script>
		<jsp:include page="layout/footer.jsp"></jsp:include>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
			crossorigin="anonymous"></script>
	</body>

	</html>