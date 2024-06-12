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
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	<form class="communityForm" id="communityForm">
	  <div class="col-12">
	    제목<input type="text" name="title" class="form-control" id="inputTitle" placeholder="제목을 입력하세요.">
	  </div>
	  <div class="col-md-6">
	    내용<textarea class="form-control" id="inputContent" name="content">내용을 입력하세요.</textarea>
	  </div>
	  <div class="col-md-4">
	    <label for="inputState" class="form-label">카테고리</label>
	    <select id="Category" class="form-select">
	      <option selected>카테고리를 선택하세요</option>
	      <option value="자유글">자유글</option>
	      <option value="취업준비">취업준비</option>
	      <option value="이직">아직</option>
	    </select>
	  </div>
	  <div class="col-12">
	    <button type="submit" id="btn-boardRegist">등록하기</button>
	  </div>
	</form>
	<script>
		// 게시글 등록
		$(document).ready(function(){
			$('#communityForm').submit(function(event){
				
				event.preventDefault();
				
				var title = $('input[name=title]').val();
				var content = $('textarea[name=content]').val();
				var category = $('#Category').val();
				//var username = $('input[name=username]').val();
				console.log(content)
				
				$.ajax({
					type: 'post',
					url: 'http://localhost:9001/api/v1/user/community-board',
					headers: {
						'Authorization' : 'Bearer ' + 'token',
						'writer': 'token_writer'
					},
					data: JSON.stringify({
						title: title,
						content: content,
						category: category
					}),
					contentType: 'application/json; charset=utf-8',
					dataType:'json',
					success: function(data){
						alert("게시물이 정상적으로 등록되었습니다.");
						console.log(data);
					},
					error: function(xhr, status, error) {
						// 요청이 실패한 경우 처리할 코드
						console.error("Request failed with status code: " + xhr.status);
					}
				});
			});
		});
	
	</script>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>