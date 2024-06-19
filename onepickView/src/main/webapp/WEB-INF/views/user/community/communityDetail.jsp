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
			<h3>구직자 커뮤니티</h3>
		</div>
		<div id="board_detail">
			<table id="data_board_detail"></table>
		</div>
		<div class="report">
			<button id="btn_commu_report">신고</button>
		</div>
		<div class="edit">
			<button id="editBtn" style="display: none;">수정하기</button>
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
		<hr>
<script>
// 로컬 스토리지에서 username을 가져옴
const storagedUsername = localStorage.getItem('username');
const storagedRole = localStorage.getItem('role');
// 모든 게시물 요소를 가져옴
const post = document.getElementById('board_detail');
const editBtn = document.getElementById("editBtn");

const ubno = ${ubno};

// 게시글 디테일 불러오기
$(document).ready(function(){
	$.ajax({
		type: 'GET',
		url: 'http://localhost:9001/api/v1/user/community-board/'+ubno,
		headers: {
			"jwtToken" : localStorage.getItem("jwtToken"),
            "username" : localStorage.getItem("username"),
            "role" : localStorage.getItem("role")
		},
		//data: { ubno: "job_hunting"},
		dataType: 'json',
		success: function(data){
			$(data).empty();
			writer = data.user.username;
			if (data !== null) {
				let str = '';
				str += '<tr><td>'+data.category +'</td></tr> '+ 
					'<tr><td>'+data.title + '</td></tr>'+
					'<tr><td>'+data.content + '</td></tr>'+
					'<tr><td>'+data.views +'</td></tr>'+
					'<tr><td id="writer">'+data.user.username+'</td></tr>'+
					'<tr><td>'+data.regdate + '</td></tr>';
				$('#data_board_detail').html(str);

		        if (storagedUsername == data.user.username || storagedRole === "ROLE_ADMIN") {
		            console.log("xxxx")
		            editBtn.style.display="block";
		   	 	};
			}
			// 초기 댓글 로드
			loadComments();
		},
		error:function(error){
			alert(error);
		}
	});

	// 게시글 수정버튼 클릭이벤트 핸들러 추가
	editBtn.addEventListener("click", function(){
		console.log("수정버튼 클릭")
		window.location.href = '/user/communityEdit?ubno='+ubno;
	})
	

	// 해당게시글에서 댓글작성 매서드
	$('#btn_postComment').click(function(event){
		event.preventDefault();
		
		var content = $('#input_reply_content').val();
		console.log("content :" +content)
		console.log("username :" +username)
		
		
		$.ajax({
			type: 'post',
			url: 'http://localhost:9001/api/v1/user/community-comment',
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
							str += '<tr class="replyItem"><td class="content">'+data.content+'</td>'+
								'<td>'+data.user.username+'</td>'+
								'<td>'+data.report+'</td>'+
								'<td>'+data.regdate+'</td>'+
								'<td><input type="button" class="btn_reply_report" onclick="replyReport(event)" value="신고"></td>'+
								'<td><input type="button" class="btn_reply_edit" onclick="openEditForm(event)" data-replyNo="'+ data.replyno +'" style="display: none;" value="댓글수정"></td></tr>';
						});
						
						$('#data_reply_detail').html(str);
						
						da.forEach(data =>{
							  $('#data_reply_detail .btn_reply_edit').each(function(index) {
	                                if (index === da.indexOf(data) && storagedUsername === data.user.username || storagedRole === "ROLE_ADMIN") {
	                                    $(this).css('display', 'block');
	                                }
	                          });
						})
					}
						
				},
				error: function(error){
					alert(error);
				}
			});
		}

		
		// 게시글 신고 기능
		$('#btn_commu_report').click(function(event){
			event.preventDefault();
			
			console.log("----------------"+ubno+"-----------------")
			$.ajax({
				type: 'post',
				url: 'http://localhost:9001/api/v1/user/community-report?ubno='+ubno,
				headers:{
					"jwtToken" : localStorage.getItem("jwtToken"),
		            "username" : localStorage.getItem("username"),
		            "role" : localStorage.getItem("role")
				},
			
				contentType: 'application/json; charset=utf-8',
				success: function(data){
					if(data === "게시글신고완료"){
						console.log(data);
						alert("게시글 신고 완료");
					}
				},
				error: function(xhr, status, error) {
					// 요청이 실패한 경우 처리할 코드
					console.error("Request failed with status code: " + xhr.status);
				}
					
			});
		});

});
	
	//댓글 신고 기능
	function replyReport(event){
		console.log("댓글 신고 -------------")	;
		
			event.preventDefault();
			
			console.log("----------------"+ubno+"-----------------")
			$.ajax({
				type: 'post',
				url: 'http://localhost:9001/api/v1/user/reply-report?ubno='+ubno,
				headers:{
					"jwtToken" : localStorage.getItem("jwtToken"),
		            "username" : localStorage.getItem("username"),
		            "role" : localStorage.getItem("role")
				},
			
				contentType: 'application/json; charset=utf-8',
				success: function(data){
					if(data === "댓글신고완료"){
						console.log(data);
						alert("댓글 신고 완료");
					};
				},
				error: function(xhr, status, error) {
					// 요청이 실패한 경우 처리할 코드
					console.error("Request failed with status code: " + xhr.status);
				}
					
			});
}
	
	
	// 댓글 수정 기능
	function openEditForm(event){
		
		let replyno = event.target.getAttribute("data-replyNo")
	
		const parentElement = event.target.parentElement.parentElement;
		//버튼 사라지게 처리해주기
		event.target.style.display="none";
		
		let editForm = document.createElement("span")
		editForm.innerHTML = "<input type='text' class='editContent' placeholder='수정하시오'><input type='button' class='editSubmit' value='수정'>";
		parentElement.append(editForm);
		//수정폼에 원래 댓글 컨텐트 넣어주기
		let content = parentElement.querySelector(".content").innerText;
		editForm.querySelector(".editContent").value = content;
		
		//수정버튼 클릭시에 db에 넣어주기
		editForm.querySelector(".editSubmit").addEventListener("click", function(){
			console.log("실행됩니다")	
			console.log(editForm.querySelector(".editContent").value)
			
			$.ajax({
				type: 'put',
				url: 'http://localhost:9001/api/v1/user/community-reply',
				headers:{
					"jwtToken" : localStorage.getItem("jwtToken"),
		            "username" : localStorage.getItem("username"),
		            "role" : localStorage.getItem("role")
				},
				data: JSON.stringify({
					content: editForm.querySelector(".editContent").value,
					replyno: replyno,
					ubno: ubno
				}),
				contentType: 'application/json; charset=utf-8',
				success: function(data){
					if(data === "댓글수정완료"){
						console.log(data);
						alert("댓글 수정 완료");
					};
					location.href="/user/communityDetail?ubno="+ubno;
				},
				error: function(xhr, status, error) {
					// 요청이 실패한 경우 처리할 코드
					console.error("Request failed with status code: " + xhr.status);
				}
					
			});
		})
		
	}
	
	
// 	// 댓글 수정버튼 클릭이벤트 핸들러 추가
// 	$('.btn_reply_edit').addEventListener("click", function(){
// 		console.log("댓글수정버튼 클릭")
// 		let str='';
// 		str += '<tr><td><input type="text" name="reply_content" id="reply_content"></td></tr>'+
// 				'<tr><td><input type="submit" id="reply_submit"></td></tr>';
				
// 		$('#reply_content').val() = $('#btn_postComment').val();
// 	});

	
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