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
	<!-- 내가 쓴 댓글 목록 -->
	<div id="myReplies" class="myBoard" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
		<table id="replyTable">
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
</div>
<script>
//내가 쓴 댓글 목록 조회 함수
$(document).ready(function(){
	//let ubno = new URLSearchParams(window.location.search).get('ubno');
	
	$.ajax({
		type: 'GET',
		url: 'http://localhost:9001/api/v1/user/community-comment',
		headers:{
			"jwtToken" : localStorage.getItem("jwtToken"),
	        "username" : localStorage.getItem("username")
		},
		dataType: 'json',
		success: function(data){
			console.log(data);
			
			if (data !== null) {
				let str='';
				for(var i=0; i<data.length; i++){
					str += '<tr class="clickable" data-id="'+data[i].userBoard.ubno+'"><a href="/user/communityDetail?ubno='+data[i].userBoard.ubno+'">클릭</a><td>'+data[i].userBoard.ubno+'"></td>' 
					+'<td>'+data[i].content +'</td></tr>';
					
					// 행 클릭 시 상세 페이지로 이동
// 					$('.clickable').click(function(){
// 						ubno = $(this).data('id');
// 					    console.log(ubno);
// 					    window.location.href = '/user/communityDetail?ubno=' + ;
// 					});
					
					
				}
				
				$('#MyReplyTableBody').html(str);
				
			}
		},
		error:function(error){
			console.error(error);
		}
	});
	
});

</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>