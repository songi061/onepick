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
				<div>⭐ <span id="companyScore"></span> <span class="text-secondary mx-2"> | </span> <span id="companySector">섹터</span> <span class="text-secondary mx-2"> | </span> <span id="companyCeo">ceo</span> <span class="text-secondary mx-2"> | </span> <span id="companyEmployeesNum">employeesNum</span> <span class="text-secondary mx-2"> | </span> <span id="companySize">size</span> <span class="text-secondary mx-2"> | </span> <span id="companyYrSales">yrSales</span> <span class="text-secondary mx-2"> | </span> <span id="companyUrl">url</span></div>
			</div>
		</div>
		<div class='title'>내 공고 리스트</div>
		<button class="btn btn-onepick showMoreBtn" onclick="showMore()" style="display:none;">더보기</button>
		<div class="myrecruit_list">
		</div>
		<div class="links">
			<div><a href='/company/recruitForm'>채용공고작성</a></div>
			<div><a href='/company/scrapList'>스크랩한지원자</a></div>
			<div><a href='/company/applyList'>지원내역관리</a></div>
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
        <input type="file" name="file">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="updateFile(event)">변경</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
const recruitListContainer = document.querySelector(".myrecruit_list");
const showMoreBtn = document.querySelector(".showMoreBtn");

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
		if(data.fileName == null){
			document.querySelector(".profileImg_box img").src="/img/no_img.jpg";
		}else{
			document.querySelector(".profileImg_box img").src="/images/" + myInfo.fileName;
		}
		
		
		if (myJobad && myJobad.length > 0) {
			 // 처음 세 개의 항목을 추가합니다.
		    myJobad.slice(0, 3).forEach(data => {
		        let displayDate = data.moddate ? data.moddate.slice(0, 10) : data.regdate.slice(0, 10);
		        const listItem = document.createElement('div');
		          listItem.innerHTML = "<div><div><a href='/company/recruitDetail?jno="+ data.jno + "'>" + data.wantedTitle +"</a></div><div> 최종수정날짜 : "  + displayDate + "</div> <span style='display:none;' class='jno'>"+ data.jno+"</span> <button class='btn btn-onepick' onclick='editJobad(event)'>수정</button> <button class='btn btn-onepick' onclick='deleteJobad(event)'>삭제</button></div>";
		          recruitListContainer.appendChild(listItem);
		    });
			 
		    // 항목이 3개 초과인 경우 "더보기" 버튼을 표시합니다.
		    if (myJobad.length > 3) {
		        showMoreBtn.style.display = "block";

		        // "더보기" 버튼 클릭 시 나머지 항목을 추가하는 이벤트 리스너를 설정합니다.
		        showMoreBtn.addEventListener('click', () => {
		            myJobad.slice(3).forEach(data => {
	                let displayDate = data.moddate ? data.moddate.slice(0, 10) : data.regdate.slice(0, 10);
	                const listItem = document.createElement('div');
	                listItem.innerHTML = "<div><div><a href='/company/recruitDetail?jno="+ data.jno + "'>" + data.wantedTitle +"</a></div><div> 최종수정날짜 : "  + displayDate + "</div> <span style='display:none;' class='jno'>"+ data.jno+"</span> <button class='btn btn-onepick' onclick='editJobad(event)'>수정</button> <button class='btn btn-onepick' onclick='deleteJobad(event)'>삭제</button></div>";
		            recruitListContainer.appendChild(listItem);
		    })
		 // 나머지 항목을 모두 추가한 후 "더보기" 버튼을 숨깁니다.
            showMoreBtn.style.display = "none";
	        })
	    }
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
	
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>