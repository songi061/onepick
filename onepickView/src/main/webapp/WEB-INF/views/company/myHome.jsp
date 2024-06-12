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
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
	마이페이지
	<button class="btn btn-onepick" onclick="location.href=''">내정보수정</button>
		<div class="company_myInfo">
		
		</div>
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
	
		let data = JSON.parse(this.responseText);
		console.log(data);
		document.querySelector(".company_myInfo").innerHTML = 
			"<img src='' alt='로고'><div>" + data.name +"</div><div> ⭐"+ "평점" +"</div><div>"+ data.sector +"</div><div>" 
			+ data.ceo + "</div><div>"  + data.employeesNum + "</div><div>"  + data.size + "</div><div>" + data.yrSales + "</div><div>"  + data.url + "</div>";
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/company/mydetail?username=aaa", true);
	xhttp.send();
</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>