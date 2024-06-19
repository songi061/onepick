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
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	<div class="sidebar">
	    <ul>
	        <li><a href="#">내가 쓴 글 목록</a></li>
	        <li><a href="#">내가 쓴 댓글 목록</a></li>
	    </ul>
	</div>
	
	<!-- 내가 쓴 글 목록 -->
	<div class="myBoard" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
		<table id="input_result">
			<thead>
				<tr>
					<th>카테고리</th>
					<th>게시글 번호</th>
					<th>제목</th>
				</tr>	
			</thead> 
			<tbody id="MyBoardTableBody">
			</tbody>
		</table>
	</div>
	
	<!-- 내가 쓴 댓글 목록 -->
	<div class="myBoard" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
		<table id="input_result">
			<thead>
				<tr>
					<th>댓글 번호</th>
					<th>내용</th>
				</tr>	
			</thead> 
			<tbody id="MyReplyTableBody">
			</tbody>
		</table>
	</div>
<script>
// 내가 쓴 게시물 조회
$(document).ready(function(){
	$.ajax({
		type: 'GET',
		url: 'http://localhost:9001/api/v1/user/community-myboard',
		headers:{
			"jwtToken" : localStorage.getItem("jwtToken"),
	        "username" : localStorage.getItem("username")
		},
		//data: {ubno: ubno}
		dataType: 'json',
		success: function(data){
			console.log(data);
			
			if (data !== null) {
				let str='';
				for(var i=0; i<data.length; i++){
					str += '<tr class="clickable" data-id="'+data[i].ubno+'"><td>'+data[i].category +'</td>' 
					+ '<td>'+data[i].ubno + '</td>'+'<td>'+data[i].title +'</td></tr>';
				}
				
				$('#MyBoardTableBody').html(str);
				
				// 행 클릭 시 상세 페이지로 이동
				$('.clickable').click(function(){
					let ubno = $(this).data('id');
				    console.log(ubno);
				    window.location.href = '/user/communityDetail?ubno=' + ubno;
				});
			}
		},
		error:function(error){
			alert(error);
		}
	});
});


//내가 쓴 댓글 조회
$(document).ready(function(){
	$.ajax({
		type: 'GET',
		url: 'http://localhost:9001/api/v1/user/community-comment',
		headers:{
			"jwtToken" : localStorage.getItem("jwtToken"),
	        "username" : localStorage.getItem("username")
		},
		data: {ubno: ubno}
		dataType: 'json',
		success: function(data){
			console.log(data);
			
			if (data !== null) {
				let str='';
				for(var i=0; i<data.length; i++){
					str += '<tr class="clickable" data-id="'+data[i].replyno+'"><td>'+data[i].category +'</td>' 
					+'<td>'+data[i].content +'</td></tr>';
				}
				
				$('#MyBoardTableBody').html(str);
				
				// 행 클릭 시 상세 페이지로 이동
				$('.clickable').click(function(){
					let ubno = $(this).data('id');
				    console.log(ubno);
				    window.location.href = '/user/communityDetail?ubno=' + ubno;
				});
			}
		},
		error:function(error){
			alert(error);
		}
	});
});
</script>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>