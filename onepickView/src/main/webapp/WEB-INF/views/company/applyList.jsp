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
<link href="/css/applyList.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<div class="title">지원 내역 리스트</div>
		<div class="apply_list">
		
		</div>
		
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let datas = JSON.parse(this.responseText);
		console.log(datas)
		
		const listContainer = document.querySelector('.apply_list');
           datas.forEach(data => {
               const listItem = document.createElement('div');
               listItem.className = 'apply_list_item';
               listItem.innerHTML = "<div>"+data.jobAd.wantedTitle+"</div><div><a href=''>"+ data.resume.title+"</a></div><div>"+data.user.name+"</div><div> 지원날짜 " +data.regdate.slice(0, 10)+
               "</div> <div>" + data.status + "</div>";
               listContainer.appendChild(listItem);
           });
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/apply/company", true);
	xhttp.setRequestHeader("username", "aaa");
	xhttp.setRequestHeader("role", "ROLE_COMPANY");
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "username, role")
	xhttp.send();
</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>