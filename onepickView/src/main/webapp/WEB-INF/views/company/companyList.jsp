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
<link href="/css/companyList.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<div class="title">기업 목록</div>
		<div class="recruit_list">
		
		</div>
		
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let data = JSON.parse(this.responseText);
		console.log(data);
		
// 		const listContainer = document.querySelector('.recruit_list');
//            data.forEach(company => {
//                const listItem = document.createElement('div');
//                listItem.className = 'company';
//                listItem.innerHTML = "<div><a href='/company/companyDetail?username="+ company.username +"'>회사명 :"+ company.name+"</a></div><div>업종 : " +company.sector+
//                "</div> <div>회사규모 : " + company.size + "</div><div>사원수 : "+ company.employeesNum+
//                "</div><div>연매출액 : " + company.yrSales + "</div><div>주소 : "+company.addr +
//                "</div><div id='icon'><span>♡</span><span>☆</span></div>";
//                listContainer.appendChild(listItem);
//            });
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/recruit/myrecruit", true);
	xhttp.send();
</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>