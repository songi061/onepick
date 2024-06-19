<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="text-bg-dark">
	<div class="container">
	    <div class="d-flex flex-wrap justify-content-center py-3">
	      <a href="/admin/dashboard" class="d-block d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
	        <div class="header_logo_size">
	        	<div class="form-text text-white">관리자 서비스</div>
	        	<img class="img-fluid" src="/img/logo_white.png" alt="logo">
	        	
	        </div>
	      </a>
	
	      <ul class="nav nav-pills">
	        <li class="nav-item"><a href="/admin/dashboard" class="nav-link text-white" aria-current="page">홈</a></li>
	        <li class="nav-item">
		        <div class="dropdown">
				  <button class="nav-link dropdown-toggle text-white"  data-bs-toggle="dropdown" aria-expanded="false">회원관리</button>
				  <ul class="dropdown-menu">
				    <li><a class="dropdown-item" href="/admin/userList">개인회원</a></li>
				    <li><a class="dropdown-item" href="/admin/companyList">기업회원</a></li>
				  </ul>
				
				</div>
			</li>
	        <li class="nav-item"><a href="/admin/recruitList" class="nav-link text-white">공고관리</a></li>
	        <li class="nav-item">
	        <div class="dropdown">
				  <button class="nav-link dropdown-toggle text-white"  data-bs-toggle="dropdown" aria-expanded="false">커뮤니티 신고 관리</button>
				  <ul class="dropdown-menu">
				    <li><a class="dropdown-item" href="/admin/boardReportList">게시글</a></li>
				    <li><a class="dropdown-item" href="/admin/replyReportList">댓글</a></li>
				  </ul>
	        </li>
	        <li>
		        <div class="dropdown">
				  <button class="nav-link dropdown-toggle text-white"  data-bs-toggle="dropdown" aria-expanded="false">고객센터 관리</button>
				  <ul class="dropdown-menu">
				  	<li><a class="dropdown-item" href="/admin/noticeList">공지사항</a></li>
				    <li><a class="dropdown-item" href="/admin/qnaList">QnA</a></li>
				    <li><a class="dropdown-item" href="/admin/faqList">FAQ</a></li>
				  </ul>
				
				</div>
			</li>
			<li class="nav-item">
			<button class="btn btn-light" onclick="logoutBtn()">로그아웃</button>
			</li>
	      </ul>
	      
	      
	    </div>
    </div>
</header>
<script>
	function logoutBtn(){
		console.log("스토리지 값 삭제");
		window.localStorage.clear();
		location.href="/admin/loginForm";
	}
</script>