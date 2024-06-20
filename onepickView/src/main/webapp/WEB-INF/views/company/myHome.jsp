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
<script src="/js/notification.js" type="module"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="/js/CloseBrowserClearlocalStorage.js"></script>
<script src="/js/companyInterceptor.js"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="sub_header border-bottom">
	<div class="container">
		<div class="d-flex py-2">
			<button class="btn text-onepick" type="button" onclick="location.href='/company/myHome'">
			   MyHome
			</button>
			<button class="btn" type="button" onclick="location.href='/company/scrapList'">
			   스크랩관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    채용공고관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/recruitList'">채용공고 조회</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/recruitForm'">채용공고 등록</button></li>
			  </ul>
			</div>
			<button class="btn" type="button" onclick="location.href='/company/applyList'">
			   지원내역관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    평점관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/reviewList'">평점 조회</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/reviewForm'">평점 등록</button></li>
			  </ul>
			</div>
			<button class="btn" type="button" onclick="location.href='/company/myQnaList'">
			   QnA관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    커뮤니티관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/myBoardList'">내가 쓴 글 리스트</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/myCommentList'">내가 쓴 댓글 목록</button></li>
			  </ul>
			</div>
		</div>
	</div>
</div>
	<div class="container">
	<div class='page_title'>🏠 My Home</div>
	<div class="d-flex">
		<img class="ms-auto"  data-bs-toggle="modal" data-bs-target="#exampleModal1" style="padding:5px; background-color:#42d056 ; border: 2px solid #42d056; width:40px; border-radius:10px;" src="/icon/notification-setting.png">
	</div>	
		<div class="company_myInfo bg-light">
			<div class="profileImg_box position-relative">
				<img src="" alt="회사로고">
				<button class="btn btn-sm btn-onepick position-absolute" data-bs-toggle="modal" data-bs-target="#exampleModal" style="bottom:0; right:0"><i class="bi bi-pencil-fill"></i></button>
			</div>
			<div>
				<div class="fw-blod fs-4"><span id="companyName">회사이름</span> <a class="fs-6 link-primary d-inline link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover" href="/company/companyEdit">내정보수정<i class="bi bi-arrow-right"></i></a></div>
				<div>⭐ <span id="companyScore"></span> <span class="text-secondary mx-2"> | </span> <span id="companySector">섹터</span> <span class="text-secondary mx-2"> | </span> <span id="companyCeo">ceo</span> <span class="text-secondary mx-2"> | </span> <span id="companyEmployeesNum">employeesNum</span> <span class="text-secondary mx-2"> | </span> <span id="companySize">size</span> <span class="text-secondary mx-2"> | </span> <span id="companyYrSales">yrSales</span> <span class="text-secondary mx-2"> | </span> <span id="companyUrl">url</span></div>
			</div>
		</div>
	
		<div class='title mb-3 clearfix'>
			<span>내 공고 리스트</span>
			<a class="showMoreBtn float-end fs-6 link-primary d-inline link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover cursor" href="/company/recruitList">더보기</a>
		</div>
			
		<div class="myrecruit_list">
		</div>
		<div class="row mb-5">
			<div class="col-3"><a class="btn btn-lg w-100 btn-outline-onepick" href='/company/recruitForm'>채용공고작성</a></div>
			<div class="col-3"><a class="btn btn-lg w-100 btn-outline-onepick" href='/company/scrapList'>스크랩한지원자</a></div>
			<div class="col-3"><a class="btn btn-lg w-100 btn-outline-onepick" href='/company/applyList'>지원내역관리</a></div>
			<div class="col-3"><a class="btn btn-lg w-100 btn-outline-onepick" href='/company/myQnaList'>QnA관리</a></div>
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
        <input type="file" name="file">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="updateFile(event)">변경</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">🔔 푸쉬 알림 받기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        웹 푸쉬 알림을 통해 필요한 소식을 모두 받아보실 수 있습니다.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">다음에</button>
        <button type="button" class="btn btn-primary" onclick="setNotification()">알림 받기</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
const recruitListContainer = document.querySelector(".myrecruit_list");
const showMoreBtn = document.querySelector(".showMoreBtn");

function goToEditForm(e){
	console.log(e.target.parentElement.parentElement.querySelector(".jno"))
	const jno = e.target.parentElement.parentElement.querySelector(".jno").innerText;
	
	location.href='/company/recruitEdit?jno='+jno
}
    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let data = JSON.parse(this.responseText);
		let myInfo = data.myInfo;
		let myJobad = data.myJobad;
		let displayUrl = myInfo.url ? myInfo.url : "<a href='/company/companyDetail?username="+localStorage.getItem("username")+"'>기업 상세페이지로 가기</a>"
		document.querySelector("#companyName").innerHTML = myInfo.name;
		document.querySelector("#companySector").innerHTML = myInfo.sector;
		document.querySelector("#companyCeo").innerHTML = myInfo.ceo;
		document.querySelector("#companyEmployeesNum").innerHTML = myInfo.employeesNum;
		document.querySelector("#companySize").innerHTML = myInfo.size;
		document.querySelector("#companyYrSales").innerHTML = myInfo.yrSales;
		document.querySelector("#companyUrl").innerHTML = displayUrl;
		if(myInfo.fileName == null){
			document.querySelector(".profileImg_box img").src="/img/no_img.jpg";
		}else{
			document.querySelector(".profileImg_box img").src="/images/" + myInfo.fileName;
		}
		
		if (myJobad && myJobad.length > 0) {
			 // 처음 세 개의 항목을 추가합니다.
		    myJobad.slice(0, 3).forEach(data => {
		    	const receiptCloseDate = new Date(data.receiptCloseDt);
			    const currentDate = new Date();
			    
			    // 날짜가 유효한지 확인 (빈 값인 경우를 대비)
			    let displayDate = receiptCloseDate ? receiptCloseDate.toISOString().slice(0, 10) : '';

			    const listItem = document.createElement('div');
			    listItem.className = 'bg-light ms-0 me-0 mt-0 mb-3 position-relative';
			    
			    // 공고마감일이 현재 날짜보다 빠른 경우
			    if (receiptCloseDate < currentDate) {
			    	  listItem.innerHTML = "<div><div><a class='fs-4 fw-bold' href='/company/recruitDetail?jno="
			    			  + data.jno + "'>" + data.wantedTitle +"</a></div><div> 공고마감일 : "  
			    			  + displayDate + "</div> <span style='display:none;' class='jno'>"
			    			  + data.jno+"</span> <div class='position-absolute' style='top:10px; right:10px'><button class='btn btn-onepick' disabled style='background-color:red;'>마감</button></div></div>";
			    }else{
			    	listItem.innerHTML = "<div><div><a class='fs-4 fw-bold' href='/company/recruitDetail?jno="
			    			+ data.jno + "'>" + data.wantedTitle +"</a></div><div> 공고마감일 : "  
			    			+ displayDate + "</div> <span style='display:none;' class='jno'>"
			    			+ data.jno+"</span> <div class='position-absolute' style='top:10px; right:10px'><button class='btn btn-sm btn-onepick' onclick='editJobad(event)'>수정</button> <button class='btn btn-sm btn-secondary' onclick='deleteJobad(event)'>삭제</button></div></div>";
			    	console.log("공고 아직 마감 아님")
			    }
		          recruitListContainer.appendChild(listItem);
		    });
		}else{
			 // 공고가 없을경우
	        recruitListContainer.innerHTML = '등록된 공고가 아직 존재하지 않습니다.';
		}
		
		//평균평점불러오기
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function() {
			console.log(this.responseText);
			console.log(Number(this.responseText));
			console.log(Number(this.responseText).toFixed(1));
		if(this.responseText != null || this.responseText !=""){
			document.querySelector("#companyScore").innerHTML = Number(this.responseText).toFixed(1);
		}else{
			document.querySelector("#companyScore").innerHTML="0.0"
		}
		  }
		xhttp.open("GET", "http://localhost:9001/api/v1/company/avg-rating", true);
		xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
		xhttp.setRequestHeader("username", localStorage.getItem("username"));
		xhttp.setRequestHeader("role", localStorage.getItem("role"));
		xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role")
		xhttp.send();
		
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/company/mydetail", true);
	xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
	xhttp.setRequestHeader("username", localStorage.getItem("username"));
	xhttp.setRequestHeader("role", localStorage.getItem("role"));
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role");
	xhttp.send();
	
	function updateFile(event){
		event.preventDefault();
		const fileInput = document.querySelector("input[name='file']");
		const file = fileInput.files[0];
		
		if (file) {
			const formData = new FormData();
			formData.append('file', file);

			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				console.log(this.responseText);
				if (this.status === 200) {
					// 성공적으로 업로드 후 필요한 작업 수행
					console.log("File upload successful");
					location.reload(); // 페이지를 새로고침하여 변경된 내용을 반영
				} else {
					console.error("File upload failed");
				}
			};
			xhttp.open("PUT", "http://localhost:9001/api/v1/company/file", true);
			xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
			xhttp.setRequestHeader("username", localStorage.getItem("username"));
			xhttp.setRequestHeader("role", localStorage.getItem("role"));
			xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role");
			xhttp.send(formData);
		} else {
			console.error("No file selected");
		}
	}
	
	function editJobad(e){
		let jno = e.target.parentElement.parentElement.querySelector('.jno').innerText;
		
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function() {
			if(this.responseText == "cannot edit"){
				if(confirm("이미 해당공고에 지원한 지원자가 존재하여 수정이 불가합니다. '예'를 누르시면 공고가 마감됩니다. 공고 마감을 선택하시면 다시 번복이 불가합니다.")){
					const xhttp = new XMLHttpRequest();
					xhttp.onload = function() {
						alert("해당 공고가 성공적으로 마감되었습니다.")
						location.href="/company/myHome"
					}
					xhttp.open("PUT", "http://localhost:9001/api/v1/recruit/close-date?jno="+jno, true);
					xhttp.send();
				}
			}else{
				location.href="/company/recruitEdit?jno="+jno;
			}
		}
		xhttp.open("GET", "http://localhost:9001/api/v1/recruit?jno="+jno, true);
		xhttp.send();
	};
	
	function deleteJobad(e){
		const jno = e.target.parentElement.parentElement.querySelector(".jno").innerText;
		if(confirm("정말 해당 공고를 삭제하시겠습니까?")){
			xhttp.onload = function() {
				if(this.responseText == "done"){
					alert("해당 공고가 성공적으로 삭제되었습니다.")
					//html에서 지워주기
					e.target.parentElement.remove();
				}else if(this.responseText == "cannot delete"){
					if(confirm("선택하신 공고에 이미 지원한 지원자가 존재합니다. 공고를 삭제하면 다시 되돌릴 수 없으며, 모든 지원자에게는 공고가 삭제되었다는 알람이 가게 됩니다. 정말로 공고 삭제를 하시겠습니까?")){
						xhttp.onload = function() {
							alert("해당 공고가 성공적으로 삭제되었습니다.")
							//html에서 지워주기
							e.target.parentElement.parentElement.parentElement.remove();
						  }
						xhttp.open("DELETE", "http://localhost:9001/api/v1/recruit/?jno="+jno, true);
						xhttp.send();
					}
				}
			  }
			xhttp.open("DELETE", "http://localhost:9001/api/v1/recruit/"+jno, true);
			xhttp.send();
		}
	}
	
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>