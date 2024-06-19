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
<link href="/css/reviewList.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="sub_header border-bottom">
	<div class="container">
		<div class="d-flex py-2">
			<button class="btn" type="button" onclick="location.href='/user/myHome'">
			   MyHome
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggl" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    이력서 관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/resumeList'">이력서 리스트</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/resumeForm'">이력서 작성</button></li>
			  </ul>
			</div>
			<button class="btn" type="button" onclick="location.href='/user/scrapList'">
			   스크랩관리
			</button>
			<button class="btn" type="button" onclick="location.href='/user/interestList'">
			   구독관리
			</button>
			<button class="btn" type="button" onclick="location.href='/user/applyList'">
			   지원내역관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle text-onepick" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    평점관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/reviewList'">평점 조회</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/reviewForm'">평점 등록</button></li>
			  </ul>
			</div>
			<button class="btn" type="button" onclick="location.href='/user/myQnaList'">
			   QnA관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    커뮤니티관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/myBoardList'">내가 쓴 글 리스트</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/myCommentList'">내가 쓴 댓글 목록</button></li>
			  </ul>
			</div>
		</div>
	</div>
</div>
	<div class="container" id="reviewCon">
		<div class="title">내가 받은 평점 리스트</div>
		<div class="received_list">	</div>
		<div class="title">내가 쓴 평점 리스트</div>
		<div class="registered_list"></div>
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

const receivedListContainer = document.querySelector('.received_list');
const registeredListContainer = document.querySelector('.registered_list');


	const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let datas = JSON.parse(this.responseText);
	    let rating;
		
		
	    if (datas.receivedList && datas.receivedList.length > 0) {
	       datas.receivedList.forEach(data => {
	    	   console.log(data)
	    	   rating = Number(data.rating);
	           const receivedListItem = document.createElement('div');
	    	   receivedListItem.className = 'received_list_item';
	    	   receivedListItem.innerHTML =  "<div><div class='user_name'>"+data.company.name+"</div><div class='reviewContainer'></div>";
	           receivedListContainer.appendChild(receivedListItem);
	           
        	   const reviewContainer = receivedListItem.querySelector(".reviewContainer")
               // rating 값에 따라 별 이미지 반복 추가
               for (let i = 0; i < rating; i++) {
                   const starImg = document.createElement('img');
                   starImg.src = '/icon/star_full.png'; 
                   starImg.style.width="30px";
                   starImg.style.display="inline-block";
                   reviewContainer.appendChild(starImg);
               }
           });
	    }else{
	    	 // 받은 평점이 없을 경우
	        receivedListContainer.innerHTML = '내가 받은 평점이 아직 존재하지 않습니다.';
	    }    
	   
	 // 내가 쓴 평점 리스트 표시
	    if (datas.registeredList && datas.registeredList.length > 0) {
	       datas.registeredList.forEach(data=>{
        	   rating = Number(data.rating);
        	   const registeredListItem = document.createElement('div');
        	   registeredListItem.className = 'registered_list_item';
        	   registeredListItem.innerHTML = "<div><div class='user_name'>"+data.company.name+"</div><div class='reviewContainer'></div>"
        	   registeredListContainer.appendChild(registeredListItem);
        	   
        	   const reviewContainer = registeredListItem.querySelector(".reviewContainer")

               // rating 값에 따라 별 이미지 반복 추가
               for (let i = 0; i < rating; i++) {
                   const starImg = document.createElement('img');
                   starImg.src = '/icon/star_full.png'; 
                   starImg.style.width="30px";
                   starImg.style.display="inline-block";
                   reviewContainer.appendChild(starImg);
               }
           })
	    }else{
	    	 // 내가 쓴 평점이 없을 경우
	        registeredListContainer.innerHTML = '내가 쓴 평점이 아직 존재하지 않습니다.';
	    }
            
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/review-list", true);
	xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
	xhttp.setRequestHeader("username", localStorage.getItem("username"));
	xhttp.setRequestHeader("role", localStorage.getItem("role"));
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role")
	xhttp.send();

</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="/js/userInterceptor.js"></script>
<script src="/js/CloseBrowserClearlocalStorage.js"></script>
</html>