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
<link href="/css/scrapList.css" rel="stylesheet">
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
			<button class="btn text-onepick" type="button" onclick="location.href='/company/scrapList'">
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
		<div class="page_title">스크랩한 구직자 리스트</div>
		<div class="scrap_list">
		</div>
		
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
const listContainer = document.querySelector('.scrap_list');

    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let datas = JSON.parse(this.responseText);
		 console.log(datas)
		if (datas && datas.length > 0) {
           datas.forEach(data => {
      		 console.log(data)
        	   let age = 2024 - Number(data.resume.user.birthDate.slice(0,4));
        	   console.log(age)
               const listItem = document.createElement('div');
               listItem.className = 'scrap_list_item';
               listItem.innerHTML = "<div class='profileImg_box img' ><img class='img' src=''></div><div class='scrap_info'><div class='scrap_title'><a href=''>"+ data.resume.title+"</a></div><div class='scrap_name'>"+ data.resume.user.name+"</div><div>"+data.resume.user.gender+"</div><div>" + age +
               " 세</div> <div class='scrap_job'>" + data.resume.job + "</div><div class='scrap_region'>" +data.resume.region1+"</div></div>";
               listContainer.appendChild(listItem);
               
               
               if(data.resume.user.fileName == null){
            	   listItem.querySelector(".profileImg_box img").src="/img/no_img.jpg";
	       		}else{
	       			listItem.querySelector(".profileImg_box img").src="/images/" + data.resume.user.fileName;
	       		}
               
           });
		}else{
			 // 스크랩한 구직자가 없을경우
	        listContainer.innerHTML = '내가 스크랩한 구직자가 아직 존재하지 않습니다.';
		}
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/resume-scrap", true);
	xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
	xhttp.setRequestHeader("username", localStorage.getItem("username"));
	xhttp.setRequestHeader("role", localStorage.getItem("role"));
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role")
	xhttp.send();
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>