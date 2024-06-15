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
<link href="/css/recruitList.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<div class="title">마이페이지 공고리스트</div>
		<div class="recruit_list"></div>
		
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

const recruitListContainer = document.querySelector(".recruit_list");
const xhttp = new XMLHttpRequest();

xhttp.onload = function() {
	console.log(JSON.parse(this.responseText));
	let data = JSON.parse(this.responseText);
	if (data && data.length > 0) {
	data.forEach(data=>{
		let displayDate = data.moddate ? data.moddate.slice(0, 10) : data.regdate.slice(0, 10);
		  const listItem = document.createElement('div');
          listItem.innerHTML = "<div><div><a href='/company/recruitDetail?jno="+ data.jno + "'>" + data.wantedTitle +"</a></div><div> 최종수정날짜 : "  + displayDate + "</div> <span style='display:none;' class='jno'>"+ data.jno+"</span> <button class='btn btn-onepick' onclick='editJobad(event)'>수정</button> <button class='btn btn-onepick' onclick='deleteJobad(event)'>삭제</button></div>";
          recruitListContainer.appendChild(listItem);
	})
	}else{
		 // 공고가 없을경우
        recruitListContainer.innerHTML = '등록된 공고가 아직 존재하지 않습니다.';
	}
  }
xhttp.open("GET", "http://localhost:9001/api/v1/recruit/myrecruit", true);
xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
xhttp.setRequestHeader("username", localStorage.getItem("username"));
xhttp.setRequestHeader("role", localStorage.getItem("role"));
xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role")
xhttp.send();


function editJobad(e){
	let jno = e.target.parentElement.querySelector('.jno').innerText;
	location.href="/company/recruitEdit?jno="+jno;
	console.log(e.target.parentElement.querySelector('.jno').innerText)
}
function deleteJobad(e){
	let jno = e.target.parentElement.querySelector('.jno').innerText;
	console.log(e.target.parentElement.querySelector('.jno').innerText)
	
	xhttp.onload = function() {
		if(this.responseText == "done"){
			alert("해당 공고가 성공적으로 삭제되었습니다.")
			//html에서 지워주기
			e.target.parentElement.remove();
		}
	  }
	xhttp.open("DELETE", "http://localhost:9001/api/v1/recruit/"+jno, true);
	xhttp.send();

}
</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>