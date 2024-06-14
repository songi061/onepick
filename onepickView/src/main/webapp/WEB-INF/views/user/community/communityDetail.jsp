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
<jsp:include page="..//../layout/header.jsp"></jsp:include>
<div class="container">
<h3>구직자 커뮤니티</h3>
<div id="board_detail">
	<table id="data_board_detail">
	</table>
</div>
<hr>
<div id="reply_regist">
	<form class="replyForm" id="replyForm">
		<input id="input_reply_content" type="text" name="content" size="50" placeholder="솔직하고 따뜻한 답변을 남겨주세요.">
		<button id="btn_postComment">등록</button>
	</form>
</div>
<div id="commentSection">
	<table id="data_reply_detail">
	</table>
</div>
<script>
// 게시글 디테일 불러오기
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
				str += '<tr><td>'+data.category +'</td></tr> '+ 
					'<tr><td>'+data.title + '</td></tr>'+
					'<tr><td>'+data.views +'</td></tr>'+
					'<tr><td>'+data.user.username+'</td></tr>'+
					'<tr><td>'+data.regdate + '</td></tr>';
				$('#data_board_detail').html(str);
			}
			// 초기 댓글 로드
			loadComments();
		},
		error:function(error){
			alert(error);
		}
	});


	// 해당게시글에서 댓글작성 매서드
	$('#btn_postComment').click(function(event){
		event.preventDefault();
		
		var content = $('#input_reply_content').val();
		console.log("content :" +content)
		console.log("username :" +username)
		
		
		$.ajax({
			type: 'post',
			url: 'http://localhost:9001/api/v1/user/community-comment',
			//headers:{
			//	'Authorization' : 'Bearer ' + 'token',
			//	'writer': 'token_writer'
			//},
			data: JSON.stringify({
				"content": content,
				"username": username,
				"ubno": ubno
			}),
			contentType: 'application/json; charset=utf-8',
			dataType:'json',
			success: function(data){
				if(data !== null){
					alert("댓글이 등록되었습니다.");
					console.log(data);
					loadComments();	// 댓글 등록 후 댓글 목록을 새로 불러옴
					
				}
			},
			error: function(xhr, status, error) {
				// 요청이 실패한 경우 처리할 코드
				console.error("Request failed with status code: " + xhr.status);
			}
				
		});
	});
	
	// 해당 게시글의 댓글 불러오기
	// $(document).ready(function(){
		function loadComments(){
			const ubno = ${ubno};
			console.log(ubno)
			$.ajax({
				type: 'GET',
				url: 'http://localhost:9001/api/v1/user/community-comment?ubno='+ubno,
				//data: {ubno: ubno},
				dataType: 'json',
				success: function(da){
					if(da !== null){
						let str = '';
						da.forEach(data=>{
							str += '<tr><td>'+data.content+'</td></tr>'+
								'<tr><td>'+data.user.username+'</td></tr>'+
								'<tr><td>'+data.report+'</td></tr>'+
								'<tr><td>'+data.regdate+'</td></tr>';
						});
						$('#data_reply_detail').html(str);
					}
				console.log(da);
						
				},
				error: function(error){
					alert(error);
				}
			});
		}
		
		
});
</script>
</div>
<jsp:include page="..//../layout/footer.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>