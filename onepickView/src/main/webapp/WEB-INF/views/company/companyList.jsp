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
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="/js/CloseBrowserClearlocalStorage.js"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<div class="page_title">기업 목록</div>
		<div class="company_list">	</div>
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
const listContainer = document.querySelector('.company_list');

    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let data = JSON.parse(this.responseText);
		  if (data && data.length > 0) {
           data.forEach(company => {
               const listItem = document.createElement('div');
               listItem.className = 'company';
               listItem.innerHTML = "<div><a class='company_detail' href='/company/companyDetail?username="+ company.username +"'>"+ company.name+"</a></div><div>" +company.sector+
               "</div> <div>" + company.size + "</div><div>사원수 : "+ company.employeesNum+
               " 명 </div><div>연매출액 : " + company.yrSales + " 원 </div><div>주소 : " + company.addr +
               "</div>";
               listContainer.appendChild(listItem);
           });
		  }else{
			  // 기업리스트가 없을경우
		        listContainer.innerHTML = '등록된 기업이 존재하지 않습니다.';
		  }
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/company/", true);
	xhttp.send();
	
	function pageActive(){
		// 기존의 'active' 클래스를 제거합니다.
		document.querySelector("header .nav-item a").classList.remove('active');
		// 'active' 클래스를 추가합니다.
		document.querySelectorAll("header .companyPage").forEach(function(element) {
		    element.classList.add('active');
		});
	}
	pageActive();
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>