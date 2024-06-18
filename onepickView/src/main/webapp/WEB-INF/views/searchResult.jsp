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
			<h3 class="page_title">" <span id="keyword" class="text-danger">${keyword}</span> " 검색 결과</h3>
			<hr class="border"/>
			<h3 class="mt-4 mb-3">공고리스트</h3>
			<div id="jobAdList" class="row mb-5">
			</div>
			
			<h3 class="mt-4 mb-3">커뮤니티 리스트</h3>
			<div id="userCommunityList" class="row mb-5">
			</div>
			
		</div>

		<script>
			const token = localStorage.getItem("jwtToken");
			const token_username = localStorage.getItem("username");
			const token_role = localStorage.getItem("role");
			const keyword = document.querySelector("#keyword").innerHTML;
			console.log(keyword);

			const xhttp4 = new XMLHttpRequest();
			xhttp4.onload = function () {
				let objs = JSON.parse(this.responseText);
				console.log(objs);
				if(objs.length != 0){
					objs.forEach(obj => {
						console.log(obj);
						let logoSrc = obj.company.fileName == null ? "/img/no_img.jpg" : "/images/" + obj.company.fileName;
						console.log(logoSrc);
						document.querySelector("#jobAdList").innerHTML = "";
						document.querySelector("#jobAdList").innerHTML += 
							"<div class='col-md-6 col-xl-4 mb-3'>"
						+ "<a class='d-block d-flex align-items-center border text-decoration-none rounded p-4 pointer recruit_box' href='/company/recruitDetail?jno=" + obj.jno + "''>"
						+ "<div class='logo w-25'><img src='" + logoSrc + "' alt='회사로고'></div>"
						+ "<div class='w-75 ps-3'>"
						+ "<div class='companyName fs-6'>" + obj.company.name + "</div>"
						+ "<div class='recruitTitle text-ellipsis fs-4 fw-bold'>" + obj.wantedTitle + "</div>"
						+ "<div class='fs-6 text-secondary'> 공고 마감일 " + obj.receiptCloseDt + "</div>"
						+ "<div class='recruitInfo text-ellipsis fs-6 text-secondary'> 모집 인원 " + obj.collectPsncnt + ", " + obj.position1 + ", " + obj.position2 + ", " + obj.region1 + ", " + obj.region2  + "</div>"
						+ "</div></a></div>";
					});
				}else{
					document.querySelector("#jobAdList").innerHTML = "";
					document.querySelector("#jobAdList").innerHTML = "<div class='col-12'><div class='border w-100 p-4 text-center text-secondary rounded'>검색 결과가 없습니다.</div>"
				}

			}
			xhttp4.open("GET", "http://localhost:9001/api/v1/main/recruit/allList/" + keyword);
			xhttp4.setRequestHeader("Authorization", "Bearer " + token);
			xhttp4.setRequestHeader("Access-Control-Expose-Headers", "Authorization");
			xhttp4.send();
			
			
			const xhttp1 = new XMLHttpRequest();
			xhttp1.onload = function () {
				let objs = JSON.parse(this.responseText);
				console.log(objs);
				if(objs.length != 0){
					objs.forEach(obj => {
						console.log(obj);
						document.querySelector("#userCommunityList").innerHTML = "";
						document.querySelector("#userCommunityList").innerHTML += 
							"<div class='col-md-12 mb-3'>"
						+ "<a class='d-block border text-decoration-none rounded p-4 pointer' href='/user/community-board/" + obj.ubno + "''>"
						+ "<div class='fs-5 fw-bold'>" + obj.title + "</div>"
						+ "<div>" + obj.content + "</div>"
						+ "</a></div>";
					});
				}else{
					document.querySelector("#userCommunityList").innerHTML = "";
					document.querySelector("#userCommunityList").innerHTML = "<div class='col-12'><div class='border w-100 p-4 text-center text-secondary rounded'>검색 결과가 없습니다.</div></div>"
				}

			}
			xhttp1.open("GET", "http://localhost:9001/api/v1/user/community-board/search-result/" + keyword);
			xhttp1.setRequestHeader("Authorization", "Bearer " + token);
			xhttp1.setRequestHeader("Access-Control-Expose-Headers", "Authorization");
			xhttp1.send();
			
			
			
			
		</script>
		<jsp:include page="layout/footer.jsp"></jsp:include>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
			crossorigin="anonymous"></script>
		<script src="/js/CloseBrowserClearlocalStorage.js"></script>
	</body>

	</html>