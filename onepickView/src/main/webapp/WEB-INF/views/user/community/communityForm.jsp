<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="/css/style.css" rel="stylesheet">
<link href="/css/qnaForm.css" rel="stylesheet">
<style>
.noticeBtn{
	position:static;
	float:right;
}
</style>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="..//../layout/header.jsp"></jsp:include>
<div class="container" class="communityForm" id="communityForm">
	<div class="page_title">구직자 커뮤니티</div>
	<form name="frm" id="communityForm">  
       <div id="frm_category">
           <p>카테고리</p>
          <select id="Category" name="category">
	      <option selected>카테고리를 선택하세요</option>
	      <option value="freeBoard">자유글</option>
	      <option value="job_hunting">취업준비</option>
	      <option value="turnover">이직</option>
	    </select>
       </div>
      <div id="frm_title">
            <p>제목</p><input type="text" name="title" id="inputTitle">
      </div>
      <div class="frm_content overflow-hidden">
           <p>내용</p><textarea id="inputContent" name="content"></textarea>
        </div>
       	<input type="submit" class="btn btn-onepick noticeBtn mt-3 float-end"  id="btn-boardRegist"  value="등록">
     </form>
	
	<script>
		// 게시글 등록
		$(document).ready(function(){
			$('#communityForm').submit(function(event){
				event.preventDefault();
				
				var title = $('input[name=title]').val();
				var content = $('textarea[name=content]').val();
				var category = $('#Category').val();
				var username = localStorage.getItem("username");
				
				console.log("title:"+title)
				console.log("content:"+content)
				console.log("category:"+category)
				console.log("username:"+username)
				
				$.ajax({
					type: 'post',
					url: 'http://localhost:9001/api/v1/user/community-board',
					headers: {
						"jwtToken" : localStorage.getItem("jwtToken"),
			            "username" : localStorage.getItem("username"),
			            "role" : localStorage.getItem("role")
					},
					data: JSON.stringify({
						title: title,
						content: content,
						category: category,
						username: username
						
					}),
					contentType: 'application/json; charset=utf-8',
					dataType:'json',
					success: function(data){
						if(data !== null){
							alert("게시물이 정상적으로 등록되었습니다.");
							console.log(data);
							location.href="/user/communityList";
						}
					},
					error: function(xhr, status, error) {
						// 요청이 실패한 경우 처리할 코드
						//console.error("Request failed with status code: " + xhr.status);
						console.log("등록 실패.......")
					}
				});
			});
		});
	
	</script>
</div>
<jsp:include page="..//../layout/footer.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>