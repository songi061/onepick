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
<link href="/css/company_myHome.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
	<div class='title'>My Home</div>
	<button class="btn btn-onepick" onclick="location.href='/company/companyEdit'">내정보수정</button>
		<div class="company_myInfo">
		</div>
		<div class='title'>내 공고 리스트</div>
		<button>더보기</button>
		<div class="myrecruit_list">
		dddddd
		</div>
		<div class="links">
			<div><a href=''>채용공고작성</a></div>
			<div><a href=''>스크랩한지원자</a></div>
			<div><a href=''>지원내역관리</a></div>
			<div><a href=''>QnA관리</a></div>
		</div>
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let data = JSON.parse(this.responseText);
		document.querySelector(".company_myInfo").innerHTML = 
			"<img src='' alt='로고'><div>" + data.name +"</div><div> ⭐"+ "평점" +"</div><div>"+ data.sector +"</div><div>" 
			+ data.ceo + "</div><div>"  + data.employeesNum + "</div><div>"  + data.size + "</div><div>" + data.yrSales + "</div><div>"  + data.url + "</div>";
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/company/mydetail", true);
	xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
	xhttp.setRequestHeader("username", localStorage.getItem("username"));
	xhttp.setRequestHeader("role", localStorage.getItem("role"));
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role");
	xhttp.send();
</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>