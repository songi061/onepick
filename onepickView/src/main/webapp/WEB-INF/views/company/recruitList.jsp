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
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="/js/CloseBrowserClearlocalStorage.js"></script>
<script src="/js/companyInterceptor.js"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="sub_header border-bottom">
	<div class="container">
		<div class="d-flex py-2">
			<button class="btn" type="button" onclick="location.href='/company/myHome'">
			   MyHome
			</button>
			<button class="btn" type="button" onclick="location.href='/company/scrapList'">
			   스크랩관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle  text-onepick" type="button" data-bs-toggle="dropdown" aria-expanded="false">
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
		<div class="page_title">마이페이지 공고리스트</div>
		
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
		const receiptCloseDate = new Date(data.receiptCloseDt);
	    const currentDate = new Date();
	    
	    // 날짜가 유효한지 확인 (빈 값인 경우를 대비)
	    let displayDate = receiptCloseDate ? receiptCloseDate.toISOString().slice(0, 10) : '';

	    const listItem = document.createElement('div');
	    
	    // 공고마감일이 현재 날짜보다 빠른 경우
	    if (receiptCloseDate < currentDate) {
	    	  listItem.innerHTML = "<div><div><a href='/company/recruitDetail?jno="
	    			  + data.jno + "'>" + data.wantedTitle +"</a></div><div> 공고마감일 : "  
	    			  + displayDate + "</div> <span style='display:none;' class='jno'>"
	    			  + data.jno+"</span> <button class='btn btn-onepick' disabled style='background-color:red;'>마감</button></div>";
	    			 
	        
	    }else{
	    	listItem.innerHTML = "<div><div><a href='/company/recruitDetail?jno="
	    			+ data.jno + "'>" + data.wantedTitle +"</a></div><div> 공고마감일 : "  
	    			+ displayDate + "</div> <span style='display:none;' class='jno'>"
	    			+ data.jno+"</span> <button class='btn btn-onepick editBtn' onclick='editJobad(event)'>수정</button> <button class='btn btn-onepick deleteBtn' onclick='deleteJobad(event)'>삭제</button></div>";
	    	console.log("공고 아직 마감 아님")
	    }
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
	const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		if(this.responseText == "cannot edit"){
			if(confirm("이미 해당공고에 지원한 지원자가 존재하여 수정이 불가합니다. '예'를 누르시면 공고가 마감됩니다. 공고 마감을 선택하시면 다시 번복이 불가합니다.")){
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					alert("해당 공고가 성공적으로 마감되었습니다.")
					location.href="/company/recruitList"
				}
				xhttp.open("PUT", "http://localhost:9001/api/v1/recruit/close-date?jno="+jno, true);
				xhttp.send();
			}
		}else{
			location.href="/company/recruitEdit?jno="+jno;
		}
	}
	
	xhttp.open("PUT", "http://localhost:9001/api/v1/recruit/?jno="+jno, true);
	xhttp.send();
};

function deleteJobad(e){
	let jno = e.target.parentElement.querySelector('.jno').innerText;
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
						e.target.parentElement.parentElement.remove();
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