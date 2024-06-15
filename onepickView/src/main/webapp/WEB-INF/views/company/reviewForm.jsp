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
<link href="/css/reviewForm.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<div class="title">평점 등록</div>
		<div class="interviewees_list">
		평점 등록할 수 있는 지원자가 존재하지 않습니다.
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="exampleModalLabel">지원자 아무개님</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body" >
			        <img id="star1" class="stars" style='width:30px; 'src="/icon/star.png"><img id="star2" class="stars" style='width:30px; 'src="/icon/star.png"><img id="star3" class="stars" style='width:30px; 'src="/icon/star.png"><img id="star4" class="stars" style='width:30px; 'src="/icon/star.png"><img id="star5" class="stars" style='width:30px; 'src="/icon/star.png">
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary" id="regBtn" data-bs-dismiss="modal">평점등록하기</button>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
		
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let datas = JSON.parse(this.responseText);
		console.log(datas)
		
		const listContainer = document.querySelector('.interviewees_list');
           datas.forEach(data => {
        	   console.log(data)
               const listItem = document.createElement('div');
               listItem.className = 'interviewees_list_item';
               let userName = data.user.name;
               listItem.innerHTML = "<div><div>"+ data.jobAd.wantedTitle+"</div><span style='display:none;' class='jno'>"+ data.jobAd.jno+"</span><div>"+ data.resume.title+"</div><span style='display:none;' class='userId'>"+ data.user.username+"</span><div class='user_name'>"+data.user.name+"</div><button data-bs-toggle='modal' data-bs-target='#exampleModal' class='btn btn-onepick' onclick='openRegModal(event)'>평점등록</button> </div>";
               listContainer.appendChild(listItem);
           });
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/company/review", true);
	xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
	xhttp.setRequestHeader("username", localStorage.getItem("username"));
	xhttp.setRequestHeader("role", localStorage.getItem("role"));
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role")
	xhttp.send();
	
	
	function openRegModal(e){
		let username = e.target.parentElement.querySelector(".user_name").innerText;
		let userId = e.target.parentElement.querySelector(".userId").innerText;
		let jno = e.target.parentElement.querySelector(".jno").innerText;
		//모달보여주고 
		const myModal = document.getElementById('exampleModal')
		let finalScore = 1;
		
		myModal.addEventListener('shown.bs.modal', () => {
			//맨위에 해당 지원자의 이름으로 바꿔주기
			document.querySelector("#exampleModalLabel").innerText = "지원자 " + username + " 님";
			
			//별모양 클릭 이벤트 핸들해주기
		  document.querySelectorAll(".stars").forEach(star=>{
			  star.addEventListener("click", function(e){
				  //새로 클릭시에 빈 별로 초기화해주기
				  let j = 1;
				  while(j<=5){
					  document.querySelector("#star" + j).src = "/icon/star.png"
					  j++;
				  }
				  
				  //별 클릭시 별모양 노란색으로 바꿔주기
				  let starId = Number(e.target.getAttribute("id").slice(4));
				  let i = 1;
				  while(i<=starId){
					  document.querySelector("#star" + i).src = "/icon/star_full.png"
					  i++;
				  }
				  finalScore = starId;
				  
			  })
		  })
		  
		  //평점등록 버튼 클릭시에 이벤트 핸들해주기 (btn btn-primary)
			document.querySelector("#regBtn").addEventListener("click", function(){
				//ajax콜 통해서 db에 정보저장스 :)
				console.log("등록해주세욥")
				const data = {"rating" : finalScore}
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					//화면 업데이트해주기(해당리스트 없애주기)
					e.target.parentElement.remove();
					
				  }
				xhttp.open("POST", "http://localhost:9001/api/v1/company/review?uid="+userId+"&jno="+jno, true);
				xhttp.setRequestHeader("Content-Type", "application/json"); 
				xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
				xhttp.setRequestHeader("username", localStorage.getItem("username"));
				xhttp.setRequestHeader("role", localStorage.getItem("role"));
				xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role")
				xhttp.send(JSON.stringify(data));
				
			})
		})
	}
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>