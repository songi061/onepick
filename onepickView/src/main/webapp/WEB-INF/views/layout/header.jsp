<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="border-bottom">
	<div class="bg-light py-2">
		<div class="container d-flex">
			<div class="d-flex ms-auto">
				<div id="logout_menu" class="border-end pe-3 me-3">
					<a class="btn btn-sm btn-outline-dark" href="/loginForm">로그인</a>
					<a class="btn btn-sm btn-outline-dark" href="/regForm">회원가입</a>
				</div>
				<div id="login_menu" class="border-end pe-3 me-3">
					<span id="myname"></span>
					<button class="btn btn-sm btn-outline-dark" onclick="mypage()">마이페이지</button>
					<button class="btn btn-sm btn-outline-dark" onclick="logoutBtn()">로그아웃</button>
				</div>
				<button id="serviceBtn" onclick="menuChange()" class="btn btn-sm btn-outline-dark">기업회원 서비스</button>
			</div>
		</div>
	</div>
	<div class="container">
	    <div class="d-flex flex-wrap justify-content-center py-3">
			<div class="d-flex align-items-center me-md-auto ">
				<a href="/" class="d-block d-flex align-items-center mb-3 mb-md-0 link-body-emphasis text-decoration-none me-3">
					<div class="header_logo_size">
						<img class="img-fluid" src="/img/logo.png" alt="logo">
					</div>
				</a>
				<div class="input-group search_box">
					<input type="text" name="searchResultInput" class="form-control border-onepick" placeholder="통합검색" aria-label="통합검색" aria-describedby="searchResultBtn">
					<button class="btn btn-outline-onepick" type="button" id="searchResultBtn" onclick="getSearchResult()">검색</button>
				</div>
			</div>
	
	      <ul id="userMenu" class="nav nav-pills">
	        <li class="nav-item"><a id="mainPage" href="/" class="nav-link" aria-current="page">채용정보</a></li>
	        <li class="nav-item"><a href="/company/companyList" class="nav-link companyPage">기업정보</a></li>
	        <li class="nav-item"><a href="/user/communityList" class="nav-link">개인회원 커뮤니티</a></li>
	        <li class="nav-item">
		        <div class="dropdown">
				  <button class="nav-link dropdown-toggle"  data-bs-toggle="dropdown" aria-expanded="false">고객센터</button>
				  <ul class="dropdown-menu">
				    <li><a class="dropdown-item" href="#" onclick="userMyQnaCheck()">QnA</a></li>
				    <li><a class="dropdown-item" href="/faqList">FAQ</a></li>
				    <li><a class="dropdown-item" href="/noticeList">공지사항</a></li>
				  </ul>
				
				</div>
			</li>
	      </ul>
	      
	      <ul id="companyMenu" class="nav nav-pills" style="display:none">
	        <li class="nav-item"><a id="userSearchPage" href="/company/userSearchList" class="nav-link" aria-current="page">인재채용</a></li>
	        <li class="nav-item"><a href="/company/companyList" class="nav-link companyPage">기업정보</a></li>
	        <li class="nav-item"><a href="#" onclick="companyCommunityCheck()" class="nav-link">기업회원 커뮤니티</a></li>
	        <li class="nav-item">
		        <div class="dropdown">
				  <button class="nav-link dropdown-toggle"  data-bs-toggle="dropdown" aria-expanded="false">고객센터</button>
				  <ul class="dropdown-menu">
				    <li><a class="dropdown-item" href="#" onclick="companyMyQnaCheck()">QnA</a></li>
				    <li><a class="dropdown-item" href="/faqList">FAQ</a></li>
				    <li><a class="dropdown-item" href="/noticeList">공지사항</a></li>
				  </ul>
				</div>
			</li>
	      </ul>
	    </div>
    </div>
</header>
<style>
	#myname{
		font-size: 14px;
    	line-height: 25px;
    	color: #666;
		margin-right: 10px;
	}
</style>
<script>
	const menuBtn = document.querySelector("#serviceBtn");
	const userMenu = document.querySelector("#userMenu").style;
	const companyMenu = document.querySelector("#companyMenu").style;
	console.log(menuBtn);
	function menuChange(){
		if (companyMenu.display=="none"){
			menuBtn.innerText = "개인회원 서비스";
			userMenu.display="none";
			companyMenu.display="";
			localStorage.setItem("serviceMenuCheck","companyMenu")
			
		}else{
			menuBtn.innerText = "기업회원 서비스";
			companyMenu.display="none";
			userMenu.display="";
			localStorage.setItem("serviceMenuCheck","userMenu")
		}
	}
	
	let serviceMenuCheck = localStorage.getItem("serviceMenuCheck");
	console.log("serviceMenuCheck " + serviceMenuCheck);
	if(serviceMenuCheck == "companyMenu"){
		userMenu.display="none";
		companyMenu.display="";
	}else if(serviceMenuCheck == "userMenu"){
		companyMenu.display="none";
		userMenu.display="";
	}
	
	
	// localStorage에서 값 가져오기
	let role = localStorage.getItem("role");
	console.log(role);
	let username = localStorage.getItem("username");
	console.log(username);
	
	//let serviceMenuCheck = localStorage.setItem("companyMenu");
	const logout_menu = document.querySelector("#logout_menu");
	const login_menu = document.querySelector("#login_menu");
	
	if (username == null){
		login_menu.style.display="none";
		logout_menu.style.display="";
	}else{
		login_menu.style.display="";
		logout_menu.style.display="none";
		// #myname 요소에 텍스트 추가
		document.querySelector("#myname").innerText = "🐱‍👤 "+ username + " 님, 반갑습니다 !"
		}
	
	function mypage(){
		if(role == "ROLE_COMPANY"){
			location.href="/company/myHome";
		}else{
			location.href="/user/myHome";
		}
	}

	function logoutBtn(){
		console.log("스토리지 값 삭제");
		window.localStorage.clear();
		location.href="/";
	}
	
	
	function getSearchResult(){
		const searchResultInput = document.querySelector("input[name='searchResultInput']");
		console.log(searchResultInput.value);
		location.href="/searchResult?keyword=" + searchResultInput.value;
	}
	
	
	function companyCommunityCheck(){
		if(role == "ROLE_COMPANY" || role == "ROLE_ADMIN"){
			location.href="/company/communityList";
		}else{
			alert("기업회원만 접속 가능합니다.");
		}
	}
	
	function companyMyQnaCheck(){
		if(role == "ROLE_COMPANY" || role == "ROLE_ADMIN"){
			location.href="/company/myQnaList";
		}else{
			alert("기업회원만 접속 가능합니다.");
		}
	}
	
	function userMyQnaCheck(){
		if(role == "ROLE_USER" || role == "ROLE_ADMIN"){
			location.href="/user/myQnaList";
		}else{
			alert("개인회원만 접속 가능합니다.");
		}
	}
	
</script>