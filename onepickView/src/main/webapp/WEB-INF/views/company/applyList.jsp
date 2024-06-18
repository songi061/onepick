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
		<div class="apply_list"></div>
		
		<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">지원 상태 변경</h1>
        <button  type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input type="radio" value="지원완료" name="status">지원완료</input>
        <input type="radio" value="면접대기" name="status">면접대기</input>
        <input type="radio" value="면접완료" name="status">면접완료</input>
        <input type="radio" value="합격" name="status">합격</input>
        <input type="radio" value="불합격" name="status">불합격</input>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="changeBtn">변경</button>
      </div>
    </div>
  </div>
</div>
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
const listContainer = document.querySelector('.apply_list');

    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let datas = JSON.parse(this.responseText);
		if (datas && datas.length > 0) {
           datas.forEach(data => {
               const listItem = document.createElement('div');
               listItem.className = 'apply_list_item';
               listItem.innerHTML = "<span style='display:none;' class='jno'>"+data.jobAd.jno+"</span><div>"+data.jobAd.wantedTitle+"</div><div><a href='/user/resumeDetail?rno="+data.resume.rno+"'>"+ data.resume.title+"</a></div><div>"+data.user.name+"</div><div> 지원날짜 " +data.regdate.slice(0, 10)+
               "</div> <div><button onclick='changeStatus(event)' data-bs-toggle='modal' data-bs-target='#exampleModal'>" + data.status + "</button></div>";
               listContainer.appendChild(listItem);
           });
		}else{
			 // 지원한 지원자가 아직 없을경우
	        listContainer.innerHTML = '지원한 지원자가 아직 존재하지 않습니다.';
		}
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/apply/company", true);
	xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
	xhttp.setRequestHeader("username", localStorage.getItem("username"));
	xhttp.setRequestHeader("role", localStorage.getItem("role"));
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role")
	xhttp.send();
	
	
	function changeStatus(e){
		console.log(e.target.parentElement.parentElement)
		const rno = e.target.parentElement.parentElement.querySelector("a").href.split("=")[1]
		const jno = e.target.parentElement.parentElement.querySelector(".jno").innerText
		console.log(document.querySelector("#changeBtn"))
		console.log(jno)
		console.log(rno)
		
		document.querySelector("#changeBtn").addEventListener("click", function(){
			//뭐가 선택됐는지 체크
			const status = document.querySelector('input[name="status"]:checked').value;
			//버튼 누르면 ajax콜로 status업데이트 해주기
			 const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					console.log(this.responseText)
					location.href="/company/applyList";
				  }
				xhttp.open("PUT", "http://localhost:9001/api/v1/apply/status?status="+status+"&&rno="+rno+"&&jno="+jno, true);
				xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
				xhttp.setRequestHeader("username", localStorage.getItem("username"));
				xhttp.setRequestHeader("role", localStorage.getItem("role"));
				xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role")
				xhttp.send();
		})
	}
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>