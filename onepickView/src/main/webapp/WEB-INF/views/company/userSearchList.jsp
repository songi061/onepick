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
<link href="/css/userSearchList.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<h3 class="page_title">인재채용</h3>
		<div id="resumeList" class="row mb-5">
		</div>
	</div>
	


<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
const token = localStorage.getItem("jwtToken");
const token_username = localStorage.getItem("username");
const token_role = localStorage.getItem("role");
const resumeList = document.querySelector("#resumeList");

const xhttp = new XMLHttpRequest();
xhttp.onload = function () {
	let objs = JSON.parse(this.responseText);
	objs.forEach(obj => {
		console.log(obj);
		let logoSrc = obj.user.fileName == null ? "/img/no_img.jpg" : "/images/" + obj.user.fileName;
		console.log(logoSrc);
		let currentTime = Date.now();
		console.log(obj.user.birthDate);
		let birthTime = new Date(obj.user.birthDate).getTime();
		console.log(birthTime);
		// 현재 시간과 생일 시간의 차이를 계산하여 나이를 밀리초에서 년으로 변환
		let ageInMilliseconds = currentTime - birthTime;
		let ageInYears = ageInMilliseconds / (1000 * 60 * 60 * 24 * 365.25); // 1년을 평균적으로 365.25일로 계산
		let age = Math.floor(ageInYears);
		console.log();
		document.querySelector("#resumeList").innerHTML += 
			"<div class='col-md-6 col-xl-4'>"
			+ "<a class='d-block underline-none border p-4 rounded d-flex pointer' href='/user/resumeDetail?rno=" + obj.resume.rno +"'>"
			+ "<div class='profileImg_box me-3'>"
			+ "<img src=" + logoSrc + " alt='사진'>"
			+ "</div>"
			+ "<div>"
			+ "<div class='fs-4 fw-bold text-ellipsis'>" + obj.resume.title + "</div>"
			+ "<div>" + obj.user.name + "(" + obj.user.gender + ", 만 " + age + "세)</div>"
			+ "<div>" + obj.resume.job + "</div>"
			+ "<div>" + obj.major + " " + obj.s_status + "</div>"
			+ "</div></a></div>";
	});
	
}
xhttp.open("GET", "http://localhost:9001/api/v1/resume-search");
xhttp.setRequestHeader("Authorization", "Bearer " + token);
xhttp.setRequestHeader("Access-Control-Expose-Headers", "Authorization");
xhttp.send();
  
	
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>