<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<jsp:include page="..//../layout/header.jsp"></jsp:include>
<div class="container">
    <form class="communityEditForm" id="communityEditForm">
        <div class="col-12">
            제목<input type="text" name="title" class="form-control" id="inputTitle">
          </div>
          <div class="col-md-6">
            내용<textarea class="form-control" id="inputContent" name="content"></textarea>
          </div>
          <div class="col-md-4">
            <label for="inputState" class="form-label">카테고리</label>
            <select id="Category" class="form-select">
              <option selected>카테고리를 선택하세요</option>
              <option value="freeBoard">자유글</option>
              <option value="job_hunting">취업준비</option>
              <option value="turnover">이직</option>
            </select>
          </div>
          <div class="col-12">
            <button type="submit" id="btn-boardRegist">등록하기</button>
          </div>
    </form>

<script>
// 게시글 번호에 따른 게시글 가져오기
$(document).ready(function(){
	const ubno = ${ubno};
	$.ajax({
		type: 'GET',
		url: 'http://localhost:9001/api/v1/user/community-board/'+ubno,
		//data: { ubno: "job_hunting"},
		dataType: 'json',
		success: function(data){
// 			console.log(data);
			$(data).empty();
			
			if (data !== null) {
				let str = '';
				str = data.category
					+data.title
					+data.views
					+data.user.username
					+data.regdate;
				$('#data_board_detail').html(str);

                // data 값을 input태그 value안에 넣기위에 변수안에 담자
                // -> value값을 바로 지정하자
                $('#inputTitle').value = data.title;
                $('#inputContent').value = data.content;
                //let oldCategory = data.category;
                //let oldContent = data.content;
			}
			// 초기 댓글 로드
			loadComments();
		},
		error:function(error){
			alert(error);
		}
	}); 
});

// 수정한 게시글 등록하기
$(document).ready(function(){
	$('#communityForm').submit(function(event){
		event.preventDefault();
				
		var title = $('input[name=title]').val();
		var content = $('textarea[name=content]').val();
		var category = $('#Category').val();
		console.log("수정한 title:"+title)
		console.log("수정한 content:"+content)
		console.log("수정한 category:"+category)
		console.log("수정한 username:"+username)
				
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
				alert("게시물이 정상적으로 수정되었습니다.");
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
<jsp:include page="..//../layout/footer.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>