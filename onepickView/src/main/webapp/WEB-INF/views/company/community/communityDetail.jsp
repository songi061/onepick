<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>1PICK!</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="/css/style.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="..//../layout/header.jsp"></jsp:include>
<div class="container">
	<div class="page_title">
		<h3>기업 커뮤니티</h3>
	</div>
	<div id="board_detail">
		<table id="data_board_detail"></table>
	</div>
	<div class="report">
		<button id="btn_report">신고</button>
	</div>
	<hr>
	<div id="reply_regist">
		<form class="replyForm" id="replyForm">
			<input id="input_reply_content" type="text" name="content" size="50"
				placeholder="솔직하고 따뜻한 답변을 남겨주세요.">
			<button id="btn_postComment">등록</button>
		</form>
	</div>
	<hr>
	<div id="commentSection">
		<table id="data_reply_detail">
		</table>
	</div>
	<button id="editBtn" style="display: none;">수정하기</button>
	<hr>
<script>
// 게시글 신고 기능
let board_report = 0;
$('#btn_report').click(function(event){
	event.preventDefault();
	
	board_report = board_report+1;
	console.log("---------------------------------")
	console.log(board_report)
	
	$.ajax({
		type: 'post',
		url: 'http://localhost:9001/api/v1/company/community-report',
		headers:{
			"jwtToken" : localStorage.getItem("jwtToken"),
            "username" : localStorage.getItem("username"),
            "role" : localStorage.getItem("role")
		},
		data: JSON.stringify({
			"cbno": cbno,
			"report": board_report
		}),
		contentType: 'application/json; charset=utf-8',
		dataType:'json',
		success: function(data){
			if(data !== null){
				console.log(data);
				window.location.href = '/company/community-board/='+cbno;
			}
		},
		error: function(xhr, status, error) {
			// 요청이 실패한 경우 처리할 코드
			console.error("Request failed with status code: " + xhr.status);
		}
			
	});
});


// 로컬 스토리지에서 username을 가져옴
const storagedUsername = localStorage.getItem('username');
console.log("xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"+storagedUsername)

// 모든 게시물 요소를 가져옴
const post = document.getElementById('board_detail');
const editBtn = document.getElementById("editBtn");
const cbno = ${cbno};
console.log("-----------------cbno="+cbno)

// 게시글 디테일 불러오기
$(document).ready(function(){
	$.ajax({
		type: 'GET',
		url: 'http://localhost:9001/api/v1/company/community-board/'+cbno,
		//data: { ubno: "job_hunting"},
		dataType: 'json',
		success: function(data){
			$(data).empty();
			writer = data.company.username;
			if (data !== null) {
				let str = '';
				str += '<tr><td>'+data.category +'</td></tr> '+ 
					'<tr><td>'+data.title + '</td></tr>'+
					'<tr><td>'+data.content + '</td></tr>'+
					'<tr><td>'+data.views +'</td></tr>'+
					'<tr><td id="writer">'+data.company.username+'</td></tr>'+
					'<tr><td>'+data.regdate + '</td></tr>';
				$('#data_board_detail').html(str);

		        if (storagedUsername === writer) {
		            console.log(storagedUsername === writer)
		            editBtn.style.display="block";
		   	 	};
			};
			// 초기 댓글 로드
			loadComments();
		},
		error:function(error){
			alert(error);
		}
	});

	//수정버튼 클릭이벤트 핸들러 추가
	editBtn.addEventListener("click", function(){
		console.log("수정버튼 클릭했다")
		window.location.href = '/company/communityEdit?cbno='+cbno;
	})

	// 해당게시글에서 댓글작성 매서드
	$('#btn_postComment').click(function(event){
		event.preventDefault();
		
		var content = $('#input_reply_content').val();
		console.log("content :" +content)
		console.log("username :" +username)
		
		$.ajax({
			type: 'post',
			url: 'http://localhost:9001/api/v1/company/community-comment',
			//headers:{
			//	'Authorization' : 'Bearer ' + 'token',
			//	'writer': 'token_writer'
			//},
			data: JSON.stringify({
				"content": content,
				"username": username,
				"cbno": cbno
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
			const cbno = ${cbno};
			console.log(cbno)
			$.ajax({
				type: 'GET',
				url: 'http://localhost:9001/api/v1/company/community-comment?cbno='+cbno,
				//data: {cbno: cbno},
				dataType: 'json',
				success: function(da){
					if(da !== null){
						let str = '';
						da.forEach(data=>{
							str += '<tr><td>'+data.content+'</td></tr>'+
								'<tr><td>'+data.company.username+'</td></tr>'+
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</html>