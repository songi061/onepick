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
		<div class='title'>내정보 수정</div>
		<div class="border rounded p-4 mb-3">
			<div class="row">
				<div class="col-md-6">
					<div class="mb-3">
					   	<label class="form-label">아이디</label>
				  		<input type="text" name="username" class="form-control" placeholder="아이디" readonly>
					 </div>
					 <div class="mb-3">
					   	<label class="form-label">비밀번호 <span class="form-text text-danger">* 변경하지 않을 경우 현재 비밀번호를 입력하세요.</span></label>
				  		<input type="password" name="password" class="form-control" placeholder="비밀번호">
					 </div>
					 <div class="mb-3">
					   	<label class="form-label">비밀번호 재확인</label>
				  		<input type="password" name="passwordRecheck" class="form-control" placeholder="비밀번호">
					 </div>
					 <div class="mb-3">
					   	<label class="form-label">회사명</label>
				  		<input type="text" name="name" class="form-control" placeholder="회사명">
					  </div>
					  <div class="mb-3">
					   	<label class="form-label">대표자</label>
				  		<input type="text" name="ceo" class="form-control" placeholder="대표자">
					  </div>
					  <div class="mb-3">
					   	<label class="form-label">사업자 번호</label>
				  		<input type="text" name="num" class="form-control" placeholder="사업자 번호">
					  </div>
					  <div class="mb-3">
					   	<label class="form-label">주소</label>
				  		<input type="text" name="addr" class="form-control" placeholder="주소">
					  </div>
				</div>
				<div class="col-md-6">
					  <div class="mb-3">
					   	<label class="form-label">업종</label>
				  		<select id="sector" class="form-select" name="sector">
						</select>
					  </div>
					  <div class="mb-3">
					   	<label class="form-label">사원수(명)</label>
				  		<input type="number" name="employeesNum" class="form-control" placeholder="사원수">
					  </div>
					  <div class="mb-3">
					   	<label class="form-label">기업 홈페이지</label>
				  		<input type="text" name="url" class="form-control" placeholder="기업 홈페이지">
					  </div>
					  <div class="mb-3">
					   	<label class="form-label">기업 규모</label>
				  		<select class="form-select" name="size">
				  			<option value="대기업">대기업</option>
				  			<option value="대기업 계열사·자회사">대기업 계열사·자회사</option>
				  			<option value="중소기업(300명이하)">중소기업(300명이하)</option>
				  			<option value="중견기업(300명이상)">중견기업(300명이상)</option>
				  			<option value="밴처기업">밴처기업</option>
				  			<option value="외국계(외국투자기업)">외국계(외국투자기업)</option>
				  			<option value="외국계(외국법인기업)">외국계(외국법인기업)</option>
				  			<option value="국내 공공기관·공기업">국내 공공기관·공기업</option>
				  			<option value="비영리단체·협회·교육재단">비영리단체·협회·교육재단</option>
				  			<option value="외국기관·비영리기구·단체">외국기관·비영리기구·단체</option>
						</select>
					  </div>
					  <div class="mb-3">
					   	<label class="form-label">연 매출액</label>
				  		<input type="text" name="yrSales" class="form-control" placeholder="연 매출액">
					  </div>	
				</div>
			</div>
		</div>
		<div class="mb-5 text-center">
		<button class="btn btn-onepick" onclick="editCompany(event)">수정하기</button>
		</div>
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
const token = localStorage.getItem("jwtToken");
const token_username = localStorage.getItem("username");
const token_role = localStorage.getItem("role");
console.log(token_username);

const username_ = document.querySelector("input[name='username']");
const name_ = document.querySelector("input[name='name']");
const password_ = document.querySelector("input[name='password']");
const passwordRecheck_ = document.querySelector("input[name='passwordRecheck']");
const ceo_ = document.querySelector("input[name='ceo']");
const num_ = document.querySelector("input[name='num']");
const addr_ = document.querySelector("input[name='addr']");
const sector_ = document.querySelector("select[name='sector']");
const employeesNum_ = document.querySelector("input[name='employeesNum']");
const url_ = document.querySelector("input[name='url']");
const size_ = document.querySelector("select[name='size']");
const yrSales_ = document.querySelector("input[name='yrSales']");
console.log(sector_.value);

const xhttp1 = new XMLHttpRequest();
xhttp1.onload = function() {
  let objs = JSON.parse(this.responseText);
  //console.log(objs);
  objs.forEach((obj)=>{
	  document.getElementById("sector").innerHTML += '<option value=' + obj["산업/업종명"] + '>' + obj["산업/업종명"] + '</option>';
  });
  //console.log(this.responseText);
  }
xhttp1.open("GET", "/json/sector_category.json", true);
xhttp1.send();

const xhttp2 = new XMLHttpRequest();
xhttp2.onload = function() {
 
	  let company = JSON.parse(this.responseText);
	  console.log(company);
	  username_.value = company.username;
	  name_.value = company.name;
	  ceo_.value = company.ceo;
	  num_.value = company.num;
	  addr_.value = company.addr;
	  sector_.value = company.sector;
	  employeesNum_.value = company.employeesNum;
	  url_.value = company.url;
	  size_.value = company.size;
	  yrSales_.value = company.yrSales;
  }
xhttp2.open("GET", "http://localhost:9001/api/v1/company/mydetail");
xhttp2.setRequestHeader("Authorization", "Bearer " + token);
xhttp2.setRequestHeader("username", token_username);
xhttp2.setRequestHeader("role", token_role);
xhttp2.setRequestHeader("Access-Control-Expose-Headers", "Authorization, username, role");
xhttp2.send();

function editCompany(event){
	
	if(password_.value != passwordRecheck_.value){
		alert("비밀번호가 맞지 않습니다. 다시 확인해주세요");
	}else if(password_.value.length == 0 || passwordRecheck_.value.length == 0){
		alert("비밀번호가 입력되지 않았습니다. 다시 확인해주세요");
	}else{
		const company = {
				username : username_.value,
				name : name_.value,
				password : password_.value,
				ceo : ceo_.value,
				num : num_.value,
				addr : addr_.value,
				sector : sector_.value,
				employeesNum : employeesNum_.value,
				url : url_.value,
				size : size_.value,
				yrSales : yrSales_.value
			}
			const sendData = JSON.stringify(company);
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
			  console.log(this.responseText);
			  location.href="/company/myHome";
			  }
			xhttp.open("PUT", "http://localhost:9001/api/v1/company/", true);
			xhttp.setRequestHeader("Content-type", "application/json");
			xhttp.setRequestHeader("Authorization", "Bearer " + token);
			xhttp.send(sendData);
	}
	
}

</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>