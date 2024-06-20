<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="/js/companyInterceptor.js"></script>	<!-- 기업+관리자만 허용 -->
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
		<button id="btn_commu_report" style="display: block;">신고</button>
	</div>
	<div class="edit">
		<button id="editBtn" style="display: none;">수정하기</button>
		<button id="deleteBtn" style="display:none;">삭제하기</button>
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
// 전역변수 --------------
// 로컬 스토리지에서 username을 가져옴
const storagedUsername = localStorage.getItem('username');
const storagedRole = localStorage.getItem('role');
console.log("xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"+storagedUsername)

// 모든 게시물 요소를 가져옴
const post = document.getElementById('board_detail');
const editBtn = document.getElementById("editBtn");
const boardDeleteBtn = document.getElementById("deleteBtn");
const boardReportBtn = document.getElementById("btn_commu_report");
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
			//const regdate = data.regdate;
			//const moddate = data.moddate;
			
			$(data).empty();
			writer = data.company.username;
			
			// 카테고리 한글로 바꿔서 나타내기
			if(data.category ==="freeBoard"){
				data.category = "자유글";
			
			}else if(data.category ==="information"){
				data.category = "정보공유";
			
			}else if(data.category ==="dispatch"){
				data.category = "파견";
				
			}else if(data.category ==="seminar"){
				data.category = "세미나";
			}
			
			// 날짜 형식 포맷하기
			const regdate = data.regdate ? new Date(data.regdate) : null;
            const moddate = data.moddate ? new Date(data.moddate) : null;
 
            let formattedDate = '';
            if (regdate) {
            	formattedDate = regdate.getFullYear() + '-' + ('0' + (regdate.getMonth() + 1)).slice(-2) + '-' + ('0' + regdate.getDate()).slice(-2);
            } else if (moddate) {
            	formattedDate = moddate.getFullYear() + '-' + ('0' + (moddate.getMonth() + 1)).slice(-2) + '-' + ('0' + moddate.getDate()).slice(-2);
            }
            
			if (data !== null) {
				let str = '';
				str += '<tr><td>'+data.category +'</td></tr> '+ 
					'<tr><td>'+data.title + '</td></tr>'+
					'<tr><td>'+data.content + '</td></tr>'+
					'<tr><td>'+data.views +'</td></tr>'+
					'<tr><td id="writer">'+data.company.username+'</td></tr>'+
					'<tr><td>'+formattedDate + '</td></tr>';
					
				$('#data_board_detail').html(str);
				
				// 수정&삭제 버튼이 나+관리자한테만 보이게
		        if (storagedUsername === writer || storagedRole === "ROLE_ADMIN") {
		            console.log(storagedUsername === writer)
		            editBtn.style.display="block";
		            boardDeleteBtn.style.display="block";
		   	 	}
		   	 	
		   		// 게시글 신고 버튼이 내가 쓴 글에는 안보이게
		   	 	if(storagedUsername === writer){
		   	 		boardReportBtn.style.display="none";
		   	 	
		   	 	}
			};
			// 초기 댓글 로드
			loadComments();
		},
		error:function(error){
			alert(error);
		}
	});

	// 게시글 삭제 기능
	deleteBtn.addEventListener('click', function(event){
		console.log("xxx삭제 버튼 클릭 됨xxx");
		console.log(cbno);
		event.preventDefault();
		
		if(confirm("이 게시글을 삭제하시겠습니까?")){
			$.ajax({
				type: 'delete',
				url: 'http://localhost:9001/api/v1/company/community-board?cbno='+cbno,
				headers:{
					"jwtToken" : localStorage.getItem("jwtToken"),
	            	"username" : localStorage.getItem("username"),
	            	"role" : localStorage.getItem("role")
				},
				contentType: 'application/json; charset=utf-8',
				//dataType: 'json'
				success: function(data){
					if(data === "게시글 삭제 완료"){
						console.log(data);
						alert("게시글 삭제 완료");
						window.location.href='/company/communityList';
					}
				},
				error: function(xhr, status, error) {
					// 요청이 실패한 경우 처리할 코드
					console.error("Request failed with status code: " + xhr.status);
				}
				
			});
		}else {
			// 신고 취소 버튼 시 알림
			alert("삭제가 취소되었습니다.");
		}
		
	});

	
	//수정버튼 클릭이벤트 핸들러 추가
	editBtn.addEventListener("click", function(){
		console.log("수정버튼 클릭했다")
		window.location.href = '/company/communityEdit?cbno='+cbno;
	});

	// 해당게시글에서 댓글작성 매서드
	$('#btn_postComment').click(function(event){
		event.preventDefault();
		
		var content = $('#input_reply_content').val();
		console.log("content :" +content)
		console.log("username :" +username)
		
		$.ajax({
			type: 'post',
			url: 'http://localhost:9001/api/v1/company/community-comment',
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
				dataType: 'json',
				success: function(da){
					if(da !== null){
						let str = '';
						da.forEach(data =>{
							//const writer = data.company.username;
							console.log(data.replyno);
							str += '<tr class="replyItem"><td class="content">'+data.content+'</td>'+
								'<td>'+data.company.username+'</td>'+
								'<td>'+data.report+'</td>'+
								'<td>'+data.regdate+'</td>'+
								'<td><input type="button" class="btn_reply_report" onclick="replyReport(event)" value="신고"></td>'+
								'<td><input type="button" class="btn_reply_edit" onclick="openEditForm(event)" data-replyNo="'+ data.replyno +'" style="display: none;" value="댓글수정"></td>'+
								'<td><input type="button" class="btn_reply_delete" onclick="openDeleteForm(event)" data-replyNo="'+ data.replyno +'" style="display: none;" value="댓글삭제"></td></tr>';
						});
						$('#data_reply_detail').html(str);
					
						console.log(da);
						da.forEach(data =>{
							  $('#data_reply_detail .btn_reply_edit').each(function(index) {
		                          if (index === da.indexOf(data) && (storagedUsername === data.company.username || storagedRole === "ROLE_ADMIN")) {
		                              $(this).css('display', 'block');
		                          }
		                      });
						});
						
						// 관리자 + 내가 쓴 댓글에는 삭제 버튼 보이게 하기
						da.forEach(data => {
				        	$('#data_reply_detail .btn_reply_delete').each(function(index) {
				            	if (index === da.indexOf(data) && (storagedUsername === data.company.username || storagedRole === "ROLE_ADMIN")) {
				                	$(this).css('display', 'block');
				            	}
				            });
				        });
				     }
				},
				error: function(error){
					alert(error);
				}
			});
		}
		
		// 게시글 삭제 기능
		deleteBtn.addEventListener('click', function(event){
			console.log("xxx삭제 버튼 클릭 됨xxx");
			console.log(cbno);
			event.preventDefault();
			
			if(confirm("이 게시글을 삭제하시겠습니까?")){
				$.ajax({
					type: 'delete',
					url: 'http://localhost:9001/api/v1/company/community-board?cbno='+cbno,
					headers:{
						"jwtToken" : localStorage.getItem("jwtToken"),
		            	"username" : localStorage.getItem("username"),
		            	"role" : localStorage.getItem("role")
					},
					contentType: 'application/json; charset=utf-8',
					//dataType: 'json'
					success: function(data){
						if(data === "게시글 삭제 완료"){
							console.log(data);
							alert("게시글 삭제 완료");
							window.location.href='/company/communityList';
						}
					},
					error: function(xhr, status, error) {
						// 요청이 실패한 경우 처리할 코드
						console.error("Request failed with status code: " + xhr.status);
					}
					
				});
			}else {
				// 신고 취소 버튼 시 알림
				alert("삭제가 취소되었습니다.");
			}
			
		});
		
		
		// 게시글 신고 기능
		$('#btn_commu_report').click(function(event){
			event.preventDefault();
			
			if(confirm("이 게시글을 신고하시겠습니까?")){
				$.ajax({
					type: 'post',
					url: 'http://localhost:9001/api/v1/company/community-report?cbno='+cbno,
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
			}else {
				// 신고 취소 버튼 시 알림
				alert("신고가 취소되었습니다.");
			}
			
		});
		
});
	
	//댓글 신고 기능
	function replyReport(event){
		event.preventDefault();
		
		$.ajax({
			type: 'post',
			url: 'http://localhost:9001/api/v1/company/reply-report?cbno='+cbno,
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
		
		let replyno = event.target.getAttribute("data-replyNo");
	
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
				url: 'http://localhost:9001/api/v1/company/community-reply',
				headers:{
					"jwtToken" : localStorage.getItem("jwtToken"),
		            "username" : localStorage.getItem("username"),
		            "role" : localStorage.getItem("role")
				},
				data: JSON.stringify({
					content: editForm.querySelector(".editContent").value,
					replyno: replyno,
					cbno: cbno
				}),
				contentType: 'application/json; charset=utf-8',
				success: function(data){
					if(data === "댓글수정완료"){
						console.log(data);
						alert("댓글 수정 완료");
					};
					location.href="/company/communityDetail?cbno="+cbno;
				},
				error: function(xhr, status, error) {
					// 요청이 실패한 경우 처리할 코드
					console.error("Request failed with status code: " + xhr.status);
				}
					
			});
		})
		
	}
	
	// 댓글 삭제 기능
	function openDeleteForm(event){
		event.preventDefault();
		let replyno = event.target.getAttribute("data-replyNo");
		if(confirm("이 댓글을 삭제하시겠습니까?")){
			$.ajax({
				type: 'delete',
				url: 'http://localhost:9001/api/v1/company/community-reply?replyno='+replyno,
				headers:{
					"jwtToken" : localStorage.getItem("jwtToken"),
	            	"username" : localStorage.getItem("username"),
	            	"role" : localStorage.getItem("role")
				},
				contentType: 'application/json; charset=utf-8',
				//dataType: 'json'
				success: function(data){
					if(data === "댓글 삭제 완료"){
						console.log(data);
						alert("댓글 삭제 완료");
						location.href="/company/communityDetail?cbno="+cbno;
					}
				},
				error: function(xhr, status, error) {
					// 요청이 실패한 경우 처리할 코드
					console.error("Request failed with status code: " + xhr.status);
				}

			});
		}else {
			// 신고 취소 버튼 시 알림
			alert("삭제가 취소되었습니다.");
		}
	
	}
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