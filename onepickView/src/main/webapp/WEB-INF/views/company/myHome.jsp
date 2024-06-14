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
			<div class="profileImg_box position-relative">
				<img src="" alt="회사로고">
				<button class="btn btn-sm btn-onepick position-absolute" data-bs-toggle="modal" data-bs-target="#exampleModal" style="bottom:0; right:0"><i class="bi bi-pencil-fill"></i></button>
			</div>
			<div>
				<div class="fw-blod fs-4" id="companyName">회사이름</div>
				<div>⭐"평점" <span id="companyScore"></span> <span class="text-secondary mx-2"> | </span> <span id="companySector">섹터</span> <span class="text-secondary mx-2"> | </span> <span id="companyCeo">ceo</span> <span class="text-secondary mx-2"> | </span> <span id="companyEmployeesNum">employeesNum</span> <span class="text-secondary mx-2"> | </span> <span id="companySize">size</span> <span class="text-secondary mx-2"> | </span> <span id="companyYrSales">yrSales</span> <span class="text-secondary mx-2"> | </span> <span id="companyUrl">url</span></div>
			</div>
		</div>
		<div class='title'>내 공고 리스트</div>
		<button>더보기</button>
		<div class="myrecruit_list">
		dddd
		</div>
		<div class="links">
			<div><a href=''>채용공고작성</a></div>
			<div><a href=''>스크랩한지원자</a></div>
			<div><a href=''>지원내역관리</a></div>
			<div><a href=''>QnA관리</a></div>
		</div>
		
	</div>
	
	<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">사진 변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input type="file" name="logo">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="updateLogo()">변경</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let data = JSON.parse(this.responseText);
		document.querySelector("#companyName").innerHTML = data.name;
		document.querySelector("#companyScore").innerHTML = "점수넣어줘ㅓ";
		document.querySelector("#companySector").innerHTML = data.sector;
		document.querySelector("#companyCeo").innerHTML = data.ceo;
		document.querySelector("#companyEmployeesNum").innerHTML = data.employeesNum;
		document.querySelector("#companySize").innerHTML = data.size;
		document.querySelector("#companyYrSales").innerHTML = data.yrSales;
		document.querySelector("#companyUrl").innerHTML = data.url;
		
		if(data.logo == null){
			document.querySelector(".profileImg_box img").src="/img/no_img.jpg";
		}else{
			document.querySelector(".profileImg_box img").src="/img/" + data.logo;
		}
		
		//document.querySelector(".company_myInfo").innerHTML = 
		//	"<img src='' alt='로고'><div>" + data.name +"</div><div> "+ "평점" +"</div><div>"+ data.sector +"</div><div>" 
		//	+ data.ceo + "</div><div>"  + data.employeesNum + "</div><div>"  + data.size + "</div><div>" + data.yrSales + "</div><div>"  + data.url + "</div>";
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/company/mydetail", true);
	xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
	xhttp.setRequestHeader("username", localStorage.getItem("username"));
	xhttp.setRequestHeader("role", localStorage.getItem("role"));
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role");
	xhttp.send();
	
	function updateLogo(){
		document.querySelector("input[name='logo']");
	}
	
	
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>