<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link href="/css/style.css" rel="stylesheet">
<link href="/css/userSearchList.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<div class="clearfix">
			<h3 class="page_title float-start">인재채용</h3>
			<div class="float-end input-group resume_seaerch_box mt-md-5">
				<input type="text" class="form-control" placeholder="키워드 검색" name="searchInput" aria-label="제목 검색" aria-describedby="resumeSearchBtn">
				<button class="btn btn-outline-secondary" type="button" id="resumeSearchBtn">검색</button>
			</div>
		</div>
		<div id="resumeList" class="row mb-5">
		</div>
	</div>
	
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
const token = localStorage.getItem("jwtToken");
const token_username = localStorage.getItem("username");
const token_role = localStorage.getItem("role");
const resumeList = document.querySelector("#resumeList");


const resumeSearchBtn = document.querySelector("#resumeSearchBtn");
const searchInput = document.querySelector("input[name='searchInput']");

function mainAllList(){
const xhttp = new XMLHttpRequest();
	xhttp.onload = function () {
		let objs = JSON.parse(this.responseText);
		objs.forEach(obj => {
			console.log(obj);
			//let logoSrc = obj.user.fileName == null ? "/img/no_img.jpg" : "/images/" + obj.user.fileName;
			 let logoSrc = "";
             if(token_role == "ROLE_COMPANY" || token_role == "ROLE_ADMIN"){
             	logoSrc = obj.user.fileName == null ? "/img/no_img.jpg" : "/images/" + obj.user.fileName;
             }else{
             	logoSrc = "/img/no_img.jpg";
             }
             
			console.log(logoSrc);
			let currentTime = Date.now();
			console.log(obj.user.birthDate);
			let birthTime = new Date(obj.user.birthDate).getTime();
			console.log(birthTime);
			// 현재 시간과 생일 시간의 차이를 계산하여 나이를 밀리초에서 년으로 변환
			let ageInMilliseconds = currentTime - birthTime;
			let ageInYears = ageInMilliseconds / (1000 * 60 * 60 * 24 * 365.25); // 1년을 평균적으로 365.25일로 계산
			let age = Math.floor(ageInYears);
			console.log();
			document.querySelector("#resumeList").innerHTML += 
				"<div class='col-md-6 col-xl-4 mb-3'>"
				+ "<a class='d-block underline-none border p-4 rounded d-flex pointer' style='cursor:pointer' onclick='roleCheckAfterLink(event, " + JSON.stringify(obj) + ")'>"
				+ "<div class='profileImg_box'>"
				+ "<img src=" + logoSrc + " alt='사진'>"
				+ "</div>"
				+ "<div class='w-75 ps-3'>"
				+ "<div class='fs-4 fw-bold text-ellipsis'>" + obj.resume.title + "</div>"
				+ "<div>" + obj.user.name + "(" + obj.user.gender + ", 만 " + age + "세)</div>"
				+ "<div>" + obj.resume.job + "</div>"
				+ "<div>" + obj.major + " " + obj.s_status + "</div>"
				+ "</div></a></div>";
		});
		
	}
	xhttp.open("GET", "http://localhost:9001/api/v1/resume-search");
	xhttp.setRequestHeader("Authorization", "Bearer " + token);
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "Authorization");
	xhttp.send();
}
mainAllList();

function roleCheckAfterLink(event, obj) {
    event.preventDefault(); 
    if (token_role === "ROLE_COMPANY" || token_role === "ROLE_ADMIN") {
        location.href = '/user/resumeDetail?rno=' + obj.resume.rno;
    } else {
        alert("기업회원만 접근 가능합니다!");
    }
}

resumeSearchBtn.addEventListener("click", function(){
    let keyword = searchInput.value;
    console.log("keyword " + keyword);
    if (keyword.length == 0) {
        document.querySelector("#resumeList").innerHTML = "";
        mainAllList();
    } else {
        const xhttp4 = new XMLHttpRequest();
        xhttp4.onload = function () {
            let objs = JSON.parse(this.responseText);
            document.querySelector("#resumeList").innerHTML = ""; // Clear the list before adding new items
            if (objs.length > 0) {
                objs.forEach(obj => {
                    console.log(obj);
                    //let logoSrc = obj.user.fileName == null ? "/img/no_img.jpg" : "/images/" + obj.user.fileName;
                    let logoSrc = "";
                    if(token_role == "ROLE_COMPANY" || token_role == "ROLE_ADMIN"){
                    	logoSrc = obj.user.fileName == null ? "/img/no_img.jpg" : "/images/" + obj.user.fileName;
                    }else{
                    	logoSrc = "/img/no_img.jpg";
                    }
                    
                    console.log(logoSrc);
                    let currentTime = Date.now();
                    console.log(obj.user.birthDate);
                    let birthTime = new Date(obj.user.birthDate).getTime();
                    console.log(birthTime);
                    // 현재 시간과 생일 시간의 차이를 계산하여 나이를 밀리초에서 년으로 변환
                    let ageInMilliseconds = currentTime - birthTime;
                    let ageInYears = ageInMilliseconds / (1000 * 60 * 60 * 24 * 365.25); // 1년을 평균적으로 365.25일로 계산
                    let age = Math.floor(ageInYears);
                    console.log();
                    document.querySelector("#resumeList").innerHTML += 
                        "<div class='col-md-6 col-xl-4 mb-3'>"
                        + "<a class='d-block underline-none border p-4 rounded d-flex pointer'  style='cursor:pointer' onclick='roleCheckAfterLink(event, " + JSON.stringify(obj) + ")'>"
                        + "<div class='profileImg_box'>"
                        + "<img src=" + logoSrc + " alt='사진'>"
                        + "</div>"
                        + "<div class='w-75 ps-3'>"
                        + "<div class='fs-4 fw-bold text-ellipsis'>" + obj.resume.title + "</div>"
                        + "<div>" + obj.user.name + "(" + obj.user.gender + ", 만 " + age + "세)</div>"
                        + "<div>" + obj.resume.job + "</div>"
                        + "<div>" + obj.major + " " + obj.s_status + "</div>"
                        + "</div></a></div>";
                });
            } else {
                document.querySelector("#resumeList").innerHTML = "<div class='col-12'><div class='border w-100 p-4 text-center text-secondary rounded'>검색 결과가 없습니다.</br> 검색어를 다시 확인해주세요.</div></div>";
            }
        };

        xhttp4.open("GET", "http://localhost:9001/api/v1/resume-search/" + keyword);
        xhttp4.setRequestHeader("Authorization", "Bearer " + token);
        xhttp4.setRequestHeader("Access-Control-Expose-Headers", "Authorization");
        xhttp4.send();
    }
});

function pageActive(){
	// 기존의 'active' 클래스를 제거합니다.
	document.querySelector("header .nav-item a").classList.remove('active');
	// 'active' 클래스를 추가합니다.
	document.querySelector("header #userSearchPage").classList.add('active');
}
pageActive();
	
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="/js/CloseBrowserClearlocalStorage.js"></script>
</html>